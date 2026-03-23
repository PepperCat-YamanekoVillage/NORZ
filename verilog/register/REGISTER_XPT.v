// 10(55)
module REGISTER_XPT(
        // input wire clk,
        input wire Clk,
        input wire notClk,
        input wire PR_Reset_XPT,
        input wire notPR_Halt_XPT,
        output wire [4:0] XPT,
        output wire [4:0] notXPT
    );

    // wire Clk = clk;
    // wire notClk = ~clk;

    //
    // inc
    //

    wire [4:0] _Inc;

    REGISTER_5bit_inc Inc(
        .In(XPT[4:0]),
        .notIn(notXPT[4:0]),
        .CY(notPR_Halt_XPT),
        .Out(_Inc)
    );

    // and

    wire _notInc0 = _Inc[0] ~| _Inc[0];
    wire _notInc1 = _Inc[1] ~| _Inc[1];
    wire _notInc2 = _Inc[2] ~| _Inc[2];
    wire _notInc3 = _Inc[3] ~| _Inc[3];
    wire _notInc4 = _Inc[4] ~| _Inc[4];
    wire _new_XPT0 = _notInc0 ~| PR_Reset_XPT;
    wire _new_XPT1 = _notInc1 ~| PR_Reset_XPT;
    wire _new_XPT2 = _notInc2 ~| PR_Reset_XPT;
    wire _new_XPT3 = _notInc3 ~| PR_Reset_XPT;
    wire _new_XPT4 = _notInc4 ~| PR_Reset_XPT;

    REGISTER_dff XPT0(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_XPT0),
        .Q(notXPT[0]),
        .notQ(XPT[0])
    );

    REGISTER_dff XPT1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_XPT1),
        .Q(notXPT[1]),
        .notQ(XPT[1])
    );

    REGISTER_dff XPT2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_XPT2),
        .Q(notXPT[2]),
        .notQ(XPT[2])
    );

    REGISTER_dff XPT3(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_XPT3),
        .Q(notXPT[3]),
        .notQ(XPT[3])
    );

    REGISTER_dff XPT4(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_new_XPT4),
        .Q(notXPT[4]),
        .notQ(XPT[4])
    );

endmodule