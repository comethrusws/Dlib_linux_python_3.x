#!/bin/bash

# dlib wheel installation script
# Downloads and installs the correct dlib wheel for your system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/EqualByte/Dlib_linux_python_3.x"
VERSION="19.24"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to detect system architecture
detect_arch() {
    local arch=$(uname -m)
    case $arch in
        x86_64|amd64)
            echo "x86_64"
            ;;
        aarch64|arm64)
            echo "aarch64"
            ;;
        *)
            print_error "Unsupported architecture: $arch"
            print_error "Supported architectures: x86_64, aarch64"
            exit 1
            ;;
    esac
}

# Function to detect Python version
detect_python_version() {
    if command -v python3 &> /dev/null; then
        local version=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
        echo $version
    elif command -v python &> /dev/null; then
        local version=$(python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
        echo $version
    else
        print_error "Python not found. Please install Python 3.7 or later."
        exit 1
    fi
}

# Function to check if pip is available
check_pip() {
    if ! command -v pip &> /dev/null && ! command -v pip3 &> /dev/null; then
        print_error "pip not found. Please install pip."
        exit 1
    fi
}

# Function to install system dependencies
install_dependencies() {
    print_status "Checking system dependencies..."
    
    if command -v apt-get &> /dev/null; then
        print_status "Detected Debian/Ubuntu system"
        print_warning "You may need to install system dependencies manually:"
        echo "sudo apt-get update"
        echo "sudo apt-get install -y libboost-all-dev libopenblas-dev liblapack-dev libx11-dev libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev libatlas-base-dev"
    elif command -v yum &> /dev/null; then
        print_status "Detected CentOS/RHEL/Fedora system"
        print_warning "You may need to install system dependencies manually:"
        echo "sudo yum install -y boost-devel openblas-devel lapack-devel libX11-devel gtk3-devel ffmpeg-devel libjpeg-turbo-devel libpng-devel libtiff-devel atlas-devel"
    elif command -v apk &> /dev/null; then
        print_status "Detected Alpine Linux system"
        print_warning "You may need to install system dependencies manually:"
        echo "sudo apk add --no-cache boost-dev openblas-dev lapack-dev libx11-dev gtk+3.0-dev ffmpeg-dev libjpeg-turbo-dev libpng-dev tiff-dev"
    else
        print_warning "Unknown package manager. Please install dlib dependencies manually."
    fi
}

# Function to download and install wheel
install_wheel() {
    local arch=$1
    local python_version=$2
    
    # Convert Python version to wheel format (e.g., 3.12 -> cp312)
    local python_tag="cp${python_version//.}"
    
    local wheel_name="dlib-${VERSION}-${python_tag}-${python_tag}-linux_${arch}.whl"
    local wheel_url="${REPO_URL}/releases/download/v${VERSION}/${wheel_name}"
    
    print_status "Downloading wheel: $wheel_name"
    
    # Try to download from releases first
    if curl -s --head "$wheel_url" | head -n 1 | grep -q "200 OK"; then
        print_status "Found wheel in releases, downloading..."
        curl -L -o "$wheel_name" "$wheel_url"
    else
        # Fallback to repository root (for Python 3.12)
        local repo_wheel_url="${REPO_URL}/raw/main/${wheel_name}"
        print_status "Trying repository root..."
        if curl -s --head "$repo_wheel_url" | head -n 1 | grep -q "200 OK"; then
            print_status "Found wheel in repository root, downloading..."
            curl -L -o "$wheel_name" "$repo_wheel_url"
        else
            print_error "Wheel not found for Python $python_version on $arch"
            print_error "Available wheels:"
            print_error "- Check releases: $REPO_URL/releases"
            print_error "- Check repository root for Python 3.12 wheels"
            exit 1
        fi
    fi
    
    print_status "Installing wheel..."
    if command -v pip3 &> /dev/null; then
        pip3 install "$wheel_name"
    else
        pip install "$wheel_name"
    fi
    
    # Clean up
    rm -f "$wheel_name"
    
    print_success "dlib installed successfully!"
}

# Function to verify installation
verify_installation() {
    print_status "Verifying installation..."
    
    if python3 -c "import dlib; print(f'dlib version: {dlib.__version__}'); detector = dlib.get_frontal_face_detector(); print('✓ dlib working correctly!')" 2>/dev/null; then
        print_success "Installation verified successfully!"
    elif python -c "import dlib; print(f'dlib version: {dlib.__version__}'); detector = dlib.get_frontal_face_detector(); print('✓ dlib working correctly!')" 2>/dev/null; then
        print_success "Installation verified successfully!"
    else
        print_warning "Installation completed but verification failed."
        print_warning "This might be due to missing system dependencies."
        print_warning "Please install the required system libraries and try again."
    fi
}

# Main function
main() {
    print_status "dlib wheel installer"
    print_status "===================="
    
    # Detect system information
    local arch=$(detect_arch)
    local python_version=$(detect_python_version)
    
    print_status "Detected architecture: $arch"
    print_status "Detected Python version: $python_version"
    
    # Check prerequisites
    check_pip
    
    # Install dependencies info
    install_dependencies
    
    # Install wheel
    install_wheel "$arch" "$python_version"
    
    # Verify installation
    verify_installation
    
    print_success "Installation complete!"
    print_status "You can now use dlib in your Python projects."
}

# Run main function
main "$@"
