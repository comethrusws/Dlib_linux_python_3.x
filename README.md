# dlib Linux Python Wheels

Pre-built Python wheels for the dlib machine learning library on Linux systems. This repository provides ready-to-install wheels for multiple Python versions and architectures, eliminating the need for complex compilation from source.

## What is dlib?

dlib is a modern C++ toolkit containing machine learning algorithms and tools for creating complex software in C++ to solve real world problems. The Python bindings provide access to computer vision, machine learning, and data analysis capabilities without requiring C++ knowledge.

## Quick Installation

Download the appropriate wheel for your system from the [Releases](https://github.com/EqualByte/Dlib_linux_python_3.x/releases) page and install:

```bash
# For Python 3.9 on x86_64
pip install dlib-19.24-cp39-cp39-linux_x86_64.whl

# For Python 3.10 on aarch64
pip install dlib-19.24-cp310-cp310-linux_aarch64.whl

# For Python 3.11 on x86_64
pip install dlib-19.24-cp311-cp311-linux_x86_64.whl
```

## Supported Platforms

- **Architectures**: x86_64, aarch64
- **Python Versions**: 3.9, 3.10, 3.11
- **Operating System**: Linux

## System Requirements

Before installing dlib wheels, ensure your system has the following runtime dependencies:

### Ubuntu/Debian
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

### CentOS/RHEL/Fedora
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

## Installation Methods

### Method 1: Direct Wheel Installation
1. Visit the [Releases](https://github.com/EqualByte/Dlib_linux_python_3.x/releases) page
2. Download the wheel matching your Python version and architecture
3. Install using pip:
   ```bash
   pip install dlib-*-linux-*.whl
   ```

### Method 2: Using pip with GitHub Releases
```bash
pip install https://github.com/EqualByte/Dlib_linux_python_3.x/releases/download/v19.24/dlib-19.24-cp39-cp39-linux_x86_64.whl
```

## Verification

After installation, verify dlib is working correctly:

```python
import dlib
print(f"dlib version: {dlib.__version__}")

# Test basic functionality
detector = dlib.get_frontal_face_detector()
print("dlib installed successfully!")
```

## Building from Source

If you need to build dlib from source instead of using pre-built wheels:

```bash
# Install build dependencies
sudo apt-get install -y build-essential cmake libboost-all-dev

# Clone and build
git clone https://github.com/davisking/dlib.git
cd dlib
python setup.py build
python setup.py install
```

## Troubleshooting

### Import Errors
If you encounter import errors after installation, ensure all runtime dependencies are installed on your system.

### Architecture Mismatch
Make sure you download the wheel matching your system architecture. Check your architecture with:
```bash
uname -m
```

### Python Version Compatibility
Verify your Python version matches the wheel:
```bash
python --version
```

## Contributing

This repository automatically builds wheels using GitHub Actions. To trigger a new build:

1. Create a new tag: `git tag v19.24 && git push origin v19.24`
2. The CI will automatically build and release wheels for all supported platforms

## License

This project distributes dlib under its original license. See the [dlib license](https://github.com/davisking/dlib/blob/master/dlib/LICENSE.txt) for details.

## Links

- [dlib Official Repository](https://github.com/davisking/dlib)
- [dlib Documentation](http://dlib.net/)
- [dlib Python Examples](https://github.com/davisking/dlib/tree/master/python_examples)
