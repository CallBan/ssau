#include <iostream>
#include <ctime>
#include <cstdlib>
#include <vector>
#include <thread>
#include <future>
#include <omp.h>

using namespace std;

// Функция, выполняемая каждым потоком
void multiply_matrix_thread(int i, int j, int n,
    vector<vector<double>>& first,
    vector<vector<double>>& second,
    vector<vector<double>>& result) {
    for (int k = 0; k < n; k++) {
        result[i][j] += first[i][k] * second[k][j];
    }
}

int main() {
    setlocale(LC_CTYPE, "Russian");
    double maxBorder = INT32_MAX;
    double minBorder = -maxBorder;

    srand(time(NULL));

    double vedro = rand() * (maxBorder - minBorder) / RAND_MAX + minBorder;

    for (int n = 5; n <= 2000; n += 50) {
        vector <vector<double>> first(n, vector<double>(n));
        vector <vector<double>> second(n, vector<double>(n));
        vector <vector<double>> result(n, vector<double>(n));
        cout << "Размерность матриц - " << n << endl;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                first[i][j] = rand() * (maxBorder - minBorder) / RAND_MAX + minBorder;
                second[i][j] = rand() * (maxBorder - minBorder) / RAND_MAX + minBorder;
            }
        }

        // Параллельное вычисление с использованием std::thread
        double timer = omp_get_wtime();

        vector<future<void>> futures;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                futures.push_back(async(launch::async, multiply_matrix_thread, i, j, n, ref(first), ref(second), ref(result)));
            }
        }

        // Ожидание завершения всех потоков
        for (auto& f : futures) {
            f.wait();
        }

        cout << "\t" << "Время с распараллеливанием - " << omp_get_wtime() - timer << endl;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                result[i][j] = 0;
            }
        }

        timer = omp_get_wtime();
#pragma omp parallel for shared(first, second, result)
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    result[i][j] += first[i][k] * second[k][j];
                }
            }
        }
        cout << "\t" << "Время opemp без распараллеливания - " << omp_get_wtime() - timer << endl << endl;
    }
}

