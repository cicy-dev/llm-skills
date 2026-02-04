# Global Skill: Python Package Publishing

## Overview
This skill helps publish Python packages to PyPI with automated testing and validation.

## Files
- `~/publish-pip-package.sh` - Main publishing script

## Usage

### Basic Usage
```bash
# From your Python project directory
~/publish-pip-package.sh

# Or specify project directory
~/publish-pip-package.sh /path/to/your/project
```

### Requirements
Your project must have:
- `pyproject.toml` file with package configuration
- Proper Python package structure

### What it does
1. **Validates environment** - Checks for pyproject.toml
2. **Sets up credentials** - Prompts for PyPI tokens if needed
3. **Builds package** - Creates wheel and source distributions
4. **Tests on TestPyPI** - Uploads and tests installation first
5. **Publishes to PyPI** - Final publication after confirmation
6. **Validates installation** - Tests the published package

### GitHub Integration
- Automatically sets GitHub secrets for CI/CD
- Works in both local and GitHub Actions environments
- Requires `gh` CLI for automatic secret management

### Token Setup
You'll need:
- TestPyPI API token from https://test.pypi.org/manage/account/token/
- PyPI API token from https://pypi.org/manage/account/token/

### Example Project Structure
```
your-project/
├── pyproject.toml
├── src/your_package/
│   ├── __init__.py
│   └── main.py
└── README.md
```

### Sample pyproject.toml
```toml
[build-system]
requires = ["setuptools>=45", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "your-package-name"
version = "1.0.0"
description = "Your package description"
authors = [{name = "Your Name", email = "your.email@example.com"}]
license = {text = "MIT"}
readme = "README.md"
requires-python = ">=3.7"
dependencies = [
    "click>=8.0.0",
]

[project.scripts]
your-command = "your_package.main:cli"
```

## Features
- ✅ Automated TestPyPI testing before production
- ✅ GitHub secrets management
- ✅ Installation validation
- ✅ Cross-platform support (Linux/macOS)
- ✅ Error handling and rollback
- ✅ Package name auto-detection

## Error Handling
- Validates project structure before starting
- Tests installation before final publication
- Provides clear error messages
- Safe rollback on failures

## Security
- Tokens stored in standard `.pypirc` format
- GitHub secrets set securely via CLI
- No tokens exposed in logs or output
