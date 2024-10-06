// INC/DEC r/(HL)
// 19(60)
module DECODER_op_X1_00xxx10(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [10:0] _decodedXPT,
        output wire PA_Select_B_high, // <
        output wire PR_Write_B, // >
        output wire PA_Select_C_high, // <
        output wire PR_Write_C, // >
        output wire PA_Select_D_high, // <
        output wire PR_Write_D, // >
        output wire PA_Select_E_high, // <
        output wire PR_Write_E, // >
        output wire PA_Select_H_high, // <
        output wire PR_Write_H, // >
        output wire PA_Select_L_high, // <
        output wire PR_Write_L, // >
        output wire PA_Select_A_high, // <
        output wire PR_Write_A, // >
        output wire PR_InvertIn,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PA_Select_0x1_low, // <
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Write_N,
        output wire PF_Select_S_bit7,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit25, // >
        output wire PA_ADD, // <
        output wire PF_Select_H_bit21,
        output wire PF_Select_N_bit16, // >
        output wire PA_SUB, // <
        output wire PF_Select_H_bit22,
        output wire PF_Select_N_bit17, // >
        output wire PI_SelectAd_HL,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_Dt,
        output wire PA_Select_Dt_high,
        output wire PI_SelectDt_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    wire _t00xx;
    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 8
        .notEnable(_not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_t10xx)
    );

    wire _nott00xx = _t00xx ~| _t00xx;
    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;

    assign _decodedXPT[3] = _nott00xx ~| notXPT[0];

    wire _t6or7;

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7]),
        .out1x(_t6or7)
    );

    DECODER_2bit_decoder t_10dd( // 5
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _00xx010x_t3;
    wire _00xx110x_t3;

    DECODER_1bit_decoder d_00xxd10x_t3(
        .notEnable(_nott3),
        .In(Source[3]),
        .notIn(notSource[3]),
        .out0(_00xx010x_t3),
        .out1(_00xx110x_t3)
    ); 

    wire _not00xx010x_t3 = _00xx010x_t3 ~| _00xx010x_t3;
    wire _not00xx110x_t3 = _00xx110x_t3 ~| _00xx110x_t3;

    wire _B;
    wire _C;
    wire _D;
    wire _E;
    wire _H;
    wire _L;
    wire _HL;
    wire _A;

    DECODER_2bit_decoder d_00dd010x_t3( // 8
        .notEnable(_not00xx010x_t3),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(_B),
        .out01(_D),
        .out10(_H),
        .out11(_HL)
    );

    DECODER_2bit_decoder d_00dd110x_t3( // 8
        .notEnable(_not00xx110x_t3),
        .In(Source[5:4]),
        .notIn(notSource[5:4]),
        .out00(_C),
        .out01(_E),
        .out10(_L),
        .out11(_A)
    );

    wire _t3_r = _nott3 ~| _HL;

    // 3_r

    assign PA_Select_B_high = _B;
    assign PR_Write_B = _B;
    assign PA_Select_C_high = _C;
    assign PR_Write_C = _C;
    assign PA_Select_D_high = _D;
    assign PR_Write_D = _D;
    assign PA_Select_E_high = _E;
    assign PR_Write_E = _E;
    assign PA_Select_H_high = _H;
    assign PR_Write_H = _H;
    assign PA_Select_L_high = _L;
    assign PR_Write_L = _L;
    assign PA_Select_A_high = _A;
    assign PR_Write_A = _A;

    assign PR_InvertIn = (_00xx010x_t3 | _A); // 2

    // 3_r or 10

    assign PR_Reset_XPT = (_t3_r | _decodedXPT[10]); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    // 3_r or 7

    assign PA_Select_0x1_low = (_t3_r | _decodedXPT[7]); // 2
    assign PF_Write_S = PA_Select_0x1_low;
    assign PF_Write_Z = PA_Select_0x1_low;
    assign PF_Write_H = PA_Select_0x1_low;
    assign PF_Write_PV = PA_Select_0x1_low;
    assign PF_Write_N = PA_Select_0x1_low;
    assign PF_Select_S_bit7 = PA_Select_0x1_low;
    assign PF_Select_Z_bit24 = PA_Select_0x1_low;
    assign PF_Select_PV_bit25 = PA_Select_0x1_low;

    wire _nott3ror7 = PA_Select_0x1_low ~| PA_Select_0x1_low;

    wire _INC;
    wire _DEC;

    DECODER_1bit_decoder d_00xxx10d_t3ror7(
        .notEnable(_nott3ror7),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_INC),
        .out1(_DEC)
    ); 

    assign PA_ADD = _INC;
    assign PF_Select_H_bit21 = _INC;
    assign PF_Select_N_bit16 = _INC;

    assign PA_SUB = _DEC;
    assign PF_Select_H_bit22 = _DEC;
    assign PF_Select_N_bit17 = _DEC;

    // 4~6or8~9

    wire _t4_6 = _nott01xx ~| _decodedXPT[7];

    assign PI_SelectAd_HL = (_t4_6 | _t10xx); // 2

    // 4

    assign PC_R0 = _decodedXPT[4];

    // 5

    assign PC_R1 = _decodedXPT[5];

    // 6

    assign PC_R2 = _decodedXPT[6];

    // 6or7

    assign PR_Write_Dt = _t6or7;

    // 7

    assign PA_Select_Dt_high =_decodedXPT[7];

    // 8~9

    assign PI_SelectDt_Dt = _t10xx;

    // 8

    assign PC_W0 = _decodedXPT[8];

    // 9

    assign PC_W1 = _decodedXPT[9];

    // 10

    assign PC_W2 = _decodedXPT[10];

endmodule