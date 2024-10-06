// 25(50)
module DECODER_I_110x1(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [10:0] _decodedXPT,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OP_low,
        output wire PR_Write_Dt,
        output wire PR_Write_Dtex,
        output wire PI_SelectAd_DtexDt,
        output wire PC_RA0,
        output wire PC_RA1,
        output wire PC_RA2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire PA_Select_A_high,
        output wire PR_InvertIn,
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Write_N,
        output wire PF_Write_C,
        output wire Pa_Ophd, // >
        output wire PR_Write_A,
        output wire PA_ADD,
        output wire PA_ADC,
        output wire PA_SUB,
        output wire PA_SBC,
        output wire PA_AND,
        output wire PA_OR,
        output wire PA_XOR,
        output wire PF_Select_H_bit22,
        output wire PF_Select_N_bit17,
        output wire PF_Select_C_bit26,
        output wire PF_Select_H_bit21,
        output wire PF_Select_C_bit23,
        output wire PF_Select_H_bit16,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_C_bit16,
        output wire PF_Select_H_bit17,
        output wire PF_Select_N_bit16,
        output wire PF_Select_PV_bit25,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_S_bit7
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //
    wire _not_enable = enable ~| enable;

    wire _110x1x00; // ADD/ADC
    wire _110x1x01; // SUB/SBC
    wire _110x1x10; // AND/XOR
    wire _110x1x11; // OR/CP

    wire _not_decodedXPT10 = _decodedXPT[10] ~| _decodedXPT[10];

    DECODER_2bit_decoder d_110x1xdd( // 8
        .notEnable(_not_decodedXPT10),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_110x1x00),
        .out01(_110x1x01),
        .out10(_110x1x10),
        .out11(_110x1x11)
    );

    wire _not110x1x00 = _110x1x00 ~| _110x1x00;
    wire _not110x1x01 = _110x1x01 ~| _110x1x01;
    wire _not110x1x10 = _110x1x10 ~| _110x1x10;
    wire _not110x1x11 = _110x1x11 ~| _110x1x11;

    wire _110x1000; // ADD
    wire _110x1100; // ADC
    wire _110x1001; // SUB
    wire _110x1101; // SBC
    wire _110x1010; // AND
    wire _110x1110; // XOR
    wire _110x1011; // OR
    wire _110x1111; // CP

    DECODER_1bit_decoder d_110x1d00(
        .notEnable(_not110x1x00),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_110x1000),
        .out1(_110x1100),
    );

    DECODER_1bit_decoder d_110x1d01(
        .notEnable(_not110x1x01),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_110x1001),
        .out1(_110x1101),
    );

    DECODER_1bit_decoder d_110x1d10(
        .notEnable(_not110x1x10),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_110x1010),
        .out1(_110x1110),
    );

    DECODER_1bit_decoder d_110x1d11(
        .notEnable(_not110x1x11),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_110x1011),
        .out1(_110x1111),
    );

    wire _X;
    wire _Y;

    wire _not_decodedXPT3 = _decodedXPT[3] ~| _decodedXPT[3];

    DECODER_1bit_decoder d_110d1xxx(
        .notEnable(_not_decodedXPT3),
        .In(ITABLE[4]),
        .notIn(notITABLE[4]),
        .out0(_X),
        .out1(_Y),
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

    wire _nott0xxx = _t0xxx ~| _t0xxx;

    assign _decodedXPT[3] = _nott0xxx ~| notXPT[0];

    wire _nott1xxx = _t1xxx ~| _t1xxx;

    DECODER_2bit_decoder t_10dd( // 5
        .notEnable(_nott1xxx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    // 3or10_i000

    assign PA_Select_IX_high = _X;
    assign PA_Select_IY_high = _Y;

    assign PA_Select_OP_low = _decodedXPT[3];
    assign PR_Write_Dt = _decodedXPT[3];
    assign PR_Write_Dtex = _decodedXPT[3];

    assign PA_ADD = (_decodedXPT[3] | _110x1000); // 2

    // 8~10

    assign PI_SelectAd_DtexDt = _t1xxx;

    // 8

    assign PC_RA0 = _decodedXPT[8];

    // 9

    assign PC_RA1 = _decodedXPT[9];

    // 10

    assign PC_RA2 = _decodedXPT[10];

    assign PR_Reset_XPT = _decodedXPT[10];
    assign P2_Set_CM1 = _decodedXPT[10];
    assign P2_Reset_ITABLE = _decodedXPT[10];
    assign PA_Select_A_high = _decodedXPT[10];
    assign PR_InvertIn = _decodedXPT[10];
    assign PF_Write_S = _decodedXPT[10];
    assign PF_Write_Z = _decodedXPT[10];
    assign PF_Write_H = _decodedXPT[10];
    assign PF_Write_PV = _decodedXPT[10];
    assign PF_Write_N = _decodedXPT[10];
    assign PF_Write_C = _decodedXPT[10];
    assign Pa_Ophd = _decodedXPT[10];

    assign PF_Select_Z_bit24 = _decodedXPT[10];
    assign PF_Select_S_bit7 = _decodedXPT[10];

    assign PR_Write_A = _not_decodedXPT10 ~| _110x1111;

    wire _SUB_CP = (_110x1001 | _110x1111); // 2

    assign PA_SUB = _SUB_CP;

    assign PA_AND = _110x1010;
    assign PA_OR = _110x1011;
    assign PA_ADC = _110x1100;
    assign PA_SBC = _110x1101;
    assign PA_XOR = _110x1110;

    wire _FT_SUB = (_SUB_CP | _110x1101); // 2
    wire _FT_OR = (_110x1011 | _110x1110); // 2

    assign PF_Select_H_bit21 = _110x1x00;
    assign PF_Select_C_bit23 = _110x1x00;

    assign PF_Select_H_bit22 = _FT_SUB;
    assign PF_Select_N_bit17 = _FT_SUB;
    assign PF_Select_C_bit26 = _FT_SUB;

    assign PF_Select_H_bit16 = _FT_OR;

    assign PF_Select_PV_bit27 = (_FT_OR | _110x1010); // 2
    assign PF_Select_C_bit16 = PF_Select_PV_bit27;

    assign PF_Select_H_bit17 = _110x1010;

    assign PF_Select_N_bit16 = (_110x1x00 | PF_Select_PV_bit27); // 2

    assign PF_Select_PV_bit25 = (_110x1x00 | _FT_SUB); // 2

endmodule