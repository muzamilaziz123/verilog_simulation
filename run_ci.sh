#!/bin/bash

# Define the expected path for Verilator executable
VERILATOR_BIN="/usr/bin/verilator"
path="/mnt/c/Users/Muzamil Aziz/Desktop/Simulation/sim/verilog_simulation/verilog_simulation"


# Check if Verilator is installed and accessible
#if ! command -v verilator &> /dev/null; then
#if [ ! -f "$path/usr/bin/verilator" ]; then 
# echo "Verilator not found. Installing using apt-get..."
#    sudo apt-get update
#    sudo apt-get install -y verilator g++ make yosys
#else
 #   echo "Verilator is already installed."
#fi

cd "$path"
Verilator --version
# Define paths for your Verilog project
VERILOG_FILE="arithunit.v"
TB_VERILOG_FILE="tb_arithunit.cpp"
VERILOG_PATH="sources_1/new/$VERILOG_FILE"
TB_VERILOG_PATH="sim_1/new/$TB_VERILOG_FILE"

# Check if the Verilog file exists
if [ ! -f "$VERILOG_PATH" ]; then
    echo "Error: Verilog file $VERILOG_PATH not found."
    exit 1
fi

# Step 1: Lint Verilog Files
echo "Running Verilator lint on $VERILOG_FILE..."
verilator --lint-only "$VERILOG_PATH" 2>&1 | tee lint_output.log

# Step 2: Run Yosys for synthesis
echo "Running Yosys on $VERILOG_FILE..."
yosys -p "read_verilog $VERILOG_PATH; synth -top arithunit; write_verilog -noattr synthesized_arithunit.v" 2>&1 | tee yosys_output.log

# Step 3: Run Simulation with Verilator
echo "Running Simulation of $TB_VERILOG_FILE..."
verilator --cc "$VERILOG_PATH" --exe --build "$TB_VERILOG_PATH" 2>&1 | tee verilator_compile.log

# If the compilation was successful, run the simulation
if [ -f "./obj_dir/Varithunit" ]; then
    ./obj_dir/Varithunit 2>&1 | tee verilator_simulation.log
else
    echo "Error: Simulation executable not found. Check verilator_compile.log for errors."
fi

# Notify completion
echo "Process completed. Check logs for details."
