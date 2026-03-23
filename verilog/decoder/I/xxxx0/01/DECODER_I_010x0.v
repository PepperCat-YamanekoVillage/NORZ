// LD (IX+d),r / LD (IY+d),r
// 26(49)
module DECODER_I_010x0(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [10:0] _decodedXPT,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OP_low, // <
        output wire PA_ADD,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex, // >
        output wire PI_SelectAd_DtexDt,
        output wire PI_SelectDt_A,
        output wire PI_SelectDt_B,
        output wire PI_SelectDt_C,
        output wire PI_SelectDt_D,
        output wire PI_SelectDt_E,
        output wire PI_SelectDt_H,
        output wire PI_SelectDt_L,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd // >
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _X;
    wire _Y;

    DECODER_1bit_decoder d_010d0xxx(
        .notEnable(_not_enable),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_X),
        .out1(_Y)
    );

    wire _010x000x;
    wire _010x001x;
    wire _010x010x;
    wire _A;

    wire _B;
    wire _C;
    wire _D;
    wire _E;
    wire _H;
    wire _L;

    DECODER_2bit_decoder d_010x0ddx( // 8
        .notEnable(_not_enable),
        .In(ITABLE[2:1]),
        .notIn(notITABLE[2:1]),
        .out00(_010x000x),
        .out01(_010x001x),
        .out10(_010x010x),
        .out11(_A)
    );

    wire _not010x000x = _010x000x ~| _010x000x;
    wire _not010x001x = _010x001x ~| _010x001x;
    wire _not010x010x = _010x010x ~| _010x010x;

    DECODER_1bit_decoder d_010x000d(
        .notEnable(_not010x000x),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_B),
        .out1(_C)
    );

    DECODER_1bit_decoder d_010x001d(
        .notEnable(_not010x001x),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_D),
        .out1(_E)
    );

    DECODER_1bit_decoder d_010x010d(
        .notEnable(_not010x010x),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_H),
        .out1(_L)
    );

    //
    // XPT
    //

    wire _0xxx;
    wire _1xxx;

    DECODER_1bit_decoder t_dxxx(
        .notEnable(_not_enable),
        .In(XPT[3]),
        .notIn(notXPT[3]),
        .out0(_0xxx),
        .out1(_1xxx)
    );

    wire _not0xxx = _0xxx ~| _0xxx;

    assign _decodedXPT[3] = _not0xxx ~| notXPT[0];

    wire _not1xxx = _1xxx ~| _1xxx;

    DECODER_2bit_decoder t_10dd( // 5
        .notEnable(_not1xxx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    // 3

    wire _notXPT3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _notX = _X ~| _X;
    wire _notY = _Y ~| _Y;

    assign PA_Select_IX_high = _notXPT3 ~| _notX;
    assign PA_Select_IY_high = _notXPT3 ~| _notY;

    assign PA_Select_OP_low = _decodedXPT[3];
    assign PA_ADD = _decodedXPT[3];
    assign PR_Write_Dt = _decodedXPT[3];
    assign PR_Write_Dtex = _decodedXPT[3];

    // 8~10

    assign PI_SelectAd_DtexDt = _1xxx;

    wire _notA = _A ~| _A;
    wire _notB = _B ~| _B;
    wire _notC = _C ~| _C;
    wire _notD = _D ~| _D;
    wire _notE = _E ~| _E;
    wire _notH = _H ~| _H;
    wire _notL = _L ~| _L;

    assign PI_SelectDt_A = _not1xxx ~| _notA;
    assign PI_SelectDt_B = _not1xxx ~| _notB;
    assign PI_SelectDt_C = _not1xxx ~| _notC;
    assign PI_SelectDt_D = _not1xxx ~| _notD;
    assign PI_SelectDt_E = _not1xxx ~| _notE;
    assign PI_SelectDt_H = _not1xxx ~| _notH;
    assign PI_SelectDt_L = _not1xxx ~| _notL;

    // 8

    assign PC_W0 = _decodedXPT[8];

    // 9

    assign PC_W1 = _decodedXPT[9];

    // 10

    assign PC_W2 = _decodedXPT[10];

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign P2_Reset_ITABLE = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];

endmodule