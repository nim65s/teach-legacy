---
title: Outils Python & C++
subtitle: Université Toulouse Paul Sabatier - KEAT9AA1
theme: laas
date: 2024-09-02
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2024-2025/M2_ISTR/3-outils.pdf`](https://homepages.laas.fr/gsaurel/teach/2024-2025/M2_ISTR/3-outils.pdf)

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
2024-2025/M2_ISTR/3-outils.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2024-2025/M2_ISTR/3-outils.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

# Vous

## Ergonomie

- hauteurs
- position
- distances

. . .

Adaptez votre environement

## Clavier

![bépo](media/bepo.png)
[`https://bépo.fr`](https://bepo.fr)

# Style

## Écrire du code lisible

> Code is read much more often than it is written

\hfill --- Guido Van Rossum


## PEP 8

[`https://peps.python.org/pep-0008/`](https://peps.python.org/pep-0008/)

```python
print ( "hello" )
```

. . .

```
╰─>$ flake8 hello-spaces.py
hello-spaces.py:1:6: E211 whitespace before '('
hello-spaces.py:1:8: E201 whitespace after '('
hello-spaces.py:1:16: E202 whitespace before ')'
```

## black

[`https://github.com/psf/black`](https://github.com/psf/black)

```
╰─>$ black hello-spaces.py
reformatted hello-spaces.py

All done!
1 file reformatted.
```

. . .

```diff
-print ( "hello" )
+print("hello")
```

## clang-format

[https://clang.llvm.org/docs/ClangFormat.html](https://clang.llvm.org/docs/ClangFormat.html)

```bash
╰─>$ clang-format -i QGVScene.cpp
```

```diff
-for( auto node : _nodes ) {
-  node->update_layout();
-}
+for (auto *node : _nodes) node->update_layout();
```

# Analyse Statique

## Mypy: motivation

```python
def add(a: int, b: int) -> int:
    """Performs addition on integers.

    >>> add(3, 4)
    7
    """
    return a + b


if __name__ == "__main__":
    import sys

    print(add(sys.argv[1], sys.argv[2]))
```

## Mypy

```
╰─>$ python add.py 3 4
34
```

. . .


```
╰─>$ mypy add.py
add.py:13: error: Argument 1 to "add" has incompatible
                  type "str"; expected "int"
add.py:13: error: Argument 2 to "add" has incompatible
                  type "str"; expected "int"
Found 2 errors in 1 file (checked 1 source file)
```

## pyupgrade

[https://github.com/asottile/pyupgrade](https://github.com/asottile/pyupgrade)

```diff
 class C(Base):
     def f(self):
-        super(C, self).f()
+        super().f()
```

. . .

En C++: `clang-tidy`

# Méta

## Éditeur de texte / IDE

Bring your own ;)

## pre-commit

[https://github.com/pre-commit/pre-commit](https://github.com/pre-commit/pre-commit)

```bash
╰─>$ cat .pre-commit-config.yaml
```

```yaml
repos:
-   repo: https://github.com/psf/black
    rev: 22.8.0
    hooks:
    -   id: black
-   repo: https://github.com/pre-commit/mirrors-clang-format
    rev: v14.0.6
    hooks:
    -   id: clang-format
```

## pre-commit: utilisation

[https://github.com/pre-commit/pre-commit](https://github.com/pre-commit/pre-commit)

```
╰─>$ pre-commit run -a
```

. . .

```
╰─>$ pre-commit install
```

## pre-commit CI

[https://pre-commit.ci/](https://pre-commit.ci/)


# Rust

## Ruff

- black + isort → ruff format
- flake8 + pyupgrade → ruff check

## uv

- pip → uv
