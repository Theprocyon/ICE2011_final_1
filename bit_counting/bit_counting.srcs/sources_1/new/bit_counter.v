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
    input Clock, Resetn, LA, s; // s = start
    input [7:0] Data;           // To Count
    output reg [3:0] B;         // count result
    output reg Done;            // done
    wire [7:0] A;               // SR output
    wire z;                     // no more 1 in S.R Signal
    reg [1:0] Y,y;              // Next status, current status
    reg EA, EB, LB;
    
    // control circuit
    
    parameter S1 = 2'b00, S2 = 2'b01, S3 = 2'b10;
    
    // evaluate next status
    // S1 = Idle, initialize
    // S2 = Counter running
    // S3 = Outputs the result
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
    
    //Sync state change. when reset, reset status
    always@(posedge Clock, negedge Resetn)
    begin: State_flipflops
        if(Resetn == 0)
            y <= S1;
        else
            y <= Y;
    end
    
    always@(y, A[0]) //A[0]은 s.r.의 serial 출력
    begin: FSM_outputs
        // defaults
        EA = 0; LB = 0; EB = 0; Done = 0;
        case(y)
            S1: LB = 1;  // S1에서 Counter Initializing 함. 0을 Load.
            S2: begin       // TODO
                    EA = 1;                         // Enable ea  
                    if(A[0] == 1) EB = 1;           // counting
                    else EB = 0;                    // Update B when done
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
            B <= 0;     // Counter 의 initial value는 0으로 사용할 것이므로, 0 Load.
        else if(EB)
            B <= B + 1; // Counter 는 Enable 되었을 때, 1 Clock당 1씩 누산하는 동작 함.


    shiftrne ShiftA(Data, LA, EA, 1'b0, Clock, A);
    assign z = ~|A;     // z는 A의 모든 bit를 nor한 것, High일 시 카운트 완료한 것으로 판단해 State 2 -> 3로 전이.
                
endmodule