---
title: "Bonus: Tests"
subtitle: Université Toulouse Paul Sabatier
theme: laas
date: 2023-11-23
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/3A_SRI/z-tests.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/3A_SRI/z-tests.pdf)

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
2023-2024/3A_SRI/z-tests.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/3A_SRI/z-tests.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

# Tests unitaires

## `unittest`: usage

```python
import unittest

class TestAddition(unittest.TestCase):
    def test_addition(self):
        self.assertEqual(1 + 1, 2)

if __name__ == '__main__':
    unittest.main()
```

## `unittest`: test your code

```python
import unittest

from my_lib import my_add

class TestMyAddition(unittest.TestCase):
    def test_my_addition(self):
        self.assertEqual(my_add(1, 1), 2)

if __name__ == '__main__':
    unittest.main()
```

## ` unittest`: autodiscovery

```
$ python -m unittest -v
test_addition (test_add.TestAddition.test_addition) \
    ... ok
test_my_addition (test_my_add.TestMyAddition \
    .test_my_addition) ... ok

-----------------------------------------------
Ran 2 tests in 0.000s

OK
```

# Tests des examples

## `doctest`: syntax

```python
def my_add(a: int, b: int) -> int:
    """Performs addition on integers.
    >>> my_add(3, 4)
    7
    """
    return a + b
```

## `doctest`: usage

```
$ python -m doctest my_lib.py -v
Trying:
    my_add(3, 4)
Expecting:
    7
ok
1 items had no tests:
    my_lib
1 items passed all tests:
   1 tests in my_lib.my_add
1 tests in 2 items.
1 passed and 0 failed.
Test passed.
```

# Tests intégratifs

## Concept

```python
import unittest

from my_robot import QuadrupedRobot

class TestMove(unittest.TestCase):
    def test_move(self):
        robot = QuadrupedRobot()
        robot.set_speed(1)  # m/s
        robot.simulate(10)  # s
        self.assertGreater(robot.get_z(), 0.1)
        self.assertGreater(robot.get_x(), 9)

if __name__ == '__main__':
    unittest.main()
```

# Intégration continue

## Github

`.github/workflows/test.yml` :

```yaml
name: run unittests & doctests
on: ["push"]
jobs:
  test:
    runs-on: "ubuntu-latest"
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v4
        with:
          python-version: 3.12
      - run: python -m unittest
      - run: python -m doctest my_lib.py
```

## Gitlab

`.gitlab-ci.yml` :

```yaml
test:
  image: ubuntu:22.04
  script:
    - apt update && apt install -qy python3
    - python -m unittest
    - python -m doctest my_lib.py
```

## Démo
