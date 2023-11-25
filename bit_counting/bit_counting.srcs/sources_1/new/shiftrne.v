`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/25 19:36:06
// Design Name: 
// Module Name: shiftrne
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


module shiftrne(R, L, E, w, Clock, Q);
    parameter n = 8;
    input [n-1:0] R;
    input L, E, w, Clock;
    output reg [n-1:0] Q;
    integer k;
    
    always@(posedge Clock)
        if(L)
            Q <= R;
        else if(E)
        begin
            for(k=n-1;k>0;k=k-1)
                Q[k-1]<=Q[k];
            Q[n-1]<=w;
        end
endmodule
