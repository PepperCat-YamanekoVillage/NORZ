// 12(17)
module DECODER_basic_MA(
        input wire [1:0] XPT,
        input wire [1:0] notXPT,
        input wire TWAIT,
        input wire PC_MA,
        input wire PC_MA0,
        input wire PC_MA1,
        input wire PC_MA2,
        output wire [2:0] _decodedXPT,
        output wire PhI_Flag_MREQ, // < 0or1
        output wire PhI_Flag_RD, // >
        output wire PI_Activate_Ad_high, // < 0~2
        output wire PI_Activate_Ad_low,
        output wire PI_SelectAd_PC, // >
        output wire PR_Halt_XPT,
        output wire PI_Read_Dtcs, // < 2
        output wire PA_Select_Dtcs_low, // >
        output wire PR_Inc_PC, // < 2 PC_MA 
        output wire P2_Reset_CMA // >
    );

    // wire [1:0] notXPT = ~XPT;

    wire _notPC_MA = PC_MA ~| PC_MA;

    DECODER_2bit_decoder d_dd( // 5
        .notEnable(_notPC_MA),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[0]),
        .out01(_decodedXPT[1]),
        .out1x(_decodedXPT[2])
    );

    // 0or1

    wire _not0 = _decodedXPT[0] ~| PC_MA0;
    wire _0 = _not0 ~| _not0;

    wire _not1 = _decodedXPT[1] ~| PC_MA1;
    wire _1 = _not1 ~| _not1;

    wire _not0or1 = _0 ~| _1;
    wire _0or1 = _not0or1 ~| _not0or1;

    assign PhI_Flag_MREQ = _0or1;
    assign PhI_Flag_RD = _0or1;

    // 0~3

    wire _not2 = _decodedXPT[2] ~| PC_MA2;
    wire _2 = _not2 ~| _not2;

    wire _not0_2 = _0or1 ~| _2;
    wire _0_2 = _not0_2 ~| _not0_2;

    assign PI_Activate_Ad_high = _0_2;
    assign PI_Activate_Ad_low = _0_2;
    assign PI_SelectAd_PC = _0_2;

    // 1

    wire _1notWAIT = _not1 ~| TWAIT;

    assign PR_Halt_XPT = _1notWAIT;

    // 2

    assign PI_Read_Dtcs = _2;
    assign PA_Select_Dtcs_low = _2;

    assign PR_Inc_PC = _decodedXPT[2];
    assign P2_Reset_CMA = _decodedXPT[2];

endmodule