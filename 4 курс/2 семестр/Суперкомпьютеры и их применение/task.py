"""
Лабораторная работа №3
Изучение влияния параметров коммуникационной среды на производительность
распределенных параллельных программ

Задачи:
1. Измерение временных характеристик (латентность, пропускная способность) при передаче сообщений между двумя процессами с использованием MPI.
2. Измерение времени для копирования данных в оперативной памяти (локальное копирование) для сравнения с передачей сообщений.
3. Измерение временных характеристик коллективных операций: broadcast, scatter, gather.
4. Построение графиков зависимости времени от размера сообщения.

Для запуска: mpiexec -n *количество процессов* python task.py
"""


from mpi4py import MPI
import numpy as np
import matplotlib.pyplot as plt
import sys
import time

# Функция для измерения "ping-pong" обмена между двумя процессами.
def ping_pong_test(comm, iterations, message_size):
    rank = comm.Get_rank()
    # Партнер: если 0, то 1; если 1, то 0 (тест выполняется только между двумя процессами)
    partner = 1 if rank == 0 else 0
    # Создаем сообщение заданного размера (массив байт)
    data = np.empty(message_size, dtype=np.byte)
    # "Разогрев": несколько обменов без замеров
    for _ in range(10):
        if rank == 0:
            comm.Send([data, MPI.BYTE], dest=partner, tag=100)
            comm.Recv([data, MPI.BYTE], source=partner, tag=101)
        else:
            comm.Recv([data, MPI.BYTE], source=partner, tag=100)
            comm.Send([data, MPI.BYTE], dest=partner, tag=101)
    comm.Barrier()
    start = time.time()
    for _ in range(iterations):
        if rank == 0:
            comm.Send([data, MPI.BYTE], dest=partner, tag=100)
            comm.Recv([data, MPI.BYTE], source=partner, tag=101)
        else:
            comm.Recv([data, MPI.BYTE], source=partner, tag=100)
            comm.Send([data, MPI.BYTE], dest=partner, tag=101)
    end = time.time()
    # Возвращаем общее время обмена (round-trip)
    return end - start

# Функция для измерения времени broadcast операции.
def broadcast_test(comm, iterations, message_size):
    data = np.empty(message_size, dtype=np.byte)
    # Разогрев
    for _ in range(10):
        comm.Bcast(data, root=0)
    comm.Barrier()
    start = time.time()
    for _ in range(iterations):
        comm.Bcast(data, root=0)
    end = time.time()
    return end - start

# Функция для измерения времени scatter операции.
def scatter_test(comm, iterations, message_size):
    rank = comm.Get_rank()
    size = comm.Get_size()
    # На корневом процессе формируем общий буфер, разделённый на части
    sendbuf = np.empty(message_size * size,
                       dtype=np.byte) if rank == 0 else None
    recvbuf = np.empty(message_size, dtype=np.byte)
    # Разогрев
    for _ in range(10):
        comm.Scatter(sendbuf, recvbuf, root=0)
    comm.Barrier()
    start = time.time()
    for _ in range(iterations):
        comm.Scatter(sendbuf, recvbuf, root=0)
    end = time.time()
    return end - start

# Функция для измерения времени gather операции.
def gather_test(comm, iterations, message_size):
    rank = comm.Get_rank()
    size = comm.Get_size()
    sendbuf = np.empty(message_size, dtype=np.byte)
    recvbuf = np.empty(message_size * size,
                       dtype=np.byte) if rank == 0 else None
    # Разогрев
    for _ in range(10):
        comm.Gather(sendbuf, recvbuf, root=0)
    comm.Barrier()
    start = time.time()
    for _ in range(iterations):
        comm.Gather(sendbuf, recvbuf, root=0)
    end = time.time()
    return end - start

# Функция для измерения времени локального копирования данных
def local_copy_test(iterations, message_size):
    data = np.empty(message_size, dtype=np.byte)
    target = np.empty(message_size, dtype=np.byte)
    # Разогрев
    for _ in range(10):
        np.copyto(target, data)
    start = time.time()
    for _ in range(iterations):
        np.copyto(target, data)
    end = time.time()
    return end - start


