// 7(15)
module DECODER_basic_M1(
        input wire TWAIT,
        input wire [1:0] XPT,
        input wire [1:0] notXPT,
        input wire PC_M1,
        output wire [3:0] _decodedXPT,
        output wire PI_Activate_Ad_high, // < 0~3
        output wire PI_Activate_Ad_low, // >
        output wire PI_SelectAd_PC, // < 0or1
        output wire PI_Flag_M1, // >
        output wire PhI_Flag_MREQ,
        output wire PhI_Flag_RD,
        output wire PI_Flag_MREQ, // < 1
        output wire PI_Flag_RD,
        output wire PA_Select_Din_low,
        output wire PA_NOP, // >
        output wire PR_Write_OP, // < 1W
        output wire PR_SlideOP, // >
        output wire PR_Halt_XPT,
        output wire PI_SelectAd_IR, // < 2or3
        output wire PI_Flag_RFSH, // >
        output wire P2_Reset_CM1, // < 3
        output wire PR_Inc_R // >
    );

    // wire [1:0] notXPT = ~XPT;

    wire _0x;
    wire _1x;

    wire _notPC_M1 = PC_M1 ~| PC_M1;

    DECODER_2bit_decoder d_dd( // 8
        .notEnable(_notPC_M1),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out0x(_0x),
        .out1x(_1x),
        .out00(_decodedXPT[0]),
        .out01(_decodedXPT[1]),
        .out10(_decodedXPT[2]),
        .out11(_decodedXPT[3])
    );

    wire _x0 = (_decodedXPT[0] | _decodedXPT[2]); // 2
    
    // 0~3

    assign PI_Activate_Ad_high = PC_M1;
    assign PI_Activate_Ad_low = PC_M1;

    // 0or1

    assign PI_SelectAd_PC = _0x;
    assign PI_Flag_M1 = _0x;

    // 0or2

    assign PhI_Flag_MREQ = _x0;

    // 0

    assign PhI_Flag_RD = _decodedXPT[0];

    // 1

    assign PI_Flag_MREQ = _decodedXPT[1];
    assign PI_Flag_RD = _decodedXPT[1];
    assign PA_Select_Din_low = _decodedXPT[1];
    assign PA_NOP = _decodedXPT[1];

    wire _not1 = _decodedXPT[1] ~| _decodedXPT[1];
    wire _notTWAIT = TWAIT ~| TWAIT;

    wire _1WAIT = _not1 ~| _notTWAIT;
    wire _1notWAIT = _not1 ~| TWAIT;

    assign PR_Write_OP = _1WAIT;
    assign PR_SlideOP = _1WAIT;

    assign PR_Halt_XPT = _1notWAIT;

    // 2or3

    assign PI_SelectAd_IR = _1x;
    assign PI_Flag_RFSH = _1x;

    // 3

    assign P2_Reset_CM1 = _decodedXPT[3];
    assign PR_Inc_R = _decodedXPT[3];

endmodule