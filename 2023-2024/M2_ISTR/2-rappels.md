---
title: Rappels Python & C++
subtitle: Université Toulouse Paul Sabatier - KEAT9TA1
theme: laas
date: 2023-09-11
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/M2_ISTR/2-rappels.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/M2_ISTR/2-rappels.pdf)

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
2023-2024/M2_ISTR/2-rappels.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/M2_ISTR/2-rappels.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

# Hello world

## Hello world: C++

```cpp
#include <iostream>
auto main() -> int {
  std::cout << "hello\n";
  return 0;
}
```

. . .

```
╰─>$ g++ hello.cpp && ./a.out
hello
```

## Hello world: Python

```python
#!/usr/bin/env python

if __name__ == "__main__":
    print("hello")
```

. . .

```
╰─>$ chmod +x hello.py && ./hello.py
hello
```

## Data types

### C++

```cpp
auto ga{3};                  // int
auto bu{3.14};               // double
const auto *const zo{"tau"}; // const char *const
std::string meu{"pi"};
```

. . .

### Python

```python
ga: int = 3
bu: float = 3.14
zo: str = "pi"
```

# Control flow

## Functions

### C++

```cpp
auto add(int first, int second) -> int {
  return first + second;
}
```

. . .

### Python

```python
def add(first: int, second: int) -> int:
    return first + second
```


## Conditions: C++

```cpp
if (temperature > 26) {
  std::cout << "Too hot\n";
  turn_cooler_on();
} else if (temperature < 16) {
  std::cout << "Too cold\n";
  turn_heater_on();
} else {
  std::cout << "Lucky people !\n";
}
```

## Conditions: Python

```python
if temperature > 26:
    print("Too hot")
    turn_cooler_on()
elif temperature < 16:
    print("Too cold")
    turn_heater_on()
else:
    print("Lucky people !")
```

## Loops: while

### C++

```cpp
auto user_input{0};
while (user_input != 42) {
  std::cout << "guess: ";
  std::cin >> user_input;
}
```

. . .

### Python

```python
user_input: int = 0
while user_input != 42:
    user_input = int(input("guess: "))
```

. . .

### Walrus

```python
while (user_input := int(input("guess: "))) != 42:
    print("it's not", user_input)
```

## Loops: break - C++

```cpp
auto user_input{0};
while (true) {
  std::cout << "guess: ";
  std::cin >> user_input;
  if (user_input == 42) {
    std::cout << "Yes !" << "\n";
    break;
  }
  std::cout << "I's not " << user_input << "\n";
}
```

## Loops: break - Python

```python
user_input: int = 0
while True:
    user_input = int(input("guess: "))
    if user_input == 42:
        print("Yes !")
        break
    print("It's not", user_input)
```

## Loops: for / break - C++

```cpp
#include <cstdlib>

for (auto i{0}; i < 10000; i++) {
  std::cout << "iteration " << i << "\n";
  auto rand = static_cast<double>(std::rand());
  if (rand / RAND_MAX > 0.95) {
    break;
  }
}
```


## Loops: for / break - Python

```python
from random import random

for i in range(10000):
    print("iteration", i)
    if random() > 0.95:
        break
```

## Loops: continue

### C++

```cpp
for (auto i{0}; i < 10; i++) {
  if (i % 2 == 0) {
    continue;
  }
  std::cout << "iteration " << i << "\n";
}
```

. . .

### Python

```python
for i in range(10):
    if i % 2 == 0:
        continue
    print("iteration", i)
```

## Loops: containers

### C++

```cpp
using Colors = std::vector<std::string>;
Colors colors{"orange", "blue", "pink"};
for (const auto &color: colors) {
  std::cout << color << "\n";
}
```

. . .

### Python

```python
colors = ["orange", "blue", "pink"]
for color in colors:
    print(color)
```

# Objects

## C++

```cpp

class Robot {
public:
  auto work() { battery -= 5; }
  auto get_battery() const -> int { return battery; }

protected:
  int battery{100};
};

auto main() -> int {
  auto robot = Robot{};
  std::cout << robot.get_battery() << "% remaining\n";
  robot.work();
  std::cout << robot.get_battery() << "% remaining\n";
  return 0;
}
```

## Python

```python
class Robot:
    battery = 100

    def work(self):
        self.battery -= 5

    def get_battery(self) -> int:
        return self.battery


if __name__ == "__main__":
    robot = Robot()
    print(robot.get_battery(), "% remaining")
    robot.work()
    print(robot.get_battery(), "% remaining")
```

## Inheritance: C++

```cpp

class LeggedRobot : public Robot {
public:
  auto walk() { battery -= 10; }
};

auto main() -> int {
  auto robot = LeggedRobot{};
  std::cout << robot.get_battery() << "% remaining\n";
  robot.work();
  robot.walk();
  std::cout << robot.get_battery() << "% remaining\n";
  return 0;
}
```

## Python

```python
class LeggedRobot(Robot):
    def walk(self):
        self.battery -= 10

if __name__ == "__main__":
    robot = LeggedRobot()
    print(robot.get_battery(), "% remaining")
    robot.work()
    robot.walk()
    print(robot.get_battery(), "% remaining")
```
