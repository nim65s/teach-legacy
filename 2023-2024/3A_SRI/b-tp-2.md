---
title: TP 2
subtitle: Université Toulouse Paul Sabatier
theme: laas
date: 2023-11-06
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/3A_SRI/b-tp-2.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/3A_SRI/b-tp-2.pdf)

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
2023-2024/3A_SRI/b-tp-2.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/3A_SRI/b-tp-2.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## Python: Multiprocessing

<https://docs.python.org/3/library/multiprocessing.html>

## Architecture

![Boss / Manager / Minions / Task](media/architecture.png)

## Task: constructeur

```python
class Task:
    def __init__(self, identifier, size=None):
        self.identifier = identifier
        # choosee the size of the problem
        self.size = size or np.random.randint(
            300, 3_000
        )
        # Generate the input of the problem
        self.a = np.random.rand(self.size, self.size)
        self.b = np.random.rand(self.size)
        # prepare room for the results
        self.x = np.zeros((self.size))
        self.time = 0
```

## Task: runtime

```python
class Task:
    def __init__(self, identifier, size=None):
        ...

    def work(self):uiestauierst
        start = time.perf_counter()
        self.x = np.linalg.solve(self.a, self.b)
        self.time = time.perf_counter() - start
```
