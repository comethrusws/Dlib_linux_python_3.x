## dlib python wheels

prebuilt python wheels for dlib on linux and macOS. fast installs, zero drama.

### what is dlib

dlib is a modern c++ toolkit with machine learning and computer vision tools. python bindings let you use it without touching c++.

### supported platforms

#### linux

- **architectures**: x86_64, aarch64
- **python versions**: 3.11 to 3.14

#### macOS

- **architectures**: x86_64 (Intel), arm64 (Apple Silicon)
- **python versions**: 3.10 to 3.13
- **macOS versions**: 10.9+ (Intel), 11.0+ (Apple Silicon)

### quick start

download a wheel from releases and install with pip:

#### linux

```bash
# python 3.11 x86_64
pip install dlib-19.24-cp311-cp311-linux_x86_64.whl

# python 3.12 aarch64
pip install dlib-19.24-cp312-cp312-linux_aarch64.whl

# python 3.13 x86_64
pip install dlib-19.24-cp313-cp313-linux_x86_64.whl
```

#### macOS

```bash
# python 3.12 intel mac
pip install dlib-19.24-cp312-cp312-macosx_10_9_x86_64.whl

# python 3.12 apple silicon
pip install dlib-19.24-cp312-cp312-macosx_11_0_arm64.whl
```

install directly from a release url:

```bash
pip install https://github.com/comethrusws/Dlib_linux_python_3.x/releases/download/manual-1/dlib-20.0.99-cp310-cp310-manylinux_2_39_x86_64.whl
```

automated installer (macOS):

```bash
curl -sSL https://raw.githubusercontent.com/comethrusws/Dlib_linux_python_3.x/main/scripts/install_wheel_macos.sh | bash
```

### system requirements

install runtime deps before installing the wheel.

#### ubuntu/debian

```bash
sudo apt-get update
sudo apt-get install -y \
  libboost-all-dev libopenblas-dev liblapack-dev libx11-dev \
  libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev \
  libv4l-dev libxvidcore-dev libx264-dev libjpeg-dev libpng-dev \
  libtiff-dev libatlas-base-dev
```

#### centos/rhel/fedora

```bash
sudo yum install -y \
  boost-devel openblas-devel lapack-devel libX11-devel gtk3-devel \
  ffmpeg-devel libjpeg-turbo-devel libpng-devel libtiff-devel atlas-devel
```

#### macOS

```bash
# install homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install dependencies (optional - wheels are self-contained)
brew install cmake boost openblas
```

**Note:** macOS wheels are self-contained with bundled dependencies, so you may not need to install additional packages.

### verify the install

```python
import dlib
print("dlib version:", dlib.__version__)

detector = dlib.get_frontal_face_detector()
print("dlib installed correctly")
```

### troubleshooting

- **import errors**: install runtime deps, then reinstall the wheel
- **arch mismatch**: wheel must match your CPU architecture

  ```bash
  # check your architecture
  uname -m
  # x86_64 = Intel Mac or Linux x86_64
  # arm64 = Apple Silicon Mac
  # aarch64 = Linux ARM64
  ```

- **python mismatch**: wheel must match `python --version`

  ```bash
  python --version
  ```

- **macOS platform error**: make sure you download the macOS wheel (macosx*\*), not linux wheel (linux*_ or manylinux\__)

### build from source (optional)

only needed if you require a custom build:

```bash
sudo apt-get install -y build-essential cmake libboost-all-dev
git clone https://github.com/davisking/dlib.git
cd dlib
python setup.py build
python setup.py install
```

### how releases work

tag the repo, ci builds wheels for all supported python versions and both architectures, uploads artifacts, and attaches them to the release:

```bash
git tag v19.24
git push origin v19.24
```

### license

dlib is distributed under its original license. see the license here: [https://github.com/davisking/dlib/blob/master/dlib/LICENSE.txt](https://github.com/davisking/dlib/blob/master/dlib/LICENSE.txt)

### links

- dlib repo: [https://github.com/davisking/dlib](https://github.com/davisking/dlib)
- docs: [http://dlib.net/](http://dlib.net/)
- python examples: [https://github.com/davisking/dlib/tree/master/python_examples](https://github.com/davisking/dlib/tree/master/python_examples)
