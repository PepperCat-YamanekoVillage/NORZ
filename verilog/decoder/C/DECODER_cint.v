// 24(55)
module DECODER_cint(
        input wire notEnable,
        input wire TWAIT,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        output wire [12:0] _decodedXPT,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectAd_PC, // < 1~3
        output wire PI_Flag_M1, // >
        output wire PI_Activate_Ad_high, // < 1~5
        output wire PI_Activate_Ad_low, // >
        output wire PhI_Flag_IORQ,
        output wire PI_Flag_IORQ, // < 3
        output wire PA_Select_Din_low,
        output wire PR_Write_OP, // >
        output wire PA_NOP,
        output wire PR_Halt_XPT,
        output wire PI_SelectAd_IR, // < 4~5
        output wire PI_Flag_RFSH, // >
        output wire PhI_Flag_MREQ,
        output wire PR_Inc_R,
        output wire PR_Dec_SP,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectAd_SP,
        output wire PI_SelectDt_PC_low,
        output wire PR_Reset_XPT, // < 12
        output wire P2_Set_CM1,
        output wire P2_Reset_CINT,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low,
        output wire Pa_Ophd // >
    );

    // wire [3:0] notXPT = ~XPT;

    //
    // decoder
    //

    wire _00xx;
    wire _01xx;
    wire _10xx;
    wire _11xx;

    DECODER_2bit_decoder d_ddxx( // 8
        .notEnable(notEnable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_00xx),
        .out01(_01xx),
        .out10(_10xx),
        .out11(_11xx)
    );

    wire _not_00xx = _00xx ~| _00xx;
    wire _not_01xx = _01xx ~| _01xx;
    wire _not_10xx = _10xx ~| _10xx;

    DECODER_2bit_decoder d_00dd( // 7
        .notEnable(_not_00xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[0]),
        .out10(_decodedXPT[2]),
        .out11(_decodedXPT[3])
    );

    wire _4or5;

    DECODER_2bit_decoder d_01dd( // 8
        .notEnable(_not_01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out0x(_4or5),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    wire _8or9;
    wire _10or11;

    DECODER_2bit_decoder d_10dd( // 8
        .notEnable(_not_10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out0x(_8or9),
        .out1x(_10or11),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out10(_decodedXPT[10]),
        .out11(_decodedXPT[11])
    );

    assign _decodedXPT[12] = _11xx;

    // 1~3

    wire _1_3 = _not_00xx ~| _decodedXPT[0];

    assign PI_SelectAd_PC = _1_3;
    assign PI_Flag_M1 = _1_3;

    // 1~5

    wire _not1_5 = _1_3 ~| _4or5;
    wire _1_5 = _not1_5 ~| _not1_5;
    assign PI_Activate_Ad_high = _1_5;
    assign PI_Activate_Ad_low = _1_5;

    // 2

    assign PhI_Flag_IORQ = _decodedXPT[2];

    // 3

    assign PI_Flag_IORQ = _decodedXPT[3];
    assign PA_Select_Din_low = _decodedXPT[3];
    assign PR_Write_OP = _decodedXPT[3];

    wire _not_decodedXPT3 = _decodedXPT[3] ~| _decodedXPT[3];
    assign PR_Halt_XPT = _not_decodedXPT3 ~| TWAIT;

    // 3or12

    wire _not3or12 = _decodedXPT[3] ~| _decodedXPT[12];
    wire _3or12 = _not3or12 ~| _not3or12;

    assign PA_NOP = _3or12;

    // 4~5

    assign PI_SelectAd_IR = _4or5;
    assign PI_Flag_RFSH = _4or5;

    // 4

    assign PhI_Flag_MREQ = _decodedXPT[4];

    // 5

    assign PR_Inc_R = _decodedXPT[5];

    // 6or9

    wire _not_6or9 = _decodedXPT[6] ~| _decodedXPT[9];
    wire _6or9 = _not_6or9 ~| _not_6or9;

    assign PR_Dec_SP = _6or9;

    // 7or10

    wire _not_7or10 = _decodedXPT[7] ~| _decodedXPT[10];
    wire _7or10 = _not_7or10 ~| _not_7or10;

    assign PC_W0 = _7or10;

    // 7~9

    wire _not7_9 = _decodedXPT[7] ~| _8or9;
    wire _7_9 = _not7_9 ~| _not7_9;

    assign PI_SelectDt_PC_high = _7_9;

    // 7~12

    wire _not7_12 = _7_9 ~| _10_12;
    wire _7_12 = _not7_12 ~| _not7_12;

    assign PI_SelectAd_SP = _7_12;

    // 8or11

    wire _not_8or11 = _decodedXPT[8] ~| _decodedXPT[11];
    wire _8or11 = _not_8or11 ~| _not_8or11;

    assign PC_W1 = _8or11;

    // 9or12

    wire _not_9or12 = _decodedXPT[9] ~| _decodedXPT[12];
    wire _9or12 = _not_9or12 ~| _not_9or12;

    assign PC_W2 = _9or12;

    // 10~12

    wire _not10_12 = _10or11 ~| _decodedXPT[12];
    wire _10_12 = _not10_12 ~| _not10_12;

    assign PI_SelectDt_PC_low = _10_12;

    // 12

    assign PR_Reset_XPT = _decodedXPT[12];
    assign P2_Set_CM1 = _decodedXPT[12];
    assign P2_Reset_CINT = _decodedXPT[12];
    assign PR_Write_PC_high = _decodedXPT[12];
    assign PR_Write_PC_low = _decodedXPT[12];
    assign Pa_Ophd = _decodedXPT[12];

endmodule