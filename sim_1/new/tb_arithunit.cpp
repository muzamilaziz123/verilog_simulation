#include <verilated.h>
#include "Varithunit.h"

// Define the clock period (in simulation time units)
#define CYCLE_TIME 10

// Main simulation function
int main(int argc, char** argv, char** env) {
    // Initialize Verilator
    Verilated::commandArgs(argc, argv);

    // Create an instance of the Verilog module
    Varithunit* top = new Varithunit;

    // Initialize simulation variables
    unsigned int cycle = 0;
    bool reset = 1;

    // Start the simulation
    while (cycle < 100) { // Run for 100 cycles or as needed
        // Apply reset
        if (cycle < 5) {
            top->reset = 1;
        } else {
            top->reset = 0;
        }

        // Apply stimulus
        if (cycle == 10) {
            top->data_1 = 0xA5A5;
            top->data_2 = 0x5A5A;
            top->op_sel = 0b00; // Add
        } else if (cycle == 20) {
            top->op_sel = 0b01; // Subtract
        } else if (cycle == 30) {
            top->op_sel = 0b10; // Multiply
        } else if (cycle == 40) {
            top->op_sel = 0b11; // AND
        }

        // Simulate one clock cycle
        top->clk = 1;
        top->eval();
        top->clk = 0;
        top->eval();

        // Print results
        if (cycle % 10 == 0) {
            printf("Cycle: %d, data_out: %04X\n", cycle, top->data_out);
        }

        // Increment cycle counter
        cycle++;
    }

    // Cleanup and exit
    delete top;
    return 0;
}
