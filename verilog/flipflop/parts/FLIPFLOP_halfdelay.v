// HtoLのずらし
// 5
module FLIPFLOP_halfdelay(
        input wire notClk,
        input wire D,
        output wire Q,
        output wire notQ
    );

    wire _notD = D ~| D;
    wire _0 = D ~| notClk;
    wire _1 = _notD ~| notClk;
    assign Q = _0 ~| notQ;
    assign notQ = _1 ~| Q;

endmodule