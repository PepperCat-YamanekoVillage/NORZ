// LD r,(IX+d)/(IY+d)
// 33(56)
module DECODER_I_001x0(
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
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PR_Write_A,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_InvertIn
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _X;
    wire _Y;

    DECODER_1bit_decoder d_001d0xxx(
        .notEnable(_not_enable),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_X),
        .out1(_Y),
    );

    wire _BC;
    wire _DE;
    wire _HL;
    wire _A;

    DECODER_2bit_decoder d_001x0ddx( // 8
        .notEnable(_not_enable),
        .In(ITABLE[2:1]),
        .notIn(notITABLE[2:1]),
        .out00(_BC),
        .out01(_DE),
        .out10(_HL),
        .out11(_A)
    );

    wire _notBC = _BC ~| _BC;
    wire _notDE = _DE ~| _DE;
    wire _notHL = _HL ~| _HL;

    wire _B;
    wire _C;
    wire _D;
    wire _E;
    wire _H;
    wire _L;

    DECODER_1bit_decoder d_001x000d(
        .notEnable(_notBC),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_B),
        .out1(_C),
    );

    DECODER_1bit_decoder d_001x001d(
        .notEnable(_notDE),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_D),
        .out1(_E),
    );

    DECODER_1bit_decoder d_001x010d(
        .notEnable(_notHL),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(_H),
        .out1(_L),
    );

    //
    // XPT
    //

    wire _t0xxx;
    wire _t1xxx;

    DECODER_1bit_decoder t_dxxx(
        .notEnable(_not_enable),
        .In(XPT[3]),
        .notIn(notXPT[3]),
        .out0(_t0xxx),
        .out1(_t1xxx),
    );

    wire _not_t0xxx = _t0xxx ~| _t0xxx;

    assign _decodedXPT[3] = _not_t0xxx ~| notXPT[0];

    wire _not_t1xxx = _t1xxx ~| _t1xxx;

    DECODER_2bit_decoder t_10dd( // 5
        .notEnable(_not_t1xxx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    // 3

    wire _notX = _X ~| _X;
    wire _notY = _Y ~| _Y;

    wire _notXPT3 = _decodedXPT[3] ~| _decodedXPT[3];

    assign PA_Select_IX_high = _notXPT3 ~| _notX;
    assign PA_Select_IY_high = _notXPT3 ~| _notY;

    assign PA_Select_OP_low = _decodedXPT[3];
    assign PA_ADD = _decodedXPT[3];
    assign PR_Write_Dt = _decodedXPT[3];
    assign PR_Write_Dtex = _decodedXPT[3];

    // 8~10

    assign PI_SelectAd_DtexDt = _t1xxx;

    // 8

    assign PC_R0 = _decodedXPT[8];

    // 9

    assign PC_R1 = _decodedXPT[9];

    // 10

    assign PC_R2 = _decodedXPT[10];

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign P2_Reset_ITABLE = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];

    wire _notXPT10 = _decodedXPT[10] ~| _decodedXPT[10];

    wire _notA = _A ~| _A;
    wire _notB = _B ~| _B;
    wire _notC = _C ~| _C;
    wire _notD = _D ~| _D;
    wire _notE = _E ~| _E;
    wire _notH = _H ~| _H;
    wire _notL = _L ~| _L;

    assign PR_Write_A = _notXPT10 ~| _notA;
    assign PR_Write_B = _notXPT10 ~| _notB;
    assign PR_Write_C = _notXPT10 ~| _notC;
    assign PR_Write_D = _notXPT10 ~| _notD;
    assign PR_Write_E = _notXPT10 ~| _notE;
    assign PR_Write_H = _notXPT10 ~| _notH;
    assign PR_Write_L = _notXPT10 ~| _notL;

    assign PR_InvertIn = (PR_Write_A | PR_Write_B | PR_Write_D | PR_Write_H); // 6

endmodule