#!/bin/bash

# Define Verilator installation directory
VERILATOR_INSTALL_DIR="/usr/bin/verilator"

# Check if Verilator is installed and accessible
if ! command -v verilator &> /dev/null; then
    echo "Verilator not found. Installing using apt-get..."
    sudo apt-get update
    sudo apt-get install -y verilator
else
    echo "Verilator is already installed."
fi

# Update PATH if needed (typically not required for apt-get installs)
export PATH="/usr/bin:$PATH"

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
