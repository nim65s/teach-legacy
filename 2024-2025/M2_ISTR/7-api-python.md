---
title: API Design & use in Python
subtitle: Université Toulouse Paul Sabatier - KEAT9AA1
theme: laas
date: 2024-09-13
author: Guilhem Saurel
sansfont: Source Sans 3
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2024-2025/M2_ISTR/7-api-python.pdf`](https://homepages.laas.fr/gsaurel/teach/2024-2025/M2_ISTR/7-api-python.pdf)

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
2024-2025/M2_ISTR/7-api-python.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2024-2025/M2_ISTR/7-api-python.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## Pre-requisite: constructors & str

```python
class Point:
    def __init__(self, x: int, y: int):
        self.x = x
        self.y = y

    def __str__(self):
        return f"{self.x} {self.y}"


if __name__ == "__main__":
    p = Point(3, 4)
    print(p)
```

## Django

![Django](media/django.png){width=3cm}

[Django](https://www.djangoproject.com/)

. . .

### Quickstart


```
$ python -m venv venv
$ echo venv >> .gitignore
$ source venv/bin/activate
(venv) $ pip install django
(venv) $ django-admin startproject mysite
(venv) $ cd mysite
(venv) $ ./manage.py runserver
(venv) $ ./manage.py migrate
(venv) $ ./manage.py startapp election
```


# Models

## ORM

```python
# election/models.py
from django.db import models


class Election(models.Model):
    title = models.CharField(max_length=200)
    pub_date = models.DateTimeField()


class Candidate(models.Model):
    election = models.ForeignKey(
        Election,
        on_delete=models.CASCADE,
    )
    name = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
```

## Prepare your database

- add `election` in

```
(venv) $ ./manage.py makemigrations election
(venv) $ ./manage.py migrate
(venv) $ ./manage.py shell
```

## Interact with your database

```python
In [1]: from election.models import *

In [2]: from django.utils.timezone import now

In [3]: e = Election.objects.create(
    title="Qui est le meilleur chat ?",
    pub_date=now())

In [4]: Candidate.objects.create(
    election=e, name="Doc")
Out[4]: <Candidate: Candidate object (1)>

In [5]: Candidate.objects.create(
    election=e, Candidate="Pitre")
Out[5]: <Candidate: Candidate object (2)>
```

## Define better names

```python
# election/models.py
class Election(models.Model):
    ...
    def __str__(self):
        return self.title


class Candidate(models.Model):
    ...
    def __str__(self):
        return self.name

```

## Generate an admin UI

```python
# election/admin.py
from django.contrib import admin

from . import models

admin.site.register(models.Election)
admin.site.register(models.Candidate)
```

. . .

```
(venv) $ ./manage.py createsuperuser
(venv) $ ./manage.py runserver
```

# Views

## Election List & Detail View

```python
# election/views.py
from django.views.generic import DetailView, ListView
from .models import Election


class ElectionListView(ListView):
    model = Election

class ElectionDetailView(DetailView):
    model = Election
```

## Route some URLS to your views

```python
# mysite/urls.py
from election import views

urlpatterns = [
    path("admin/", admin.site.urls),
    path(
        "",
        views.ElectionListView.as_view(),
        name="elections",
    ),
    path(
        "election/<int:pk>",
        views.ElectionDetailView.as_view(),
        name="election",
    ),
]
```

## Candidate Detail View

```python
# election/views.py
class CandidateDetailView(DetailView):
    model = Candidate
```

```python
# election/urls.py
urlpatterns = [
    ...
    path(
        "candidate/<int:pk>",
        views.CandidateDetailView.as_view(),
        name="candidate",
    ),
]

```

## Let user vote

```python
# election/views.py
from django.views.generic import RedirectView
from django.views.generic.detail import SingleObjectMixin

class VoteView(SingleObjectMixin, RedirectView):
    model = Candidate

    def get_redirect_url(self, *args, **kwargs):
        candidate = self.get_object()
        candidate.votes += 1
        candidate.save()
        return f"/candidate/{candidate.id}"
```
