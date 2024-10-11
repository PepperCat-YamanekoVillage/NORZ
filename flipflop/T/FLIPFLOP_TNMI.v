// TINTのIFF1が常に1ver
// 7(21)
module FLIPFLOP_TNMI(
        input wire Clk,
        input wire notClk,
        input wire NMI,
        input wire P2_Reset_TNMI,
        input wire P2_Reset_ALLUNOFFICIALFF,
        output wire TNMI
    );

    wire _notTNMI;
    wire _notDelayedNMI;
    wire _notNMI = NMI ~| NMI;

    // newNMI

    wire _new_NMI = _notDelayedNMI ~| _notNMI;
    wire _new_notInt = _new_NMI ~| _new_NMI;
    wire _new_TNMI = _notTNMI ~| _new_notInt;

    // or

    wire _notResetNMI_0 = P2_Reset_TNMI ~| P2_Reset_ALLUNOFFICIALFF;
    wire _ResetNMI = _notResetNMI_0 ~| _notResetNMI_0;

    // or

    wire _TNMI_new_notTNMI = _ResetNMI ~| _new_TNMI;

    FLIPFLOP_halfdelay delay(
        .notClk(notClk),
        .D(NMI),
        .notQ(_notDelayedNMI)
    );

    FLIPFLOP_dff nmi_(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_TNMI_new_notTNMI),
        .Q(TNMI),
        .notQ(_notTNMI)
    );

endmodule