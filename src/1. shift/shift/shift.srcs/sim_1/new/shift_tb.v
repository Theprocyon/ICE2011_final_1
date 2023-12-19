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
reg[3:0] p_in;    //Reg는 wire로 wire는 reg로 바꿔서 적어주었다.
reg s_in, load;
wire [3:0] p_out; //Reg는 wire로 wire는 reg로 바꿔서 적어주었다.

always #5 clk = ~clk; // 5ns마다 상승엣지 또 하강엣지를 발생시킨다.

initial begin
clk = 0; reset_n = 0; p_in = 4'b1000; s_in = 0; load = 1; 
// 각 변수의 초기값을 와 같이 설정한다.

#10 reset_n = 1; // reset_n을 1로 해 reset 상태에서 벗어난다.

#10 load = 0; // 10ns 이후 load를 0으로 한다.
end

endmodule
