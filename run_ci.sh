#!/bin/bash

# Define variables for Verilator installation
VERILATOR_REPO="https://github.com/verilator/verilator.git"
VERILATOR_BRANCH="master"
VERILATOR_HASH="v5.008"
VERILATOR_INSTALL_DIR="$HOME/tools/verilator-$VERILATOR_HASH"
VERILATOR_BUILD_DIR="$VERILATOR_INSTALL_DIR/build-$VERILATOR_HASH"

# Install Verilator if not already installed
if [ ! -f "$VERILATOR_INSTALL_DIR/bin/verilator" ]; then
    echo "Building and installing Verilator..."
    mkdir -p "$VERILATOR_BUILD_DIR"
    cd "$VERILATOR_BUILD_DIR" || exit
    sudo apt-get install -y verilator 
else
    echo "Verilator is already installed at $VERILATOR_INSTALL_DIR"
fi

# Add Verilator bin directory to PATH
export PATH="$VERILATOR_INSTALL_DIR/bin:$PATH"

# Define paths for your Verilog project
VERILOG_FILE="arithunit.v"

# Step 1: Lint Verilog Files
echo "Running Verilator lint on $VERILOG_FILE..."
verilator --lint-only sources_1/new/"$VERILOG_FILE" 2>&1 | tee lint_output.log

# Notify completion
echo "Linting completed. Check lint_output.log for details."
