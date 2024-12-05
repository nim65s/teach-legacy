---
title: TP 4
subtitle: Université Toulouse Paul Sabatier
theme: laas
date: 2024-12-05
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://nim65s.github.io/teach/
2024-2025/3A_SRI/d-tp-4.pdf`](https://nim65s.github.io/teach/2024-2025/3A_SRI/d-tp-4.pdf)

### Under License

\centering

![CC](media/cc.png){width=1cm}
![BY](media/by.png){width=1cm}
![SA](media/sa.png){width=1cm}

<https://creativecommons.org/licenses/by-sa/4.0/>

## This presentation (continued)

### Source

\centering

[`https://github.com/nim65s/teach :
2024-2025/3A_SRI/d-tp-4.md`](https://github.com/nim65s/teach/-/blob/main/2024-2025/3A_SRI/d-tp-4.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## Proxy HTTP

<https://github.com/nim65s/teach/blob/main/src/proxy.py>

## Client C++

- <https://github.com/libcpr/cpr>
- <https://github.com/nlohmann/json>
- <https://eigen.tuxfamily.org>

## CMake

<https://gitlab.laas.fr/gsaurel/teach/-/blob/main/src/CMakeLists.txt>

```bash
# configure
cmake -B build -S .
# compile
cmake --build build
# run
./build/low_level
```
