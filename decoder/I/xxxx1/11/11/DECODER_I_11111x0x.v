// INC/DEC (IX+d)/(IY+d)
// 15(36)
module DECODER_I_11111x0x(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire [14:0] _decodedXPT,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OP_low,
        output wire PF_Select_N_bit16, // <
        output wire PF_Select_H_bit21, // >
        output wire PF_Select_N_bit17, // <
        output wire PF_Select_H_bit22,
        output wire PA_SUB, // >
        output wire PA_ADD,
        output wire PR_Write_Dtex,
        output wire PR_Write_Dt,
        output wire PI_SelectAd_DtexDt,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PA_Select_Dt_high, // <
        output wire PA_Select_0x1_low,
        output wire PF_Write_S,
        output wire PF_Select_S_bit7,
        output wire PF_Write_Z,
        output wire PF_Select_Z_bit24,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Select_PV_bit25,
        output wire PF_Write_N, // >
        output wire PI_SelectAd_ALU, // <
        output wire PI_SelectDt_Dt, // >
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
    // XPT
    //

    wire _not_enable = enable ~| enable;

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

    wire _t10xx;
    wire _t11xx;

    DECODER_1bit_decoder t_1dxx(
        .notEnable(_nott1xxx),
        .In(XPT[2]),
        .notIn(notXPT[2]),
        .out0(_t10xx),
        .out1(_t11xx),
    );

    wire _nott10xx = _t10xx ~| _t10xx;
    wire _nott11xx = _t11xx ~| _t11xx;

    wire _t8or9;
    wire _t10or11;

    DECODER_2bit_decoder t_10dd( // 8
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out0x(_t8or9),
        .out1x(_t10or11),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out10(_decodedXPT[10]),
        .out11(_decodedXPT[11])
    );

    DECODER_2bit_decoder t_11dd( // 5
        .notEnable(_nott11xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[12]),
        .out01(_decodedXPT[13]),
        .out1x(_decodedXPT[14])
    );

    //
    // decoder
    //

    wire _nott3ort12_14 = _decodedXPT[3] ~| _t11xx;

    DECODER_1bit_decoder d_11111x0d(
        .notEnable(_nott3ort12_14),
        .In(ITABLE[0]),
        .notIn(notITABLE[0]),
        .out0(PA_Select_IX_high),
        .out1(PA_Select_IY_high),
    );

    wire _3or12_14 = _nott3ort12_14 ~| _nott3ort12_14;

    assign PA_Select_OP_low = _3or12_14;

    wire _nott11 = _decodedXPT[11] ~| _decodedXPT[11];

    DECODER_1bit_decoder d_11111d0x(
        .notEnable(_nott11),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(PF_Select_H_bit21),
        .out1(PF_Select_H_bit22),
    );

    assign PF_Select_N_bit16 = PF_Select_H_bit21;
    assign PF_Select_N_bit17 = PF_Select_H_bit22;
    assign PA_SUB = PF_Select_H_bit22;

    assign PA_ADD = (_3or12_14 | PF_Select_H_bit21); // 2

    // 3

    assign PR_Write_Dtex = _decodedXPT[3];

    // 3or10,11

    assign PR_Write_Dt = (_decodedXPT[3] | _t10or11); // 2

    // 8~10

    assign PI_SelectAd_DtexDt = (_decodedXPT[10] | _t8or9); // 2

    // 8

    assign PC_R0 = _decodedXPT[8];

    // 9

    assign PC_R1 = _decodedXPT[9];

    // 10

    assign PC_R2 = _decodedXPT[10];

    // 11

    assign PA_Select_Dt_high = _decodedXPT[11];
    assign PA_Select_0x1_low = _decodedXPT[11];
    assign PF_Write_S = _decodedXPT[11];
    assign PF_Select_S_bit7 = _decodedXPT[11];
    assign PF_Write_Z = _decodedXPT[11];
    assign PF_Select_Z_bit24 = _decodedXPT[11];
    assign PF_Write_H = _decodedXPT[11];
    assign PF_Write_PV = _decodedXPT[11];
    assign PF_Select_PV_bit25 = _decodedXPT[11];
    assign PF_Write_N = _decodedXPT[11];

    // 12~14

    assign PI_SelectAd_ALU = _t11xx;
    assign PI_SelectDt_Dt = _t11xx;

    // 12

    assign PC_W0 = _decodedXPT[12];

    // 13

    assign PC_W1 = _decodedXPT[13];

    // 14

    assign PC_W2 = _decodedXPT[14];

    assign PR_Reset_XPT = _decodedXPT[14];
    assign P2_Set_CM1 = _decodedXPT[14];
    assign P2_Reset_ITABLE = _decodedXPT[14];
    assign Pa_Ophd = _decodedXPT[14];

endmodule