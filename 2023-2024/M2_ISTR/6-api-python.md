---
title: API Design in Python
subtitle: Université Toulouse Paul Sabatier - KEAT9TA1
theme: laas
date: 2023-09-13
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/M2_ISTR/6-api-python.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/M2_ISTR/6-api-python.pdf)

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
2023-2024/M2_ISTR/6-api-python.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/M2_ISTR/6-api-python.md)

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

(you should work in a venv or similar)

```
$ pip install django
$ django-admin startproject mysite
$ cd mysite
$ ./manage.py runserver
```


# Models

## ORM

```python
# mysite/models.py
from django.db import models


class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField()


class Choice(models.Model):
    question = models.ForeignKey(
        Question,
        on_delete=models.CASCADE,
    )
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
```

## Prepare your database

```
$ ./manage.py makemigrations mysite
$ ./manage.py migrate
$ ./manage.py shell
```

## Interact with your database

```python
In [1]: from mysite.models import *

In [2]: from django.utils.timezone import now

In [3]: q = Question.objects.create(
    question_text="Ça va ?", pub_date=now())

In [4]: Choice.objects.create(
    question=q, choice_text="Oui")
Out[4]: <Choice: Choice object (1)>

In [5]: Choice.objects.create(
    question=q, choice_text="Non")
Out[5]: <Choice: Choice object (2)>
```

## Define better names

```python
# mysite/models.py
class Question(models.Model):
    ...
    def __str__(self):
        return self.question_text


class Choice(models.Model):
    ...
    def __str__(self):
        return self.choice_text

```

## Generate an admin UI

```python
# mysite/admin.py
from django.contrib import admin

from . import models

admin.site.register(models.Question)
admin.site.register(models.Choice)
```

. . .

```
$ ./manage.py createsuperuser
$ ./manage.py runserver
```

# Views

## Question List & Detail View

```python
# mysite/views.py
from django.views.generic import DetailView, ListView
from .models import Question


class QuestionListView(ListView):
    model = Question


class QuestionDetailView(DetailView):
    model = Question
```

## Route some URLS to your views

```python
# mysite/urls.py
from . import views

urlpatterns = [
    path("admin/", admin.site.urls),
    path(
        "questions/",
        views.QuestionListView.as_view(),
        name="questions",
    ),
    path(
        "questions/<int:pk>",
        views.QuestionDetailView.as_view(),
        name="question",
    ),
]
```

. . .

(You'll also need a template here, but this is not relevant here)

## Choice Detail View

```python
# mysite/views.py
class ChoiceDetailView(DetailView):
    model = Choice
```

```python
# mysite/urls.py
urlpatterns = [
    ...
    path(
        "choice/<int:pk>",
        views.ChoiceDetailView.as_view(),
        name="choice",
    ),
]

```

## Let user vote

```python
# mysite/views.py
from django.urls import reverse
from django.views.generic import RedirectView
from django.views.generic.detail import SingleObjectMixin

from .models import Choice, Question

class ChoiceDetailView(SingleObjectMixin, RedirectView):
    model = Choice

    def get_redirect_url(self, *args, **kwargs):
        choice = self.get_object()
        choice.votes += 1
        choice.save()
        return reverse("question", args=[choice.question.pk])
```
