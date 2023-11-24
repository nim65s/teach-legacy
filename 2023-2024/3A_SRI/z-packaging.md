---
title: "Bonus: Packaging"
subtitle: Université Toulouse Paul Sabatier
theme: laas
date: 2023-11-23
author: Guilhem Saurel
mainfont: Source Serif 4
monofont: Source Code Pro
---

## This presentation

### Available at

\centering

[`https://homepages.laas.fr/gsaurel/teach/
2023-2024/3A_SRI/z-packaging.pdf`](https://homepages.laas.fr/gsaurel/teach/2023-2024/3A_SRI/z-packaging.pdf)

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
2023-2024/3A_SRI/z-packaging.md`](https://gitlab.laas.fr/gsaurel/teach/-/blob/main/2023-2024/3A_SRI/z-packaging.md)

### Contact

\centering

Matrix: [@gsaurel:laas.fr](https://matrix.to/\#/@gsaurel:laas.fr)

Mail: [gsaurel@laas.fr](mailto::gsaurel@laas.fr)

# Filesystem Hierarchy Standard

## FHS

```
/
├── boot  # Static files of the boot loader
├── dev   # Device Files
├── etc   # System configuration
├── home
├── opt   # Add-on application packages
├── root
├── tmp
└── usr   # Second major section of the FS
```

## /usr

```
/
└── usr   # second major section of the FS
    ├── bin     # Most user commands
    ├── include # Standard include files
    ├── lib     # Libs for packages
    │   └── pkgconfig
    ├── local   # Local hierarchy
    ├── share   # Architecture-independent data
    │   └── doc
    ├── sbin    # Standard system binaries
    └── src     # Source code
```

## /opt

```
/
└── opt
    ├── openrobots
    │   ├── bin
    │   […]
    │   └── share
    └── ros
        └── rolling
            ├── bin
            ├── etc
            ├── include
            ├── lib 
            └── share
```

## Using those prefixes

```
PATH=/usr/bin
LD_LIBRARY_PATH
CMAKE_PREFIX_PATH
ROS_PACKAGE_PATH
PKG_CONFIG_PATH
PYTHONPATH
```

## Setting your environment

```bash
PREFIX=/opt/openrobots
export PATH=$PATH:$PREFIX/bin
export LD_LIBRARY_PATH=$PREFIX/lib
export CMAKE_PREFIX_PATH=$PREFIX
export ROS_PACKAGE_PATH=\
  $PREFIX/lib:$PREFIX/share
export PKG_CONFIG_PATH=\
  $PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig
```

## Setting your local environment

```bash
PREFIX=$HOME/.local
export PATH=$PATH:$PREFIX/bin
export LD_LIBRARY_PATH=$PREFIX/lib
export CMAKE_PREFIX_PATH=$PREFIX
export ROS_PACKAGE_PATH=\
  $PREFIX/lib:$PREFIX/share
export PKG_CONFIG_PATH=\
  $PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig
```

## Check it

```bash
$ which gepetto-gui
/opt/openrobots/bin/gepetto-gui
$ pkg-config --variable pcfiledir pinocchio
/opt/openrobots/lib/pkgconfig
$ ldd pinocchio_pywrap.cpython-310-x86_64-linux-gnu.so
	libeigenpy.so => /opt/openrobots/lib/libeigenpy.so
	libboost_python310.so.1.74.0 => /lib/x86_64-linux-gnu/libboost_python310.so.1.74.0
    […]
```

## Python

```bash
$ python -c 'import sys; sys.path'
['',
 '/usr/lib/python310.zip',
 '/usr/lib/python3.10',
 '/usr/local/lib/python3.10/dist-packages',
 '/usr/lib/python3/dist-packages']
$ echo \
 /opt/openrobots/lib/python3.10/site-packages > \
 /usr/lib/python3/dist-packages/robotpkg.pth
$ python -c 'import pinocchio; pinocchio.__file__'
'/opt/openrobots/lib/python3.10/site-packages/ \
    pinocchio/__init__.py'
```

## Scripts

```bash
$ source /opt/ros/rolling/setup.bash
$ source .venv/bin/activate
```

# Python

## Votre projet

```
corgi/
├── .gitignore
├── .gitlab-ci.yml
├── corgi/
│   ├── __init__.py
│   ├── cleaner.py
│   └── optimizer.py
├── LICENSE
├── pyproject.toml
└── tests/
    ├── __init__.py
    ├── test_cleaner.py
    └── test_optimizer.py
```

## `pyproject.toml`

```toml
[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"

[project]
name = "corgi"
version = "0.1.0"
dependencies = [
    "numpy",
    "httpx",
]
```

## Utilisation

```
$ python -m pip install \
    git+https://github.com/vous/corgi.git
```

. . .

```
$ python -m build
```

```
dist/
├── corgi-0.1.0-py3-none-any.whl
└── corgi-0.1.0.tar.gz
```

. . .

```
$ twine upload dist/*
$ pip install corgi
```

## Alternatives

- poetry
- pipenv
- pdm

. . .

- CMake

# C / C++

## Votre projet

```
cirgo/
├── .gitlab-ci.yml
├── CMakeLists.txt
├── include/
│   └── cirgo/
│       ├── cleaner.hpp
│       ├── fwd.hpp
│       └── optimizer.hpp
├── LICENSE
├── src/
│   ├── cleaner.cpp
│   └── optimizer.cpp
└── tests/
    └── CMakeLists.txt
```

## `CMakeLists.txt`

```cmake
cmake_minimum_required(VERSION 3.23)
project(cirgo VERSION 0.1.0 LANGUAGES CXX)
find_package(Eigen3 REQUIRED)
add_library(cirgo SHARED)
target_sources(cirgo PUBLIC FILE_SET public_headers
    TYPE HEADERS BASE_DIRS include
    FILES include/cirgo/fwd.hpp
    PRIVATE
    include/cirgo/optimizer.hpp
    include/cirgo/cleaner.hpp
    src/optimizer.cpp
    src/cleaner.cpp)
target_link_libraries(cirgo PRIVATE Eigen3::Eigen)
install(TARGETS cirgo FILE_SET public_headers)
add_subdirectory(tests)
```

## Configuration

```
$ cmake -B build -S .
-- The CXX compiler identification is GNU 13.2.1
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/g++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (0.5s)
-- Generating done (0.0s)
-- Build files have been written to: …/cirgo/build
```

## Compilation

```
$ cmake --build build
[ 33%] Build CXX object cirgo.dir/src/optimizer.cpp.o
[ 66%] Build CXX object cirgo.dir/src/cleaner.cpp.o
[100%] Link CXX shared library libcirgo.so
[100%] Built target cirgo
```

## Installation

```
$ cmake -DCMAKE_INSTALL_PREFIX=/tmp/pfx build
$ cmake --build build -t install
[100%] Built target cirgo
Install the project...
-- Install configuration: "Debug"
-- Installing: /tmp/pfx/lib/libcirgo.so
-- Installing: /tmp/pfx/include/cirgo/fwd.hpp

```

## Alternatives

- autotools
- meson
- bazel

# C++ & python

## Bindings python

- python C-api

. . .

- boost::python
- pybind11
- nanobind

## Packaging C++/Python with CMake & pip

https://github.com/cmake-wheel/cmeel
