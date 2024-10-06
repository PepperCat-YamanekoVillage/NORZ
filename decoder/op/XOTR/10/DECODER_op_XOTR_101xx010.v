// INI/INIR/IND/INDR
// 12(36)
module DECODER_op_XOTR_101xx010(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [11:0] _decodedXPT,
        output wire PA_ADD,
        output wire PA_SUB,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PI_SelectAd_BC,
        output wire PR_Write_Dt,
        output wire PI_SelectAd_HL, // <
        output wire PI_SelectDt_Dt, // >
        output wire PA_Select_0x1_low,
        output wire PA_Select_B_high, // <
        output wire PR_Write_B,
        output wire PF_Write_Z,
        output wire PF_Write_N,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_N_bit17, // >
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PA_Select_HL_high, // <
        output wire PR_Write_H,
        output wire PR_Write_L // >
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 6 R系はT16なので1x系にしないこと
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out01(_t01xx),
        .out10(_t10xx)
    );

    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    DECODER_2bit_decoder t_10dd( // 8
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out10(_decodedXPT[10]),
        .out11(_decodedXPT[11])
    );

    // 5

    assign PC_I0 = _decodedXPT[5];

    // 6

    assign PC_I1 = _decodedXPT[6];

    // 7

    assign PC_I2 = _decodedXPT[7];

    // 8

    assign PC_I3 = _decodedXPT[8];

    assign PR_Write_Dt = _decodedXPT[8];

    // 5~8

    wire _t5_7 = _nott01xx ~| _decodedXPT[4];
    wire _t5_8 = (_t5_7 | _decodedXPT[8]); // 2
    assign PI_SelectAd_BC = _t5_8;

    // 9~11

    wire _t9_11 = _nott10xx ~| _decodedXPT[8];

    assign PI_SelectAd_HL = _t9_11;
    assign PI_SelectDt_Dt = _t9_11;

    // 9or11

    assign PA_Select_0x1_low = (_decodedXPT[9] | _decodedXPT[11]); // 2

    // 9

    assign PC_W0 = _decodedXPT[9];

    assign PA_Select_B_high = _decodedXPT[9];
    assign PR_Write_B = _decodedXPT[9];
    assign PF_Write_Z = _decodedXPT[9];
    assign PF_Write_N = _decodedXPT[9];
    assign PF_Select_Z_bit24 = _decodedXPT[9];
    assign PF_Select_N_bit17 = _decodedXPT[9];

    // 10

    assign PC_W1 = _decodedXPT[10];

    // 11

    assign PC_W2 = _decodedXPT[11];

    assign PA_Select_HL_high = _decodedXPT[11];
    assign PR_Write_H = _decodedXPT[11];
    assign PR_Write_L = _decodedXPT[11];

    wire _nott11 = _decodedXPT[11] ~| _decodedXPT[11];

    wire _PA_SUB;

    DECODER_1bit_decoder d_101xd010(
        .notEnable(_nott11),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(PA_ADD),
        .out1(_PA_SUB)
    );

    assign PA_SUB = (_PA_SUB | _decodedXPT[9]); // 2

endmodule