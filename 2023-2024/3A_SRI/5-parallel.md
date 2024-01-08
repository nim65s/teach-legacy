---
title: Parallel
subtitle: Université Toulouse Paul Sabatier
theme: laas
date: 2023-11-24
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/3A_SRI/5-parallel.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/3A_SRI/5-parallel.pdf)

### Under License

\centering

![CC](media/cc.png){width=1cm}
![BY](media/by.png){width=1cm}
![SA](media/sa.png){width=1cm}

<https://creativecommons.org/licenses/by-sa/4.0/>

## This presentation (continued)

### Source

\centering

[`https://gitlab.laas.fr/gsaurel/teach :
2023-2024/3A_SRI/5-parallel.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/3A_SRI/5-parallel.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

# Python

## Déjà vu

ref <https://github.com/nim65s/parallel-101>

# C++

## Threads

- `std::thread`, défini dans `#include <thread>`
- Prend une fonction et ses éventuels arguments dans le constructeur
- Se lance immédiatement «en arrière plan»
- Il est nécessaire d’attendre qu’il termine avec `.join()`

## Threads, example

```cpp
#include <chrono>
#include <iostream>
#include <thread>
auto f(const int n) {
    for (int i{0}; i < 2; i++) {
        std::this_thread::sleep_for(
                std::chrono::milliseconds{n});
        std::cout << "Thread " << n << std::endl;
    }
}
auto main() -> int {
    std::thread t1{f, 1};
    std::thread t2{f, 2};
    t1.join();
    t2.join();
    return 0;
}
```

## Jthreads (C++ 20)

À partir de C++20, le `.join()` peut être automatique en remplaçant `std::thread` par `std::jthread`

## Jthreads, example

```cpp
#include <chrono>
#include <iostream>
#include <thread>
auto f(const int n) {
    for (int i{0}; i < 2; i++) {
        std::this_thread::sleep_for(
                std::chrono::milliseconds{n});
        std::cout << "Thread " << n << std::endl;
    }
}
auto main() -> int {
    std::jthread t1{f, 1};
    std::jthread t2{f, 2};
    // RAII: 't1' & 't2' destroyed → '.join()'
    return 0;
}
```

## Échange de données

N’importe quel thread peut potentiellement accéder en lecture et/ou écriture à n’importe quelle donnée du programme.

Cela qui risque de poser de gros problèmes.

## Race condition

```cpp
int n{0};

auto writer() { n = 1; }
auto reader() { std::cout << n << std::endl; }

auto main() -> int {
    std::jthread t1{writer};
    std::jthread t2{reader};
    return 0;
}

// '0' or '1' could be printed
```

## Data corruption

```cpp
int n{0};

auto writer(const int data) { n = data; }

auto main() -> int {
    std::thread t1{writer, 2};
    std::thread t2{writer, 1000};
    t1.join();
    t2.join();
    std::cout << n << std::endl;
    return 0;
}

// '2', '1000', or plain gibberish could be printed
```

## Synchronisation

Pour éviter cela, il faut synchroniser les différents threads entre eux

. . .

- les `std::mutex` ne peuvent être verrouillés qu’une fois
- toute tentative de verrouillage par un autre thread est blocante

## Lock guard & Mutex, example

```cpp
#include <mutex>

std::mutex m;
int n{0};

auto writer(const int data) {
    std::lock_guard<std::mutex> lock{m};
    n = data;
    // RAII: 'lock' is destroyed → 'm' is released
}

auto main() -> int {
    // same as before
}
```

## Dead locks

Il faut quand même faire attention à leur utilisation:

- pour éviter d’attendre inutilement
- pour éviter un blocage définitif

## Dead locks, example

```cpp
std::mutex m, n;

auto f1() {
    std::lock_guard<std::mutex> lock_1{m};
    std::cout << "m locked" << std::endl;
    std::lock_guard<std::mutex> lock_2{n};
}
auto f2() {
    std::lock_guard<std::mutex> lock_1{n};
    std::cout << "n locked" << std::endl;
    std::lock_guard<std::mutex> lock_2{m};
}

auto main() -> int {
    // run f1 & f2 in different threads
}
```

## Shared mutex

On peut accéder à des données:

- soit de manière exclusive en écriture
- soit de manière concurente en lecture

## Shared mutex, example

```cpp
#include <shared_mutex>
const std::chrono::milliseconds one_ms{1};
std::shared_mutex m;
int n{0};

auto writer(const int data) {
    std::unique_lock<std::shared_mutex> lock{m};
    std::this_thread::sleep_for(one_ms);
    n = data;
    std::cout << "write " << data << std::endl;
}
auto reader() {
    std::shared_lock<std::shared_mutex> lock{m};
    std::this_thread::sleep_for(one_ms);
    std::cout << "read " << n << std::endl;
}
```

## Shared mutex use

```cpp
auto main() -> int {
    const auto a{std::chrono::steady_clock::now()};
    {
        std::jthread t1{writer, 1};
        std::jthread t2{reader};
        std::jthread t3{reader};
        std::jthread t4{writer, 4};
        std::jthread t5{reader};
        // RAII: end of scope → jthreads are joined
    }
    const auto b{std::chrono::steady_clock::now()};
    const std::chrono::duration<float> c{b - a};
    std::cout << c.count() << "s" << std::endl;;
    return 0;
}
```

## Atomic

Certains types de données sont "atomiques": y accéder en lecture ou en écriture est garanti thread-safe.

## Atomic, example

```cpp
#include <atomic>

std::atomic_int a{0};
int n{0};

auto f() {
    for (int i{0}; i < 10000; i++) { ++a; ++n; }
}
auto main() -> int {
    std::thread t1{f};
    std::thread t2{f};
    t1.join();
    t2.join();
    std::cout << a << " / " << n << std::endl;
    return 0;
}
```

## Bonus: Queue

On a vu que Python facilite l’échange de données dans un système concurrent avec des "Queues". C++ n’en a pas. Mais
une version simple est facile à faire

## Queue, example

```cpp
class IntQueue {
    std::mutex _m;
    std::queue<int> _q;
    auto push(const int& val) {
        std::lock_guard<std::mutex> lock(_m);
        _q.push(val);
    }
    auto pop() -> std::optional<int> {
        std::lock_guard<std::mutex> lock(_m);
        if (!_q.empty()) {
            int val = _q.front();
            _q.pop();
            return val;
        }
        return {};
    }
};
```

# OpenMP

## Parallel blocs

```cpp
#include <chrono>
#include <iostream>
#include <thread>
#include <omp.h>
const std::chrono::milliseconds one_ms{1};
auto main() -> int {
  const auto a{std::chrono::steady_clock::now()};
  #pragma omp parallel
  {
    std::this_thread::sleep_for(one_ms);
    std::cout << omp_get_thread_num() << std::endl;
  }
  const auto b{std::chrono::steady_clock::now()};
  const std::chrono::duration<float> c{b - a};
  std::cout << c.count() << "s" << std::endl;
  return 0;
}
```

## Parallel for

```cpp
auto main() -> int {
  const auto a{std::chrono::steady_clock::now()};
  #pragma omp parallel for
  for (int i=0; i < 100; i++)
  {
    std::this_thread::sleep_for(one_ms);
    std::cout << omp_get_thread_num()
        << " " << i << std::endl;
  }
  const auto b{std::chrono::steady_clock::now()};
  const std::chrono::duration<float> c{b - a};
  std::cout << c.count() << "s" << std::endl;;
  return 0;
}
```

## Critical

```cpp
auto main() -> int {
  const auto a{std::chrono::steady_clock::now()};
  int sum{0};
  #pragma omp parallel for
  for (int i=0; i < 100; i++)
  {
    std::this_thread::sleep_for(one_ms);
    #pragma omp critical
    sum += i;
  }
  const auto b{std::chrono::steady_clock::now()};
  const std::chrono::duration<float> c{b - a};
  std::cout << c.count() << "s" << std::endl;;
  std::cout << "sum: " << sum << std::endl;;
  return 0;
}
```
