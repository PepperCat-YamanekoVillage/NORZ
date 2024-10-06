// FLIPFLOP_dffと同じ
// 9
module REGISTER_dff(
        input wire Clk,
        input wire notClk,
        input wire notD,
        output wire Q,
        output wire notQ
    );

    wire _D = notD ~| notD;
    wire _0 = _D ~| Clk;
    wire _1 = notD ~| Clk;
    wire _2 = _0 ~| _3;
    wire _3 = _1 ~| _2;
    wire _4 = _2 ~| notClk;
    wire _5 = _3 ~| notClk;
    assign Q = _4 ~| notQ;
    assign notQ = _5 ~| Q;

endmodule