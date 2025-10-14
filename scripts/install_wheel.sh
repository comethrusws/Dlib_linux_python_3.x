#!/bin/bash

# dlib wheel installer
# downloads and installs the correct dlib wheel for your system

set -e

REPO_URL="https://github.com/comethrusws/Dlib_linux_python_3.x"
VERSION="19.24"

# colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# output helpers
info() { echo -e "${BLUE}[info]${NC} $1"; }
success() { echo -e "${GREEN}[success]${NC} $1"; }
warn() { echo -e "${YELLOW}[warning]${NC} $1"; }
error() { echo -e "${RED}[error]${NC} $1"; }

detect_arch() {
    case $(uname -m) in
        x86_64|amd64) echo "x86_64" ;;
        aarch64|arm64) echo "aarch64" ;;
        *) error "unsupported architecture"; exit 1 ;;
    esac
}

detect_python() {
    if command -v python3 &>/dev/null; then
        python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
    elif command -v python &>/dev/null; then
        python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
    else
        error "python 3 not found"; exit 1
    fi
}

check_pip() {
    if ! command -v pip &>/dev/null && ! command -v pip3 &>/dev/null; then
        error "pip not found"; exit 1
    fi
}

install_dependencies() {
    info "checking system dependencies..."
    if command -v apt-get &>/dev/null; then
        info "debian/ubuntu detected"
        warn "make sure these are installed:"
        echo "sudo apt-get install -y libboost-all-dev libopenblas-dev liblapack-dev libx11-dev libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev libatlas-base-dev"
    elif command -v yum &>/dev/null; then
        info "centos/rhel/fedora detected"
        warn "make sure these are installed:"
        echo "sudo yum install -y boost-devel openblas-devel lapack-devel libX11-devel gtk3-devel ffmpeg-devel libjpeg-turbo-devel libpng-devel libtiff-devel atlas-devel"
    elif command -v apk &>/dev/null; then
        info "alpine detected"
        warn "make sure these are installed:"
        echo "sudo apk add --no-cache boost-dev openblas-dev lapack-dev libx11-dev gtk+3.0-dev ffmpeg-dev libjpeg-turbo-dev libpng-dev tiff-dev"
    else
        warn "unknown package manager, install dependencies manually"
    fi
}

install_wheel() {
    local arch=$1
    local pyver=$2
    local tag="cp${pyver//.}"
    local wheel="dlib-${VERSION}-${tag}-${tag}-linux_${arch}.whl"

    # try release
    local url="$REPO_URL/releases/download/v${VERSION}/${wheel}"
    if curl -s --head "$url" | head -n1 | grep -q "200 OK"; then
        info "downloading wheel from releases"
        curl -L -o "$wheel" "$url"
    else
        # fallback repo root (for 3.12)
        url="$REPO_URL/raw/main/$wheel"
        if curl -s --head "$url" | head -n1 | grep -q "200 OK"; then
            info "downloading wheel from repo root"
            curl -L -o "$wheel" "$url"
        else
            error "wheel not found for python $pyver on $arch"
            exit 1
        fi
    fi

    info "installing wheel..."
    if command -v pip3 &>/dev/null; then
        pip3 install "$wheel"
    else
        pip install "$wheel"
    fi

    rm -f "$wheel"
    success "dlib installed"
}

verify_install() {
    info "verifying installation..."
    if python3 -c "import dlib; dlib.get_frontal_face_detector()" &>/dev/null || python -c "import dlib; dlib.get_frontal_face_detector()" &>/dev/null; then
        success "installation verified"
    else
        warn "verification failed, check dependencies"
    fi
}

main() {
    info "dlib wheel installer"

    local arch=$(detect_arch)
    local pyver=$(detect_python)
    info "architecture: $arch"
    info "python version: $pyver"

    check_pip
    install_dependencies
    install_wheel "$arch" "$pyver"
    verify_install

    success "installation complete"
}

main "$@"
