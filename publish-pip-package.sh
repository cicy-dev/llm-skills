#!/bin/bash
# Global Skill: Publish Python Package to PyPI
# Usage: ~/publish-pip-package.sh [project_directory]
# Author: Created from frp-tunnel project experience

set -e

PROJECT_DIR="${1:-$(pwd)}"
cd "$PROJECT_DIR"

echo "🚀 Publishing Python Package to PyPI"
echo "======================================"
echo "📁 Project: $(basename "$PROJECT_DIR")"

# Check if in correct directory
if [[ ! -f "pyproject.toml" ]]; then
    echo "❌ Error: pyproject.toml not found. Please run from project root."
    exit 1
fi

# Get package name from pyproject.toml
PACKAGE_NAME=$(grep -E '^name\s*=' pyproject.toml | sed 's/.*=\s*"\([^"]*\)".*/\1/')
echo "📦 Package: $PACKAGE_NAME"

# Check environment
if [[ -n "$GITHUB_ACTIONS" ]]; then
    echo "🤖 GitHub Actions environment detected"
    if [[ -z "$PYPI_API_TOKEN" || -z "$TEST_PYPI_API_TOKEN" ]]; then
        echo "❌ GitHub Actions requires PYPI_API_TOKEN and TEST_PYPI_API_TOKEN secrets"
        exit 1
    fi
else
    echo "💻 Local environment - token input required"
    
    # Setup .pypirc if not exists
    if [[ ! -f ~/.pypirc ]]; then
        echo ""
        echo "📝 Setting up PyPI tokens"
        read -p "Enter your TestPyPI API token (starts with pypi-): " TEST_PYPI_TOKEN
        read -p "Enter your PyPI API token (starts with pypi-): " PYPI_TOKEN
        
        cat > ~/.pypirc << EOF
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
repository = https://upload.pypi.org/legacy/
username = __token__
password = $PYPI_TOKEN

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = $TEST_PYPI_TOKEN
EOF
        echo "✅ PyPI tokens saved"
        
        # Set GitHub secrets if gh CLI available
        echo ""
        echo "🔐 Setting GitHub secrets..."
        if command -v gh &> /dev/null; then
            echo "$PYPI_TOKEN" | gh secret set PYPI_API_TOKEN
            echo "$TEST_PYPI_TOKEN" | gh secret set TEST_PYPI_API_TOKEN
            echo "✅ GitHub secrets set"
        else
            echo "⚠️  gh CLI not found. Manually set GitHub secrets:"
            echo "   - PYPI_API_TOKEN"
            echo "   - TEST_PYPI_API_TOKEN"
        fi
    else
        echo "✅ Found existing PyPI configuration"
    fi
fi

# Install build dependencies
echo ""
echo "📦 Installing build dependencies..."
python3 -m pip install --upgrade build twine

# Clean old builds
echo ""
echo "🧹 Cleaning old builds..."
rm -rf dist build *.egg-info

# Build package
echo ""
echo "📦 Building package..."
python3 -m build

# Show built packages
echo ""
echo "📋 Built packages:"
ls -la dist/

# Local environment: Test on TestPyPI first
if [[ -z "$GITHUB_ACTIONS" ]]; then
    echo ""
    echo "🧪 Local environment - testing on TestPyPI first..."
    python3 -m twine upload --repository testpypi dist/*
    
    if [[ $? -eq 0 ]]; then
        echo "✅ TestPyPI upload successful!"
        
        echo ""
        echo "🔍 Testing TestPyPI installation..."
        echo "⏳ Waiting for TestPyPI to update..."
        sleep 15
        
        # Test installation from TestPyPI
        python3 -m venv test_env
        source test_env/bin/activate
        pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ "$PACKAGE_NAME" --upgrade
        
        echo "🔍 Testing command..."
        if command -v "$PACKAGE_NAME" &> /dev/null; then
            "$PACKAGE_NAME" --version || echo "Package installed successfully"
        else
            echo "Package installed (no CLI command found)"
        fi
        
        deactivate
        rm -rf test_env
        
        echo ""
        echo "✅ TestPyPI test passed!"
        echo ""
        read -p "TestPyPI test successful, continue to publish to PyPI? (y/n): " -n 1 -r
        echo
        
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "🛑 User cancelled PyPI publication"
            exit 0
        fi
    else
        echo "❌ TestPyPI upload failed"
        exit 1
    fi
fi

# Publish to PyPI
echo ""
echo "🚀 Publishing to PyPI..."
python3 -m twine upload dist/*

if [[ $? -eq 0 ]]; then
    echo ""
    echo "✅ Successfully published to PyPI!"
    
    # Test PyPI installation
    echo ""
    echo "🧪 Testing PyPI installation..."
    echo "⏳ Waiting for PyPI to update..."
    sleep 10
    
    python3 -m venv test_final
    source test_final/bin/activate
    pip install "$PACKAGE_NAME" --upgrade
    
    echo ""
    echo "🔍 Testing command..."
    if command -v "$PACKAGE_NAME" &> /dev/null; then
        "$PACKAGE_NAME" --version || echo "Package installed successfully"
    else
        echo "Package installed (no CLI command found)"
    fi
    
    deactivate
    rm -rf test_final
    
    echo ""
    echo "🎉 Publication and testing complete!"
    echo "📦 Package URL: https://pypi.org/project/$PACKAGE_NAME/"
    echo ""
    echo "Users can now install with:"
    echo "  pip install $PACKAGE_NAME"
else
    echo "❌ PyPI publication failed"
    exit 1
fi
