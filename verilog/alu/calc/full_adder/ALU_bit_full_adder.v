// 9
module ALU_bit_full_adder(
        input wire High,
        input wire notHigh,
        input wire Low,
        input wire notLow,
        input wire Cin,
        input wire notCin,
        output wire S,
        output wire Cout,
        output wire notCout,
        output wire AND,
        output wire notOR,
        output wire notXOR
    );

    // wire notHigh = ~High;
    // wire notLow = ~Low;
    // wire notCin = ~Cin;

    assign notOR = High ~| Low;

    assign AND = notHigh ~| notLow;
    wire _XOR = notOR ~| AND;

    assign notXOR = _XOR ~| _XOR;
    wire _3 = _XOR ~| Cin;
    wire _5 = notXOR ~| notCin;
    assign notCout = AND ~| _5;

    assign Cout = notCout ~| notCout;
    assign S = _3 ~| _5;

endmodule