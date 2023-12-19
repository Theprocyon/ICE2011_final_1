`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/11 19:46:57
// Design Name: 
// Module Name: shift_reg
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

module shift_reg(clk, reset_n, s_in, p_in, p_out, load);
input clk, reset_n;
input[3:0] p_in;
input s_in, load;
output reg [3:0] p_out;

always @ (posedge clk or negedge reset_n) begin
if(!reset_n) p_out <= 4'b1111; // Reset �� 4bit ������ 1111, �� 15��� ������ �������ش�.

else begin
    if(load) p_out <= p_in; // load == 1 �� ���, p_out�� parallel input ���� load�Ѵ�.
    
    else begin              // load == 0 �� ���, shift ������ �����Ѵ�.
    p_out[3] <= s_in;       //
    p_out[2] <= p_out[3];   //
    p_out[1] <= p_out[2];   //
    p_out[0] <= p_out[1];   // ������ ���� ���������� �̵��Ѵ�.
    end
end
end
endmodule