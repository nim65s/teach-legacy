---
title: TP 1
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
2023-2024/3A_SRI/a-tp-1.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/3A_SRI/a-tp-1.pdf)

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
2023-2024/3A_SRI/a-tp-1.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/3A_SRI/a-tp-1.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## Pre-requis

- Git: `git version`
- Python: `python -V` (`python3` ?)
- Pip: `python -m pip -V`
- Venv: `python -m venv` (optionel)

## Création d’un projet

```bash
$ mkdir tp_multithreading
$ cd tp_multithreading
$ git init
$ python -m venv .venv
$ echo .venv >> .gitignore
$ source .venv/bin/activate
$ pip install -U pip
```

## Configuration d’un dépôt distant

- Créer **un compte** et **un dépôt/projet** sur github, puis

```bash
$ ssh-keygen -t ed25519
$ cat ~/.ssh/id_ed25519.pub
```

<https://github.com/settings/ssh/new>

## Publication du projet

```bash
$ git remote add origin \
    git@github.com:votre-nom/votre-dépôt.git
$ git add .
$ git commit -m "start project"
$ git branch -M main
$ git push -u origin main
```

## Configuration des outils

```bash
$ wget https://gitlab.laas.fr/gsaurel/teach\
       /-/raw/main/.pre-commit-config.yaml
$ pip install pre-commit
$ pre-commit install
$ echo '*.pyc' >> .gitignore
```

. . .

```bash
$ pre-commit run -a
$ git add .
$ git commit -m "setup tooling"
$ git push
```
