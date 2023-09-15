---
title: Memory management in C++
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
2023-2024/M2_ISTR/5-memory-c++.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/M2_ISTR/5-memory-c++.pdf)

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
2023-2024/M2_ISTR/5-memory-c++.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/M2_ISTR/5-memory-c++.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

## From C structs

```c
struct Point {
  float x;
  float y;
};
```

. . .

```c
Point p = { .x = 12.2, .y = -22.7 };
```

## To C++ classes

```c++
class Point {
  float x;
  float y;
};
```

. . .

Except everything is private by default

. . .

- [C.2: Use `class` if the class has an invariant; use `struct` if the data members can vary independently](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rc-struct)
- [C.8: Use `class` rather than `struct` if any member is non-public](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rc-class)

## Encapsulation

```c++
class AxisAlignedRect {
  Point p1;
  Point p2;
  float area() {
    (p2.x - p1.x) * (p2.y - p1.y);
  }
};
```

. . .

Can't update `Point` to:

```cpp
class Point {
  float rho;
  float theta;
};
```

. . .

- [C.9: Minimize exposure of members](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rc-private)

## Initialisation: Constructors

```cpp

class PolarPoint {
  float rho;
  float theta;
public:
  PolarPoint(float r, float t) : rho{r}, theta{t} {}
  PolarPoint(float t) : rho{1}, theta{t} {}
  PolarPoint() : rho{1}, theta{0} {}
};
```

. . .

```cpp
const PolarPoint a{};
const PolarPoint b{1.12};
const PolarPoint c{3, M_PI_4};
```

## Destructors

```cpp
class MotorController {
  float speed;
public:
  void set_speed(float s) {
    speed = s;
    send_command();
  }
  ~MotorController() { set_speed(0); }
};

```

## Allocators

```cpp
class MyVector {
  int size, index;
  int* data;
public:
  MyVector() : size{10}, index{0}, data{new int[10]} {}
  ~MyVector() { delete[] data; }
  void push_back(int value) {
    if (index >= size) {
      int* next = new int[size * 2];
      for (int i{0};i<size;i++) next[i] = data[i];
      size *= 2;
      delete[] data;
      data = next;
    }
    data[index++] = value;
  };
};
```

## RAII: Resource Acquisition Is Initialization

### Bad

. . .

```cpp
void send(X* x, string_view destination) {
    auto port = open_port(destination);
    my_mutex.lock();
    // ...
    send(port, x);
    // ...
    my_mutex.unlock();
    close_port(port);
    delete x;
}
```

## RAII: Resource Acquisition Is Initialization

### Good

```cpp
class Port {
    PortHandle port;
public:
    Port(string_view destination) :
        port{open_port(destination)} { }
    ~Port() { close_port(port); }
    operator PortHandle() { return port; }

    // port handles can't usually be cloned
    // so disable copying and assignment
    Port(const Port&) = delete;
    Port& operator=(const Port&) = delete;
};
```

## RAII: Resource Acquisition Is Initialization

### Cleaned

```cpp
void send(unique_ptr<X> x, string_view destination)  {
    Port port{destination};
    lock_guard<mutex> guard{my_mutex};
    // ...
    send(port, x);
    // ...
}
```

. . .

- [R.1: Manage resources automatically using resource handles and RAII](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rr-raii)

## RAII Pointers

- Raw pointers: `T*`

. . .

- Smart pointers: `std::shared_ptr<T>`

. . .

- Unique pointers: `std::unique_ptr<T>`

## Smart Pointers example

```cpp
class Resource {
public:
  Resource() { std::cout << "Acquisition\n"; }
  ~Resource() { std::cout << "Destruction\n"; }
};
auto main() -> int {
  std::cout << "start\n";
  auto resource = std::make_shared<Resource>();
  std::cout << "end\n";
  return 0;
}
```

## Unique Pointers example

```cpp
void send(unique_ptr<X> x, string_view destination)  {
    Port port{destination};
    lock_guard<mutex> guard{my_mutex};
    // ...
    send(port, x);
    // ...
}
```

## Use them !

- [R.20: Use `unique_ptr` or `shared_ptr` to represent ownership](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rr-owner)

. . .

- [R.21: Prefer `unique_ptr` over `shared_ptr` unless you need to share ownership](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rr-unique)

## Friends

```cpp
class Point {
  float abs;
  float ord;
public:
  Point(float x, float y) : abs{x}, ord{y} {}
  friend std::ostream& operator<<(
          std::ostream& out, const Point& p) {
      return out << p.abs << " / " << p.ord;
  }
};

auto main() -> int {
    std::cout << Point{1, 2} << "\n";
    return 0;
}
```

## Const correctness


- [Con.1: By default, make objects immutable](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rconst-immutable)
- [Con.2: By default, make member functions `const`](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rconst-fct)
- [Con.3: By default, pass pointers and references to `const`s](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rconst-ref)
- [Con.4: Use `const` to define objects with values that do not change after construction](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#Rconst-const)
