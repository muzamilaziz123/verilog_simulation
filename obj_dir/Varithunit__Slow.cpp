// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Varithunit.h for the primary calling header

#include "Varithunit.h"
#include "Varithunit__Syms.h"

//==========

VL_CTOR_IMP(Varithunit) {
    Varithunit__Syms* __restrict vlSymsp = __VlSymsp = new Varithunit__Syms(this, name());
    Varithunit* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Varithunit::__Vconfigure(Varithunit__Syms* vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
    if (false && this->__VlSymsp) {}  // Prevent unused
    Verilated::timeunit(-9);
    Verilated::timeprecision(-12);
}

Varithunit::~Varithunit() {
    VL_DO_CLEAR(delete __VlSymsp, __VlSymsp = NULL);
}

void Varithunit::_eval_initial(Varithunit__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Varithunit::_eval_initial\n"); );
    Varithunit* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Varithunit::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Varithunit::final\n"); );
    // Variables
    Varithunit__Syms* __restrict vlSymsp = this->__VlSymsp;
    Varithunit* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Varithunit::_eval_settle(Varithunit__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Varithunit::_eval_settle\n"); );
    Varithunit* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_combo__TOP__1(vlSymsp);
}

void Varithunit::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Varithunit::_ctor_var_reset\n"); );
    // Body
    clk = VL_RAND_RESET_I(1);
    reset = VL_RAND_RESET_I(1);
    data_1 = VL_RAND_RESET_I(16);
    data_2 = VL_RAND_RESET_I(16);
    op_sel = VL_RAND_RESET_I(2);
    data_out = VL_RAND_RESET_I(16);
}
