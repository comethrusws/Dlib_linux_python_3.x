#!/bin/bash

# Test script to verify dlib build dependencies locally
# This can help debug build issues before running the full CI

echo "=== Testing dlib build environment ==="

# Check Python
echo "Python version:"
python3 --version || python --version

# Check CMake
echo "CMake version:"
cmake --version || cmake3 --version

# Check build tools
echo "Build tools:"
which gcc g++ make

# Check dependencies
echo "Checking system dependencies..."
if command -v apt-get &> /dev/null; then
    echo "Ubuntu/Debian system detected"
    dpkg -l | grep -E "(libboost|libopenblas|liblapack|libx11|libgtk|libavcodec|libjpeg|libpng|libtiff)" || echo "Some dependencies may be missing"
elif command -v yum &> /dev/null; then
    echo "CentOS/RHEL/Fedora system detected"
    rpm -qa | grep -E "(boost|openblas|lapack|libX11|gtk3|ffmpeg|libjpeg|libpng|libtiff)" || echo "Some dependencies may be missing"
elif command -v apk &> /dev/null; then
    echo "Alpine system detected"
    apk list | grep -E "(boost|openblas|lapack|libx11|gtk|ffmpeg|libjpeg|libpng|tiff)" || echo "Some dependencies may be missing"
fi

# Test dlib clone and basic setup
echo "Testing dlib clone..."
if [ ! -d "dlib_test" ]; then
    git clone https://github.com/davisking/dlib.git dlib_test
    cd dlib_test
    git checkout v19.24
    
    echo "Testing CMake configuration..."
    mkdir -p build_test
    cd build_test
    
    # Try to configure with CMake
    if command -v cmake3 &> /dev/null; then
        cmake3 ../tools/python -DPYTHON_EXECUTABLE=$(which python3) -DCMAKE_BUILD_TYPE=Release
    else
        cmake ../tools/python -DPYTHON_EXECUTABLE=$(which python3) -DCMAKE_BUILD_TYPE=Release
    fi
    
    echo "CMake configuration result: $?"
    
    cd ../..
    rm -rf dlib_test
fi

echo "=== Test complete ==="
