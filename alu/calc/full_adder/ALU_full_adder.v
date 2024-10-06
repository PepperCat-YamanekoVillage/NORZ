// 9
module ALU_full_adder(
        input wire High,
        input wire Low,
        input wire Cin,
        output wire S,
        output wire Cout
    );

    wire _0 = High ~| Low;
    wire _1 = Low ~| _0;
    wire _2 = High ~| _0;
    wire _3 = _1 ~| _2;
    wire _4 = Cin ~| _3;
    wire _5 = _3 ~| _4;
    wire _6 = Cin ~| _4;

    assign S = _5 ~| _6;
    assign Cout = _0 ~| _4;

endmodule