// 20(38)
module FLIPFLOP_IFF(
        input wire Clk,
        input wire notClk,
        input wire P2_Set_IFF1,
        input wire P2_Set_IFF2,
        input wire P2_Reset_IFF1,
        input wire P2_Reset_IFF2,
        input wire P2_EvacuateIFF,
        input wire P2_RestoreIFF,
        output wire notIFF1,
        output wire IFF2
    );

    wire _notIFF2;

    // or

    wire _notWriteIFF1_0 = P2_Set_IFF1 ~| P2_Reset_IFF1;
    wire _writeIFF1_0 = _notWriteIFF1_0 ~| _notWriteIFF1_0;
    wire _notWriteIFF1 = P2_RestoreIFF ~| _writeIFF1_0;
    wire _writeIFF1 = _notWriteIFF1 ~| _notWriteIFF1;

    wire _notWriteIFF2_0 = P2_Set_IFF2 ~| P2_Reset_IFF2;
    wire _writeIFF2_0 = _notWriteIFF2_0 ~| _notWriteIFF2_0;
    wire _notWriteIFF2 = P2_EvacuateIFF ~| _writeIFF2_0;
    wire _writeIFF2 = _notWriteIFF2 ~| _notWriteIFF2;

    wire _notP2_RestoreIFF = P2_RestoreIFF ~| P2_RestoreIFF;
    wire _notP2_EvacuateIFF = P2_EvacuateIFF ~| P2_EvacuateIFF;

    // and

    wire _IFF1_new_iff2 = _notIFF2 ~| _notP2_RestoreIFF;
    wire _IFF2_new_iff1 = notIFF1 ~| _notP2_EvacuateIFF;
    wire _IFF1_new_iff1 = notIFF1 ~| _writeIFF1;
    wire _IFF2_new_iff2 = _notIFF2 ~| _writeIFF2;

    // or

    wire _IFF1_new_nor_0 = _IFF1_new_iff2 ~| _IFF1_new_iff1;
    wire _IFF2_new_nor_0 = _IFF2_new_iff1 ~| _IFF2_new_iff2;
    wire _IFF1_new_or_0 = _IFF1_new_nor_0 ~| _IFF1_new_nor_0;
    wire _IFF2_new_or_0 = _IFF2_new_nor_0 ~| _IFF2_new_nor_0;
    wire _IFF1_new_nor_1 = _IFF1_new_or_0 ~| P2_Set_IFF1;
    wire _IFF2_new_nor_1 = _IFF2_new_or_0 ~| P2_Set_IFF2;

    FLIPFLOP_dff iff1(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_IFF1_new_nor_1),
        .notQ(notIFF1)
    );

    FLIPFLOP_dff iff2(
        .Clk(Clk),
        .notClk(notClk),
        .notD(_IFF2_new_nor_1),
        .Q(IFF2),
        .notQ(_notIFF2)
    );

endmodule