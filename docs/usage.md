# Installation Guide

This guide explains how to install prebuilt dlib wheels for Linux systems.

## Quick Installation

### Method 1: Direct Download from Repository

Download the Python 3.12 wheel directly from the repository root:

```bash
# For x86_64 systems
wget https://raw.githubusercontent.com/EqualByte/Dlib_linux_python_3.x/main/dlib-19.24-cp312-cp312-linux_x86_64.whl
pip install dlib-19.24-cp312-cp312-linux_x86_64.whl

# For aarch64 systems
wget https://raw.githubusercontent.com/EqualByte/Dlib_linux_python_3.x/main/dlib-19.24-cp312-cp312-linux_aarch64.whl
pip install dlib-19.24-cp312-cp312-linux_aarch64.whl
```

### Method 2: Using the Installation Script

Use our automated installation script:

```bash
curl -sSL https://raw.githubusercontent.com/EqualByte/Dlib_linux_python_3.x/main/scripts/install_wheel.sh | bash
```

### Method 3: From Releases

Download from the releases page for specific Python versions:

```bash
# Example for Python 3.9 on x86_64
pip install https://github.com/EqualByte/Dlib_linux_python_3.x/releases/download/v19.24/dlib-19.24-cp39-cp39-linux_x86_64.whl
```

## Supported Platforms

| Architecture | Python Versions | OS |
|-------------|----------------|-----|
| x86_64 | 3.7 - 3.14 | Linux |
| aarch64 | 3.7 - 3.14 | Linux |

## System Requirements

Before installing dlib, ensure you have the required system dependencies:

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

### Alpine Linux
```bash
sudo apk add --no-cache \
  boost-dev \
  openblas-dev \
  lapack-dev \
  libx11-dev \
  gtk+3.0-dev \
  ffmpeg-dev \
  libjpeg-turbo-dev \
  libpng-dev \
  tiff-dev
```

## Verification

After installation, verify that dlib is working correctly:

```python
import dlib
print(f"dlib version: {dlib.__version__}")

# Test face detection
detector = dlib.get_frontal_face_detector()
print("✓ dlib installed successfully!")
```

## Troubleshooting

### Import Errors
- Ensure all system dependencies are installed
- Reinstall the wheel after installing dependencies
- Check that your Python version matches the wheel

### Architecture Mismatch
Check your system architecture:
```bash
uname -m
```
Make sure to download the wheel for your architecture (x86_64 or aarch64).

### Python Version Mismatch
Check your Python version:
```bash
python --version
```
Download the wheel that matches your Python version.

### Common Issues

1. **"No module named 'dlib'"**: Install system dependencies first
2. **"ImportError: libboost_python"**: Install boost development libraries
3. **"undefined symbol"**: Architecture mismatch - download correct wheel

## Examples

See the `examples/` directory for working code samples:

- `basic_face_detection.py` - Simple face detection demo
- More examples coming soon...

## Building from Source

If you need a custom build or the prebuilt wheels don't work:

```bash
sudo apt-get install -y build-essential cmake libboost-all-dev
git clone https://github.com/davisking/dlib.git
cd dlib
python setup.py build
python setup.py install
```

## Support

- Issues: [GitHub Issues](https://github.com/EqualByte/Dlib_linux_python_3.x/issues)
- Documentation: [dlib.net](http://dlib.net/)
- Original dlib: [davisking/dlib](https://github.com/davisking/dlib)
