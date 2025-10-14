# installation guide

how to install prebuilt dlib wheels for linux.

## quick install

### direct download from repo

grab the python 3.12 wheel directly from the repo:

```bash
# x86_64
wget https://raw.githubusercontent.com/EqualByte/Dlib_linux_python_3.x/main/dlib-19.24-cp312-cp312-linux_x86_64.whl
pip install dlib-19.24-cp312-cp312-linux_x86_64.whl

# aarch64
wget https://raw.githubusercontent.com/EqualByte/Dlib_linux_python_3.x/main/dlib-19.24-cp312-cp312-linux_aarch64.whl
pip install dlib-19.24-cp312-cp312-linux_aarch64.whl
````

### installation script

use the automated installer:

```bash
curl -sSL https://raw.githubusercontent.com/EqualByte/Dlib_linux_python_3.x/main/scripts/install_wheel.sh | bash
```

### from releases

for other python versions, download from releases:

```bash
# python 3.9 x86_64 example
pip install https://github.com/EqualByte/Dlib_linux_python_3.x/releases/download/v19.24/dlib-19.24-cp39-cp39-linux_x86_64.whl
```

## supported platforms

| architecture | python versions | os    |
| ------------ | --------------- | ----- |
| x86_64       | 3.11 - 3.14     | linux |
| aarch64      | 3.11 - 3.14     | linux |

## system requirements

make sure your system has the necessary dependencies.

### ubuntu/debian

```bash
sudo apt-get update
sudo apt-get install -y \
  libboost-all-dev libopenblas-dev liblapack-dev libx11-dev libgtk-3-dev \
  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev \
  libx264-dev libjpeg-dev libpng-dev libtiff-dev libatlas-base-dev
```

### centos/rhel/fedora

```bash
sudo yum install -y \
  boost-devel openblas-devel lapack-devel libX11-devel gtk3-devel \
  ffmpeg-devel libjpeg-turbo-devel libpng-devel libtiff-devel atlas-devel
```

### alpine

```bash
sudo apk add --no-cache \
  boost-dev openblas-dev lapack-dev libx11-dev gtk+3.0-dev \
  ffmpeg-dev libjpeg-turbo-dev libpng-dev tiff-dev
```

## verify installation

```python
import dlib
print("dlib version:", dlib.__version__)

detector = dlib.get_frontal_face_detector()
print("dlib installed successfully")
```

## troubleshooting

* **import errors**: make sure system dependencies are installed, reinstall wheel if needed
* **architecture mismatch**: check `uname -m` and download correct wheel
* **python version mismatch**: check `python --version` matches the wheel

common errors:

* `no module named 'dlib'`: install system dependencies first
* `importerror: libboost_python`: install boost development libraries
* `undefined symbol`: wrong architecture, download correct wheel

## examples

see `examples/` for working demos:

* `basic_face_detection.py` - simple face detection example

## build from source

if prebuilt wheels don’t work or you need custom build:

```bash
sudo apt-get install -y build-essential cmake libboost-all-dev
git clone https://github.com/davisking/dlib.git
cd dlib
python setup.py build
python setup.py install
```

## support

* issues: [github issues](https://github.com/EqualByte/Dlib_linux_python_3.x/issues)
* documentation: [dlib.net](http://dlib.net/)
* original repo: [davisking/dlib](https://github.com/davisking/dlib)
