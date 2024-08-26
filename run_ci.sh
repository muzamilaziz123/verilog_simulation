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
	git install Verilator
    git clone $VERILATOR_REPO -b $VERILATOR_BRANCH .
    git checkout $VERILATOR_HASH
    autoconf && ./configure --prefix="$VERILATOR_INSTALL_DIR" && make -j$(nproc)
    make install
else
    echo "Verilator is already installed at $VERILATOR_INSTALL_DIR"
fi

# Add Verilator bin directory to PATH
export PATH="$VERILATOR_INSTALL_DIR/bin:$PATH"

# Define paths for your Verilog project
VERILOG_FILE="arithunit.v"
TOP_MODULE="arithunit"
SIMULATION_DIR="$HOME/Simulation"

# Ensure the simulation directory exists
if [ ! -d "$SIMULATION_DIR" ]; then
  echo "Simulation directory $SIMULATION_DIR does not exist."
  exit 1
fi

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
