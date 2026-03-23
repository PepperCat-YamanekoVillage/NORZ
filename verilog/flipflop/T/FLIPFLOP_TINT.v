// 9(23)
module FLIPFLOP_TINT(
        input wire Clk,
        input wire notClk,
        input wire INT,
        input wire notIFF1,
        input wire P2_Reset_TINT,
        input wire P2_Reset_ALLUNOFFICIALFF,
        output wire TINT
    );

    wire _notTINT;
    wire _notDelayedINT;
    wire _notINT = INT ~| INT;

    // newINT

    wire _new_INT = _notDelayedINT ~| _notINT;
    wire _new_notInt = _new_INT ~| _new_INT;
    wire _new_TINT = _notTINT ~| _new_notInt;

    // or

    wire _notResetINT_0 = P2_Reset_TINT ~| P2_Reset_ALLUNOFFICIALFF;
    wire _ResetINT_0 = _notResetINT_0 ~| _notResetINT_0;
    wire _noResetINT = notIFF1 ~| _ResetINT_0;
    wire _ResetINT = _noResetINT ~| _noResetINT;

    // or

    wire _TINT_new_notTINT = _ResetINT ~| _new_TINT;

    FLIPFLOP_halfdelay delay(
        .notClk(notClk),
        .D(INT),
        .notQ(_notDelayedINT)
    );

    FLIPFLOP_dff int_(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_TINT_new_notTINT),
        .Q(TINT),
        .notQ(_notTINT)
    );

endmodule