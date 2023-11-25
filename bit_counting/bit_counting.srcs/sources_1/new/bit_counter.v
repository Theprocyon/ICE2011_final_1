`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/25 19:13:50
// Design Name: 
// Module Name: bit_counter
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


module bitcount(Clock, Resetn, LA, s, Data, B, Done);
    input Clock, Resetn, LA, s;
    input [7:0] Data;
    output reg [3:0] B;
    output reg Done;
    wire [7:0] A;
    wire z; // is active?
    reg [1:0] Y,y;
    reg EA, EB, LB;
    
    // control circuit
    
    parameter S1 = 2'b00, S2 = 2'b01, S3 = 2'b10;
    
    always@(s, y, z)
    begin: State_table
        case(y)
            S1: if(!s) Y = S1;
                else Y = S2;
            S2: if(z == 0) Y = S2;
                else Y = S3;
            S3: if(s) Y = S3;
                else Y = S1;
            default: Y = 2'bxx;
        endcase
    end
    
    always@(posedge Clock, negedge Resetn)
    begin: State_flipflops
        if(Resetn == 0)
            y <= S1;
        else
            y <= Y;
    end
    
    always@(y, A[0])
    begin: FSM_outputs
        // defaults
        EA = 0; LB = 0; EB = 0; Done = 0;
        case(y)
            S1: LB = ;//TODO
            S2: begin //TODO
                end
            S3: Done = 1;
        endcase
    end
    
    //datapath circuit
    
    //counter B
    always @(negedge Resetn, posedge Clock)
        if(!Resetn)
            B <= 0;
        else if(LB)
            //zzzz
        else if(EB)
            //yyyy
    shiftrne ShiftA(Data, LA, EA, 1'b0, Clock, A);
    assign z = ;
                
endmodule
