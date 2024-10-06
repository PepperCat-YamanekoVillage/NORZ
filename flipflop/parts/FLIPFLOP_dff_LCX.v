// SetとResetが同時に来た時はSetが優先される
// L/C/Xで使用
// 4(13)
module FLIPFLOP_dff_LCX(
        input wire Clk,
        input wire notClk,
        input wire P2_Set,
        input wire P2_Reset,
        output wire LCX,
        output wire notLCX
    );

    // or

    wire _not_write = P2_Set ~| P2_Reset;
    wire _write = _not_write ~| _not_write;

    // and

    wire _new_lcx_old = notLCX ~| _write;

    // or

    wire _not_new_lcx = P2_Set ~| _new_lcx_old;

    FLIPFLOP_dff lcx(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_not_new_lcx),
        .Q(LCX),
        .notQ(notLCX)
    );

endmodule