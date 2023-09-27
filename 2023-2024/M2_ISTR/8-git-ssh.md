---
title: TP 1 - annexe git ssh
subtitle: Université Toulouse Paul Sabatier - KEAT9TA1
theme: laas
date: 2023-09-27
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/M2_ISTR/8-git-ssh.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/M2_ISTR/8-git-ssh.pdf)

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
2023-2024/M2_ISTR/8-git-ssh.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/M2_ISTR/8-git-ssh.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## clefs SSH

### Génération

```bash
$ ssh-keygen -t ed25519
```

(laisser le fichier par défaut)

### Ajout sur Github

```bash
$ cat ~/.ssh/id_ed25519.pub
```

<https://github.com/settings/ssh/new>

## Configurer git avec SSH

```bash
$ git remote set-url origin \
    git@github.com:votre-nom/votre-projet.git
```
