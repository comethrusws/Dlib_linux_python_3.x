#!/usr/bin/env python3
"""
Basic Face Detection Demo using dlib

This script demonstrates how to use dlib for face detection.
It creates a simple test image with rectangles and detects faces in it.

Requirements:
- dlib installed (use the wheels from this repository)
- numpy
- matplotlib (optional, for visualization)

Usage:
    python basic_face_detection.py
"""

import sys
import numpy as np

try:
    import dlib
    print(f"✓ dlib version: {dlib.__version__}")
except ImportError as e:
    print(f"✗ Error importing dlib: {e}")
    print("Please install dlib using one of the methods in the README.md")
    sys.exit(1)

try:
    import matplotlib.pyplot as plt
    import matplotlib.patches as patches
    HAS_MATPLOTLIB = True
except ImportError:
    HAS_MATPLOTLIB = False
    print("Note: matplotlib not available, skipping visualization")


def create_test_image():
    """Create a simple test image with some geometric shapes."""
    # Create a 400x400 image with a light background
    img = np.ones((400, 400, 3), dtype=np.uint8) * 240
    
    # Add some rectangles that might look like faces
    # Face-like rectangle 1
    img[50:150, 50:150] = [200, 180, 160]  # Skin color
    img[80:120, 80:120] = [100, 100, 100]  # Darker rectangle (eyes)
    
    # Face-like rectangle 2
    img[200:300, 200:300] = [180, 160, 140]  # Different skin color
    img[230:270, 230:270] = [80, 80, 80]     # Darker rectangle
    
    # Add some noise
    noise = np.random.randint(0, 50, img.shape, dtype=np.uint8)
    img = np.clip(img.astype(np.int16) - noise, 0, 255).astype(np.uint8)
    
    return img


def detect_faces(image):
    """Detect faces in the given image using dlib."""
    print("Initializing face detector...")
    
    # Get the frontal face detector
    detector = dlib.get_frontal_face_detector()
    
    print("Detecting faces...")
    
    # Convert image to grayscale for face detection
    if len(image.shape) == 3:
        gray = np.mean(image, axis=2).astype(np.uint8)
    else:
        gray = image
    
    # Detect faces
    faces = detector(gray)
    
    print(f"Found {len(faces)} face(s)")
    
    return faces


def visualize_results(image, faces):
    """Visualize the detection results."""
    if not HAS_MATPLOTLIB:
        print("Skipping visualization (matplotlib not available)")
        return
    
    fig, ax = plt.subplots(1, 1, figsize=(8, 8))
    ax.imshow(image)
    ax.set_title(f"Face Detection Results - Found {len(faces)} face(s)")
    
    # Draw rectangles around detected faces
    for i, face in enumerate(faces):
        rect = patches.Rectangle(
            (face.left(), face.top()),
            face.width(),
            face.height(),
            linewidth=2,
            edgecolor='red',
            facecolor='none',
            label=f'Face {i+1}' if i == 0 else ""
        )
        ax.add_patch(rect)
        
        # Add face number
        ax.text(face.left(), face.top()-5, f'Face {i+1}', 
                color='red', fontsize=12, fontweight='bold')
    
    ax.legend()
    ax.axis('off')
    
    plt.tight_layout()
    plt.show()


def print_face_info(faces):
    """Print information about detected faces."""
    if not faces:
        print("No faces detected.")
        return
    
    print("\nFace Detection Results:")
    print("-" * 30)
    
    for i, face in enumerate(faces):
        print(f"Face {i+1}:")
        print(f"  Position: ({face.left()}, {face.top()})")
        print(f"  Size: {face.width()} x {face.height()}")
        print(f"  Area: {face.width() * face.height()} pixels")
        print()


def main():
    """Main function to run the face detection demo."""
    print("dlib Face Detection Demo")
    print("=" * 30)
    
    # Create test image
    print("Creating test image...")
    test_image = create_test_image()
    print(f"Test image created: {test_image.shape}")
    
    # Detect faces
    faces = detect_faces(test_image)
    
    # Print results
    print_face_info(faces)
    
    # Visualize results
    visualize_results(test_image, faces)
    
    # Test basic dlib functionality
    print("\nTesting additional dlib functionality...")
    
    # Test shape predictor (if available)
    try:
        # This will fail if no shape predictor is available, which is expected
        predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")
        print("✓ Shape predictor functionality available")
    except:
        print("ℹ Shape predictor not available (this is normal)")
    
    # Test correlation tracker
    try:
        tracker = dlib.correlation_tracker()
        print("✓ Correlation tracker functionality available")
    except Exception as e:
        print(f"ℹ Correlation tracker test: {e}")
    
    print("\n✓ dlib installation test completed successfully!")
    print("You can now use dlib for your computer vision projects.")


if __name__ == "__main__":
    main()