def main():
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()

    # Для ping-pong теста требуется как минимум 2 процесса
    if size < 2:
        if rank == 0:
            print("Для выполнения теста необходимо минимум 2 процесса.")
        MPI.Finalize()
        sys.exit(1)

    # Задаем набор размеров сообщений (в байтах)
    message_sizes = [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
                     2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144,
                     524288, 1048576, 2097152]

    ITER_SMALL = 100000
    ITER_LARGE = 10000

    # для хранения (размер, средняя латентность, пропускная способность)
    pingpong_results = []
    copy_results = []      # для локального копирования

    # Выполняем тест "ping-pong" между процессами 0 и 1
    if rank in [0, 1]:
        for msize in message_sizes:
            iter_count = ITER_SMALL if msize <= 1024 else ITER_LARGE
            total_time = ping_pong_test(comm, iter_count, msize)
            # Среднее время одного обмена (одна сторона) = (round-trip time) / (2 * итераций)
            avg_time = total_time / (2 * iter_count)
            # Пропускная способность: размер/время (в байтах/сек), переводим в МБ/с
            bandwidth = (msize / avg_time) / \
                (1024 * 1024) if avg_time > 0 else 0
            if rank == 0:
                print(f"[Ping-Pong] Размер: {msize:7d} байт, Латентность: {avg_time*1e6:7.2f} мкс, "
                      f"Пропускная способность: {bandwidth:6.2f} МБ/с")
                pingpong_results.append((msize, avg_time, bandwidth))

    # Тест локального копирования (только на процессе 0)
    if rank == 0:
        for msize in message_sizes:
            iter_count = ITER_SMALL if msize <= 1024 else ITER_LARGE
            t_copy = local_copy_test(iter_count, msize)
            avg_copy_time = t_copy / iter_count
            print(
                f"[Local Copy] Размер: {msize:7d} байт, Время копирования: {avg_copy_time*1e6:7.2f} мкс")
            copy_results.append((msize, avg_copy_time))

    # Измерение collective операций (broadcast, scatter, gather)
    ITER_BCAST = 1000
    ITER_COLL = 1000

    bcast_results = []
    for msize in message_sizes:
        iter_count = ITER_BCAST if msize > 1024 else 10000
        t = broadcast_test(comm, iter_count, msize)
        avg_time = t / iter_count
        if rank == 0:
            print(
                f"[Broadcast] Размер: {msize:7d} байт, Время: {avg_time*1e6:7.2f} мкс")
            bcast_results.append((msize, avg_time))

    scatter_results = []
    for msize in message_sizes:
        iter_count = ITER_COLL if msize > 1024 else 10000
        t = scatter_test(comm, iter_count, msize)
        avg_time = t / iter_count
        if rank == 0:
            print(
                f"[Scatter]   Размер: {msize:7d} байт, Время: {avg_time*1e6:7.2f} мкс")
            scatter_results.append((msize, avg_time))

    gather_results = []
    for msize in message_sizes:
        iter_count = ITER_COLL if msize > 1024 else 10000
        t = gather_test(comm, iter_count, msize)
        avg_time = t / iter_count
        if rank == 0:
            print(
                f"[Gather]    Размер: {msize:7d} байт, Время: {avg_time*1e6:7.2f} мкс")
            gather_results.append((msize, avg_time))

    # Построение графиков (выполняется только процессом 0)
    if rank == 0:
        # Графики для ping-pong теста: латентность и пропускная способность
        sizes = [r[0] for r in pingpong_results]
        # перевод в микросекунды
        latencies = [r[1]*1e6 for r in pingpong_results]
        bandwidths = [r[2] for r in pingpong_results]

        plt.figure(figsize=(10, 8))
        plt.subplot(2, 1, 1)
        plt.plot(sizes, latencies, marker='o')
        plt.xlabel("Размер сообщения (байт)")
        plt.ylabel("Латентность (мкс)")
        plt.title("Зависимость латентности от размера сообщения (Ping-Pong)")
        plt.grid(True)

        plt.subplot(2, 1, 2)
        plt.plot(sizes, bandwidths, marker='o')
        plt.xlabel("Размер сообщения (байт)")
        plt.ylabel("Пропускная способность (МБ/с)")
        plt.title(
            "Зависимость пропускной способности от размера сообщения (Ping-Pong)")
        plt.grid(True)

        plt.tight_layout()
        plt.savefig("pingpong_results.png")
        plt.show()

        # График для сравнения локального копирования и MPI-передачи
        copy_sizes = [r[0] for r in copy_results]
        copy_times = [r[1]*1e6 for r in copy_results]
        # латентность как время передачи
        mpi_times = [r[1]*1e6 for r in pingpong_results]

        plt.figure()
        plt.plot(copy_sizes, copy_times, marker='o', label="Local Copy")
        plt.plot(copy_sizes, mpi_times, marker='x',
                 label="MPI Communication (Ping-Pong)")
        plt.xlabel("Размер сообщения (байт)")
        plt.ylabel("Время (мкс)")
        plt.title("Сравнение локального копирования и MPI-передачи")
        plt.legend()
        plt.grid(True)
        plt.savefig("copy_vs_mpi.png")
        plt.show()

        # Графики для collective операций: Broadcast, Scatter, Gather
        def plot_coll(results, op_name, filename):
            sizes = [r[0] for r in results]
            times = [r[1]*1e6 for r in results]
            plt.figure()
            plt.plot(sizes, times, marker='o')
            plt.xlabel("Размер сообщения (байт)")
            plt.ylabel("Время (мкс)")
            plt.title(f"{op_name}: Зависимость времени от размера сообщения")
            plt.grid(True)
            plt.savefig(filename)
            plt.show()

        plot_coll(bcast_results, "Broadcast", "broadcast_results.png")
        plot_coll(scatter_results, "Scatter", "scatter_results.png")
        plot_coll(gather_results, "Gather", "gather_results.png")


if __name__ == '__main__':
    main()
