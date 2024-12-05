---
title: TP 3
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
2024-2025/3A_SRI/c-tp-3.pdf`](https://nim65s.github.io/teach/2024-2025/3A_SRI/c-tp-3.pdf)

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
2024-2025/3A_SRI/c-tp-3.md`](https://github.com/nim65s/teach/-/blob/main/2024-2025/3A_SRI/c-tp-3.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## Interopérabilité C++ / Python: JSON

<https://docs.python.org/3/library/json.html>

## Sérialisation Python

Ajouter une méthode dans la class `Task`:

```python
def to_json(self) -> str:
```

## Désérialisation Python

Ajouter une méthode dans la class `Task`:

```python
@staticmethod
def from_json(text: str) -> "Task":
```

## Définir l’égalité

Ajouter une méthode dans la class `Task`:

```python
def __eq__(self, other: "Task") -> bool:
```

## Tester l’égalité

Écrire un test unitaire qui:

- instancie une première

    ```python
    a = Task()
    ```

- une seconde à partir de la sérialisation de la première

    ```python
    txt = a.to_json()
    b = Task.from_json(txt)
    ```

- puis s’assure que `a == b`
