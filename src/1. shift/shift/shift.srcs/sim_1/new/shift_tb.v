`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/11 20:18:08
// Design Name: 
// Module Name: shift_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shift_tb();
shift_reg a(clk, reset_n, s_in, p_in, p_out, load);
reg clk, reset_n;
reg[3:0] p_in;
reg s_in, load;
wire [3:0] p_out;

always #5 clk = ~clk;

initial begin
clk =0; reset_n =0; p_in= 4'b1000; s_in=0; load =1;

#10 reset_n =1;

#10 load=0;
end

endmodule
