---
title: TP 3
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
2023-2024/3A_SRI/c-tp-3.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/3A_SRI/c-tp-3.pdf)

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
2023-2024/3A_SRI/c-tp-3.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/3A_SRI/c-tp-3.md)

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
@classmethod
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
    b = Task.from_json(t.to_json())
    ```

- puis s’assure que `a == b`
