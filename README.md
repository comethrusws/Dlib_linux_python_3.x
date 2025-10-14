## dlib linux python wheels

prebuilt python wheels for the dlib library on linux. fast installs. zero drama.

### what is dlib

dlib is a modern c++ toolkit with machine learning and computer vision tools. the python bindings let you use it without touching c++.

### supported platforms

- **architectures**: x86_64, aarch64
- **python versions**: 3.7 to 3.14
- **os**: linux

### quick start

download a wheel from the releases page and install it with pip.

```bash
# python 3.9 on x86_64
pip install dlib-19.24-cp39-cp39-linux_x86_64.whl

# python 3.10 on aarch64
pip install dlib-19.24-cp310-cp310-linux_aarch64.whl

# python 3.11 on x86_64
pip install dlib-19.24-cp311-cp311-linux_x86_64.whl
```

to install straight from a release url:

```bash
pip install https://github.com/EqualByte/Dlib_linux_python_3.x/releases/download/v19.24/dlib-19.24-cp39-cp39-linux_x86_64.whl
```

### system requirements

install these runtime deps before installing the wheel.

#### ubuntu/debian
```bash
sudo apt-get update
sudo apt-get install -y \
  libboost-all-dev \
  libopenblas-dev \
  liblapack-dev \
  libx11-dev \
  libgtk-3-dev \
  libavcodec-dev \
  libavformat-dev \
  libswscale-dev \
  libv4l-dev \
  libxvidcore-dev \
  libx264-dev \
  libjpeg-dev \
  libpng-dev \
  libtiff-dev \
  libatlas-base-dev
```

#### centos/rhel/fedora
```bash
sudo yum install -y \
  boost-devel \
  openblas-devel \
  lapack-devel \
  libX11-devel \
  gtk3-devel \
  ffmpeg-devel \
  libjpeg-turbo-devel \
  libpng-devel \
  libtiff-devel \
  atlas-devel
```

### verify the install

```python
import dlib
print(f"dlib version: {dlib.__version__}")

detector = dlib.get_frontal_face_detector()
print("dlib installed correctly")
```

### troubleshooting

- **import errors**: install the runtime deps above, then reinstall the wheel.
- **arch mismatch**: your wheel must match `uname -m`.
  ```bash
  uname -m
  ```
- **python mismatch**: your wheel must match `python --version`.
  ```bash
  python --version
  ```

### build from source (optional)

use a wheel unless you need a custom build.

```bash
sudo apt-get install -y build-essential cmake libboost-all-dev
git clone https://github.com/davisking/dlib.git
cd dlib
python setup.py build
python setup.py install
```

### how releases work

tag the repo. ci builds wheels for all supported python versions and both arches, uploads artifacts, and attaches them to the release.

```bash
git tag v19.24
git push origin v19.24
```

### license

this project distributes dlib under its original license. see the dlib license for details: https://github.com/davisking/dlib/blob/master/dlib/LICENSE.txt

### links

- dlib repo: https://github.com/davisking/dlib
- docs: http://dlib.net/
- python examples: https://github.com/davisking/dlib/tree/master/python_examples
