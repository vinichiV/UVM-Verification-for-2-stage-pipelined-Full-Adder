`timescale 1ns/1ps

`include "uvm_macros.svh"
`include "my_pkg.svh"
module top;
  import uvm_pkg::*;
  import my_pkg::*;
  // Interface
  FullAdder_if dut_if();

  // DUT
  FullAdder dut (
    .fa_if(dut_if)
  );

  // Clock generation
  initial begin
    dut_if.clk = 0;
    forever #5 dut_if.clk = ~dut_if.clk;
  end

  // Run UVM
  initial begin
    // Pass virtual interface to UVM
    uvm_config_db#(virtual FullAdder_if)::set(null, "*", "dut_vif", dut_if);

    run_test("my_test");
  end
  
  // Waveform dump
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end

endmodule
