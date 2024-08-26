#!/bin/bash

# Define the expected path for Verilator executable
VERILATOR_BIN="/usr/bin/verilator"
verilator --version
# Check if Verilator is installed and accessible
if ! command -v verilator &> /dev/null; then
    echo "Verilator not found. Installing using apt-get..."
    sudo apt-get update
    sudo apt-get install -y verilator g++ make yosys
else
    echo "Verilator is already installed."
fi

# Define paths for your Verilog project
VERILOG_FILE="arithunit.v"
TB_VERILOG_FILE"tb_arithunit.cpp"
VERILOG_PATH="sources_1/new/$VERILOG_FILE"
TB_VERILOG_PATH = "sim_1/new/$TB_VERILOG_FILE"
# Check if the Verilog file exists
if [ ! -f "$VERILOG_PATH" ]; then
    echo "Error: Verilog file $VERILOG_PATH not found."
    exit 1
fi

# Step 1: Lint Verilog Files
echo "Running Verilator lint on $VERILOG_FILE..."
verilator --lint-only "$VERILOG_PATH" 2>&1 | tee lint_output.log

echo "Running yosys on $VERILOG_FILE..."
yosys -p "read_verilog $VERILOG_PATH; synth -top arithunit; write_verilog -noattr synthesized_arithunit.v" 2>&1 | tee yosys_output.log

verilator --cc "$VERILOG_FILE" --exe --build "$TB_VERILOG_FILE"2>&1 | tee verilator_compile.log
./obj_dir/V"$TOP_MODULE" 2>&1 | tee verilator_simulation.log



#verilator --cc "$VERILOG_FILE" --exe --build "sim_1/new/tb_$TOP_MODULE.cpp" 2>&1 | tee verilator_compile.log
#./obj_dir/V"$TOP_MODULE" 2>&1 | tee verilator_simulation.log

# Notify completion
echo "Linting completed. Check lint_output.log for details."
