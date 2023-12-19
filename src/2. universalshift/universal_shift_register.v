module universal_shift_register (
  input clk,
  input reset_n,
  input [1:0] s,
  input lsi, rsi,
  input [3:0] din,
  output reg [3:0] qout);
  
  wire [3:0] no_change, rshift, lshift, load_values;
    
  // No change
  assign no_change = qout;
  // Right shift
  assign rshift = (rsi) ? {1'b0, qout[3:1]} : {qout[2:0], 1'b0}; //삼항연산자 rsi true, 
  // Left shift
  assign lshift = (lsi) ? {qout[2:0], 1'b0} : {1'b0, qout[3:1]};
  // Parallel load
  assign load_values = din;

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
