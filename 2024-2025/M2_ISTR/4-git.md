---
title: Git
subtitle: Université Toulouse Paul Sabatier - KEAT9AA1
theme: laas
date: 2024-09-03
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2024-2025/M2_ISTR/4-git.pdf`](https://homepages.laas.fr/gsaurel/teach/2024-2025/M2_ISTR/4-git.pdf)

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
2024-2025/M2_ISTR/4-git.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2024-2025/M2_ISTR/4-git.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

# Introduction

## `diff`

```
$ cat liste-v1.txt
1
2
3
$ cat liste-v2.txt
1
9
3
```

## `diff` (continued)

```diff
$ diff -u liste-v1.txt liste-v2.txt
--- liste-v1.txt
+++ liste-v2.txt
@@ -1,3 +1,3 @@
 1
-2
+9
 3
```

## `patch`

```
$ diff -u liste-v1.txt liste-v2.txt \
       >> v1-to-v2.patch
```

. . .

```
$ patch -i v1-to-v2.patch
patching file liste-v1.txt
```

. . .

```
$ cat liste-v1.txt
1
9
3

```

# Git Pratique

## `hello.py`

```
$ cat hello.py
```

```python
#!/usr/bin/env python

if __name__ == "__main__":
    print("hello")
```

. . .

```
$ git init
Dépôt Git vide initialisé
dans ~/code/mon-projet/.git/
```

## Status

```
$ git status
Sur la branche main

Aucun commit

Fichiers non suivis:
  (utilisez "git add <fichier>..." pour inclure dans
   ce qui sera validé)
	hello.py

aucune modification ajoutée à la validation mais des
fichiers non suivis sont présents
(utilisez "git add" pour les suivre)
```

## Add

```
$ git add hello.py
$ git status
Sur la branche main

Aucun commit

Modifications qui seront validées :
  (utilisez "git rm --cached <fichier>..."
   pour désindexer)
	nouveau fichier : hello.py
```

## Commit

```
$ git commit -m "hello world"
[main (commit racine) f5cc82f] hello world
 1 file changed, 4 insertions(+)
 create mode 100644 hello.py
```

## Second Commit

```
$ vim hello.py && cat hello.py
```

```python
#!/usr/bin/env python
"""Affiche "hello" sur la sortie standard."""

if __name__ == "__main__":
    print("hello")
```

. . .

```
$ git add hello.py
$ git commit -m "documentation"
[main 56148a5] documentation
 1 file changed, 1 insertion(+)
```

## Mode

```
$ chmod +x hello.py
$ git commit -am "executable"
[main ab3723c] executable
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 hello.py
```

## Remote

```
$ git remote add origin \
      https://github.com/nim65s/example.git
$ git push -u origin main
Énumération des objets: 8, fait.
Décompte des objets: 100% (8/8), fait.
Compression par delta en utilisant jusqu'à 4 fils d'exécution
Compression des objets: 100% (5/5), fait.
Écriture des objets: 100% (8/8), 803 octets | 200.00 Kio/s, fait.
Total 8 (delta 0), réutilisés 0 (delta 0), réutilisés du pack 0
To github.com:nim65s/example.git
 * [new branch]      main -> main
la branche 'main' est paramétrée pour suivre 'origin/main'.
```

## Clone

(sur un autre ordinateur / dans un autre dossier)

```
git clone https://github.com/nim65s/example.git
```


# Git Théorique

## Merci Matthieu :)

<https://homepages.laas.fr/matthieu/talks/git.pdf>

# Références

## Tutoriel en ligne

<https://learngitbranching.js.org/?locale=fr_FR>
