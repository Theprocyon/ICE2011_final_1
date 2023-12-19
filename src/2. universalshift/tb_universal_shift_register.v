`timescale 1ns/1ps  // Define simulation timescale

module tb_universal_shift_register;

  // Inputs
  reg clk;
  reg reset_n;
  reg [1:0] s;
  reg lsi, rsi;
  reg [3:0] din;

  // Outputs
  wire [3:0] qout;

  // Instantiate the module under test
  universal_shift_register uut (
    .clk(clk),
    .reset_n(reset_n),
    .s(s),
    .lsi(lsi),
    .rsi(rsi),
    .din(din),
    .qout(qout)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Initial stimulus
  initial begin
    reset_n = 0;
    s = 2'b00;  // No change initially
    lsi = 0;
    rsi = 0;
    din = 4'b0000;

    // Apply reset and initial values
    #10 reset_n = 1;
    #10 s = 2'b01;  // Right shift
    #10 lsi = 1;
    #10 rsi = 0;
    #10 din = 4'b1010;
    
    // Add more test cases as needed

    #100 $finish;  // Terminate simulation after some time
  end

  // Monitor for simulation
  always @(posedge clk) begin
    $display("Time=%0t s=%b lsi=%b rsi=%b din=%b qout=%b", $time, s, lsi, rsi, din, qout);
  end

endmodule
