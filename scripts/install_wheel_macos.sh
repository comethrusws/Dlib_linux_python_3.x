#!/bin/bash

# dlib wheel installer for macOS
# downloads and installs the correct dlib wheel for your Mac

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

check_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        error "this script is for macOS only"
        info "for linux, use: scripts/install_wheel.sh"
        exit 1
    fi
}

detect_arch() {
    case $(uname -m) in
        x86_64) echo "x86_64" ;;
        arm64) echo "arm64" ;;
        *) error "unsupported architecture: $(uname -m)"; exit 1 ;;
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

check_homebrew() {
    if ! command -v brew &>/dev/null; then
        warn "homebrew not found - you may need to install it for build dependencies"
        info "visit: https://brew.sh"
        return 1
    fi
    return 0
}

install_dependencies() {
    info "checking build dependencies..."
    if check_homebrew; then
        info "homebrew detected"
        
        missing_deps=()
        for dep in cmake boost; do
            if ! brew list $dep &>/dev/null; then
                missing_deps+=($dep)
            fi
        done
        
        if [ ${#missing_deps[@]} -gt 0 ]; then
            warn "recommended dependencies not installed: ${missing_deps[*]}"
            echo "install with: brew install ${missing_deps[*]}"
        else
            success "all dependencies installed"
        fi
    fi
}

install_wheel() {
    local arch=$1
    local pyver=$2
    local tag="cp${pyver//.}"
    
    if [ "$arch" = "x86_64" ]; then
        platform="macosx_10_9_x86_64"
    else
        platform="macosx_11_0_arm64"
    fi
    
    local wheel="dlib-${VERSION}-${tag}-${tag}-${platform}.whl"

    local url="$REPO_URL/releases/download/v${VERSION}/${wheel}"
    if curl -s --head "$url" | head -n1 | grep -q "200 OK"; then
        info "downloading wheel from releases"
        curl -L -o "$wheel" "$url"
    else
        url="$REPO_URL/raw/main/$wheel"
        if curl -s --head "$url" | head -n1 | grep -q "200 OK"; then
            info "downloading wheel from repo root"
            curl -L -o "$wheel" "$url"
        else
            error "wheel not found for python $pyver on macOS $arch"
            info "you can build from source with: pip install dlib"
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
        warn "verification failed"
    fi
}

main() {
    info "dlib wheel installer for macOS"

    check_macos
    
    local arch=$(detect_arch)
    local pyver=$(detect_python)
    info "architecture: $arch"
    info "python version: $pyver"

    if [ "$arch" = "x86_64" ]; then
        info "detected: Intel Mac"
    else
        info "detected: Apple Silicon Mac"
    fi

    check_pip
    install_dependencies
    install_wheel "$arch" "$pyver"
    verify_install

    success "installation complete"
}

main "$@"
