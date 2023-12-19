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
if(!reset_n) p_out <= 4'b1111; // Reset 시 4bit 이진수 1111, 즉 15라는 값으로 설정해준다.

else begin
    if(load) p_out <= p_in; // load == 1 인 경우, p_out에 parallel input 값을 load한다.
    
    else begin              // load == 0 인 경우, shift 동작을 수행한다.
    p_out[3] <= s_in;       //
    p_out[2] <= p_out[3];   //
    p_out[1] <= p_out[2];   //
    p_out[0] <= p_out[1];   // 각자의 값을 오른쪽으로 이동한다.
    end
end
end
endmodule