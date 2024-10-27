#include <windows.h>
#include <iostream>
#include <vector>
#include <cstdlib> // Для rand() и srand()
#include <ctime>   // Для time()
#include <omp.h>

using namespace std;

// Размер квадратных матриц
int n = 50;
int border = 3000;


struct MatrixData {
    vector<vector<double>> first;
    vector<vector<double>> second;
    vector<vector<double>> result;
    int row;
    HANDLE mutex;

    MatrixData(int size) : first(size, vector<double>(size)), second(size, vector<double>(size)), result(size, vector<double>(size)), row(0) {
        mutex = CreateMutex(NULL, FALSE, NULL);
    }

    ~MatrixData() {
        CloseHandle(mutex);
    }
};

DWORD WINAPI MultRow(LPVOID lpParam) {
    MatrixData* data = (MatrixData*)lpParam;

    while (true) {
        // Захват mutex
        WaitForSingleObject(data->mutex, INFINITE);

        // Получаем индекс строки для вычисления
        int row = data->row;
        data->row++;

        // Освобождаем mutex для других потоков
        ReleaseMutex(data->mutex);

        // Если все строки обработаны, выходим
        if (row >= n) break;

        // Умножение строки матрицы first на матрицу second
        for (int j = 0; j < n; j++) {
            data->result[row][j] = 0;
            for (int k = 0; k < n; k++) {
                data->result[row][j] += data->first[row][k] * data->second[k][j];
            }
        }
    }

    return 0;
}

int main() {
    // Инициализация генератора случайных чисел
    srand(static_cast<unsigned int>(time(0)));
    setlocale(LC_CTYPE, "Russian");
    double maxBorder = INT32_MAX;
    double minBorder = -maxBorder;

    double simpleTime[100];
    double ompTime[100];
    double ourTime[100];

    for (; n <= border; n += 50) {
        // Создание объекта MatrixData с заданным размером
        MatrixData data(n);

        // Заполнение матриц first и second случайными числами (от 1 до 10)
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                data.first[i][j] = rand() * (maxBorder - minBorder) / RAND_MAX + minBorder;
                data.second[i][j] = rand() * (maxBorder - minBorder) / RAND_MAX + minBorder;
            }
        }

        // Создание потоков
        const int numThreads = 12;  // Количество потоков
        HANDLE threads[numThreads];

        double timer = omp_get_wtime();
        for (int i = 0; i < numThreads; i++) {
            threads[i] = CreateThread(NULL, 0, MultRow, &data, 0, NULL);
        }

        // Ожидание завершения потоков
        WaitForMultipleObjects(numThreads, threads, TRUE, INFINITE);
        ourTime[n / 50] = omp_get_wtime() - timer;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                data.result[i][j] = 0;
            }
        }

        timer = omp_get_wtime();
#pragma omp parallel for shared(data)
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    data.result[i][j] += data.first[i][k] * data.second[k][j];
                }
            }
        }
        ompTime[n / 50] = omp_get_wtime() - timer;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                data.result[i][j] = 0;
            }
        }

        timer = omp_get_wtime();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    data.result[i][j] += data.first[i][k] * data.second[k][j];
                }
            }
        }
        simpleTime[n / 50] = omp_get_wtime() - timer;
    }

    cout << "Время без распараллеливания";
    for (int i = 0; i < (int)border / 50; i++) {
        cout << simpleTime[i] << " ";
    }

    cout << endl << "Время OpenMP";
    for (int i = 0; i < (int)border / 50; i++) {
        cout << ompTime[i] << " ";
    }

    cout << endl << "Время наше";
    for (int i = 0; i < (int)border / 50; i++) {
        cout << ourTime[i] << " ";
    }
}