`timescale 1ns / 1ps

module universal_shift_register (
  input clk,
  input reset_n,
  input [1:0] s,
  input lsi, rsi,
  input [3:0] din,
  output reg [3:0] qout);
  
  wire [3:0] no_change, rshift, lshift, load_values;
    
  // No change
  assign no_change = qout;  // 출력을 입력으로 되먹여, 변화 X
  // Right shift
  assign rshift = {rsi, qout[3:1]}; //rsi 입력이 반영된 rshift 값
  // Left shift
  assign lshift = {qout[2:0], lsi}; //rsi 입력이 반영된 lshift 값
  // Parallel load
  assign load_values = din;  // load_values wire = din

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) 
      qout <= 4'b0;
    else
      case (s)
        2'b00: qout <= no_change;     // No change
        2'b01: qout <= rshift;        // Shift right
        2'b10: qout <= lshift;        // Shift left
        2'b11: qout <= load_values;   // Parallel load
        default: qout <= 4'b0;        // Default case for safety
      endcase
  end
endmodule
