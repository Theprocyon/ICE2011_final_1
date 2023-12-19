`timescale 1ns / 1ps

module bitcount_tb();

    reg flag_clock_start;

    reg [7:0] Data = 8'b10010010;;
    reg Clock, Resetn, LA, s;

    wire [3:0] B;
    wire Done;

    bitcount DUT(Clock, Resetn, LA, s, Data, B, Done);

initial begin

    flag_clock_start = 0;

    Resetn = 1;
    Clock = 0;
    LA = 0;
    s = 0;

    #1 $display("Start Counting %b\n", Data);
    #5 Resetn = 0;
    #5 Resetn = 1;
    #5 LA = 1;
    #5 Clock = 1;
    #5 Clock = 0;
    #5 LA = 0;
    
    #5 s = 1; //Enable Counter

    #5 flag_clock_start = 1; //Start clock
end
    
always begin
    #5 if(flag_clock_start) Clock = ~Clock;
end

always @(B, Done) begin //FSM Output Printer
    if(~Done) $display("B : %d\n", B);
    else begin
    $display("Operation Done!\n");
    #2 s = 0;
    end
end

endmodule