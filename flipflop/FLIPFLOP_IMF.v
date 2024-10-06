// 8(26)
module FLIPFLOP_IMF(
        input wire Clk,
        input wire notClk,
        input wire P2_IM0,
        input wire P2_IM1,
        input wire P2_IM2,
        output wire IMFa,
        output wire IMFb
    );

    wire _notIMFa;
    wire _notIMFb;

    // or

    wire _notWrite0 = P2_IM1 ~| P2_IM2;
    wire _Write0 = _notWrite0 ~| _notWrite0;
    wire _notWrite = _Write0 ~| P2_IM0;
    wire _Write = _notWrite ~| _notWrite;

    // and

    wire _imfa_new_imfa = _notIMFa ~| _Write;
    wire _imfa_new_imfb = _notIMFb ~| _Write;

    // or

    wire _imfa_new_not = _imfa_new_imfa ~| _Write0;
    wire _imfb_new_not = _imfa_new_imfb ~| P2_IM2;

    FLIPFLOP_dff imfa(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_imfa_new_not),
        .Q(IMFa),
        .notQ(_notIMFa)
    );

    FLIPFLOP_dff imfb(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_imfb_new_not),
        .Q(IMFb),
        .notQ(_notIMFb)
    );

endmodule