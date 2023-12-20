---
title: TP 4
subtitle: Université Toulouse Paul Sabatier
theme: laas
date: 2023-12-04
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/3A_SRI/d-tp-4.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/3A_SRI/d-tp-4.pdf)

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
2023-2024/3A_SRI/d-tp-4.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/3A_SRI/d-tp-4.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## Proxy HTTP

<https://gitlab.laas.fr/gsaurel/teach/-/blob/main/src/proxy.py>

## Client C++

- <https://github.com/libcpr/cpr>
- <https://github.com/nlohmann/json>
- <https://eigen.tuxfamily.org>

## CMake

<https://gitlab.laas.fr/gsaurel/teach/-/blob/main/src/CMakeLists.txt>

```bash
# configure
cmake -B build -S . -DCMAKE_CXX_STANDARD=17
# compile
cmake --build build
# run
./build/low_level
```
