#!/bin/bash

# Define Verilator installation check functions
check_verilator_installed() {
    dpkg -l | grep -q 'verilator'  # Checks if Verilator is listed in the installed packages
}

# Install Verilator using apt-get if not already installed
if ! check_verilator_installed; then
    echo "Verilator not found. Installing using apt-get..."
    sudo apt-get update
    sudo apt-get install -y verilator
else
    echo "Verilator is already installed."
fi

# Define paths for your Verilog project
VERILOG_FILE="arithunit.v"
VERILOG_PATH="sources_1/new/$VERILOG_FILE"

# Check if the Verilog file exists
if [ ! -f "$VERILOG_PATH" ]; then
    echo "Error: Verilog file $VERILOG_PATH not found."
    exit 1
fi

# Step 1: Lint Verilog Files
echo "Running Verilator lint on $VERILOG_FILE..."
verilator --lint-only "$VERILOG_PATH" 2>&1 | tee lint_output.log

# Notify completion
echo "Linting completed. Check lint_output.log for details."
