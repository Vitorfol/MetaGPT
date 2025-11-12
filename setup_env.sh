#!/usr/bin/env bash
set -euo pipefail

# setup_env.sh
# 1) install python3.11 + venv packages if missing (requires sudo)
# 2) create venv311
# 3) activate venv, upgrade pip and install package in editable mode

# Check for python3.11
if ! command -v python3.11 >/dev/null 2>&1; then
  echo "python3.11 not found. Installing system packages (requires sudo)..."
  sudo apt update
  sudo apt install -y python3.11 python3.11-venv python3.11-distutils
fi

# Create venv if missing
if [ ! -d "venv311" ]; then
  echo "Creating virtual environment venv311..."
  python3.11 -m venv venv311
else
  echo "Virtual environment venv311 already exists."
fi

# Activate venv in this script's subshell
# Using a subshell so that running this script does not leave the user's shell activated
. venv311/bin/activate

# Upgrade pip and install package editable
pip install --upgrade pip
pip install -e .

cat <<'EOF'

Setup complete.
To activate the virtual environment in your shell, run:

  source venv311/bin/activate

Then you can run the metagpt CLI (it will use the venv's interpreter):

  metagpt "your command here"

EOF
