#!/bin/bash

# Define paths
VERILOG_FILE="arithunit.v"
TOP_MODULE="arithunit"
SIMULATION_DIR="/mnt/c/Users/Muzamil Aziz/Desktop/Simulation"

# Change directory to the simulation folder
cd "$SIMULATION_DIR" || exit

# Step 1: Lint Verilog Files
echo "Running Verilator lint on $VERILOG_FILE..."
verilator --lint-only "sources_1/new/$VERILOG_FILE" 2>&1 | tee lint_output.log

# Step 2: Run Yosys Synthesis
echo "Running Yosys synthesis on $VERILOG_FILE..."
yosys -p "read_verilog sources_1/new/$VERILOG_FILE; synth -top $TOP_MODULE; write_verilog -noattr synthesized_$VERILOG_FILE" 2>&1 | tee yosys_output.log

# Step 3: Run Verilator Simulation
echo "Running Verilator simulation on $VERILOG_FILE..."
verilator --cc "$VERILOG_FILE" --exe --build "sim_1/new/tb_$TOP_MODULE.cpp" 2>&1 | tee verilator_compile.log
./obj_dir/V"$TOP_MODULE" 2>&1 | tee verilator_simulation.log

# Notify completion
echo "CI tasks completed. Check log files for details."
