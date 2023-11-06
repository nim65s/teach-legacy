---
title: TP 2
subtitle: Université Toulouse Paul Sabatier - KEAT9TA1
theme: laas
date: 2023-10-06
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/M2_ISTR/b-tp-2.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/M2_ISTR/b-tp-2.pdf)

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
2023-2024/M2_ISTR/b-tp-2.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/M2_ISTR/b-tp-2.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## Configuration du projet

```bash
$ mkdir low_level
$ cd low_level
$ wget https://gitlab.laas.fr/gsaurel/teach\
       /-/raw/main/CMakeLists.txt
$ pip install cmake
```

## Début du projet

Créez de fichier `low_level.cpp` avec:

- Créez une `class Departement` avec les mêmes attributs que le modèle
- Donnez-lui un constructeur prenant directement les attributs
- Implémentez-lui une méthode d’affichage
- Créez une fonction principale, qui construit une instance et l’affiche

## Compilation du projet

```
$ cmake -B /tmp/build -S . -DCMAKE_CXX_STANDARD=17
$ cmake --build /tmp/build
$ /tmp/build/low_level
```

## Récupération des données

- Incluez `<cpr/cpr.h>`
- Faites une requette HTTP vers votre route pour un département

## Conversion des données

- Incluez `<nlohmann/json.hpp>`
- Parsez le texte JSON fourni dans la réponse HTTP

## Plus de constructeurs

- Ajoutez un constructeur prenant un paramètre `json data`
- Ajoutez un constructeur prenant un paramètre `int id`

## Plus de modèles

- Implémentez les autres modèles
- Utilisez `std::unique_ptr<>` pour les relations
- Utilisez `std::optional<>` pour les attributs non requis

## Extended (facultatif)

- Construisez toutes les données à partir d’un seul appel à l’API via le JSON étendu

## Ventes (facultatif)

- Envoyez des données JSON via un POST sur votre route `/vente` et vérifiez que les objets `Vente` sont correctement
  créés

## DRY (facultatif)

- Factorisez votre code Python & C++
