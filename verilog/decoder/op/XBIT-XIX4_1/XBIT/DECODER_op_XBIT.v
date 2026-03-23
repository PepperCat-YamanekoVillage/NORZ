// RLC/RL/RRC/RR/SLA/SRA/SRL r/(HL) / BIT/SET/RES b,r/(HL)
// 16(87)
module DECODER_op_XBIT(
        input wire not_enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire [10:0] _decodedXPT,
        output wire enable_bit,
        output wire PR_Inc_PC,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XBIT,
        output wire Pa_Ophd, // >
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PA_Select_B_low,
        output wire PA_Select_C_low,
        output wire PA_Select_D_low,
        output wire PA_Select_E_low,
        output wire PA_Select_H_low,
        output wire PA_Select_L_low,
        output wire PA_Select_A_low,
        output wire PA_Select_B_high,
        output wire PA_Select_C_high,
        output wire PA_Select_D_high,
        output wire PA_Select_E_high,
        output wire PA_Select_H_high,
        output wire PA_Select_L_high,
        output wire PA_Select_A_high,
        output wire PR_InvertIn,
        output wire PI_SelectAd_HL,
        output wire PR_Write_Dt,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PA_Select_Dt_low,
        output wire PA_Select_Dt_high,
        output wire PI_SelectDt_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _t00xx;
    wire _t01xx;
    wire _t10xx;

    DECODER_2bit_decoder t_ddxx( // 5
        .notEnable(not_enable),
        .In(XPT[3:2]),
        .notIn(notXPT[3:2]),
        .out00(_t00xx),
        .out01(_t01xx),
        .out1x(_t10xx)
    );

    wire _nott00xx = _t00xx ~| _t00xx;
    wire _nott01xx = _t01xx ~| _t01xx;
    wire _nott10xx = _t10xx ~| _t10xx;

    DECODER_1bit_decoder t_001d(
        .notEnable(_nott00xx),
        .In(XPT[0]),
        .notIn(notXPT[0]),
        .out0(_decodedXPT[2]),
        .out1(_decodedXPT[3])
    );

    DECODER_2bit_decoder t_01dd( // 8
        .notEnable(_nott01xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[4]),
        .out01(_decodedXPT[5]),
        .out10(_decodedXPT[6]),
        .out11(_decodedXPT[7])
    );

    DECODER_2bit_decoder t_10dd( // 5
        .notEnable(_nott10xx),
        .In(XPT[1:0]),
        .notIn(notXPT[1:0]),
        .out00(_decodedXPT[8]),
        .out01(_decodedXPT[9]),
        .out1x(_decodedXPT[10])
    );

    // 2

    assign PR_Inc_PC = _decodedXPT[2];

    //
    // r
    //

    wire _enable_bit_r;
    wire _PR_Reset_XPT_r; // <
    wire _P2_Set_CM1_r;
    wire _P2_Reset_XBIT_r;
    wire _Pa_Ophd_r; // >

    DECODER_op_XBIT_r r(
        .decodedXPT3(_decodedXPT[3]),
        .Source(Source),
        .notSource(notSource),
        .enable_bit(_enable_bit_r),
        .PR_Reset_XPT(_PR_Reset_XPT_r), // <
        .P2_Set_CM1(_P2_Set_CM1_r),
        .P2_Reset_XBIT(_P2_Reset_XBIT_r),
        .Pa_Ophd(_Pa_Ophd_r), // >
        .PR_Write_B(PR_Write_B),
        .PR_Write_C(PR_Write_C),
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E),
        .PR_Write_H(PR_Write_H),
        .PR_Write_L(PR_Write_L),
        .PR_Write_A(PR_Write_A),
        .PA_Select_B_low(PA_Select_B_low),
        .PA_Select_C_low(PA_Select_C_low),
        .PA_Select_D_low(PA_Select_D_low),
        .PA_Select_E_low(PA_Select_E_low),
        .PA_Select_H_low(PA_Select_H_low),
        .PA_Select_L_low(PA_Select_L_low),
        .PA_Select_A_low(PA_Select_A_low),
        .PA_Select_B_high(PA_Select_B_high),
        .PA_Select_C_high(PA_Select_C_high),
        .PA_Select_D_high(PA_Select_D_high),
        .PA_Select_E_high(PA_Select_E_high),
        .PA_Select_H_high(PA_Select_H_high),
        .PA_Select_L_high(PA_Select_L_high),
        .PA_Select_A_high(PA_Select_A_high),
        .PR_InvertIn(PR_InvertIn)
    );

    //
    // (HL)
    //

    // 4~6or8~10

    wire _t4_7 = _nott01xx ~| _decodedXPT[7];

    assign PI_SelectAd_HL = (_t4_7 | _t10xx); // 2

    // 4

    assign PC_R0 = _decodedXPT[4];

    // 5

    assign PC_R1 = _decodedXPT[5];

    // 6

    assign PC_R2 = _decodedXPT[6];

    // 7

    assign enable_bit = (_decodedXPT[7] | _enable_bit_r); // 2

    wire _notdecodedXPT7 = _decodedXPT[7] ~| _decodedXPT[7];

    wire _t7_RRR;
    wire _t7_BIT;
    wire _t7_RRRBIT;
    wire _t7_RESSET;

    DECODER_2bit_decoder d_ddxxxxxx( // 5
        .notEnable(_notdecodedXPT7),
        .In(Source[7:6]),
        .notIn(notSource[7:6]),
        .out00(_t7_RRR),
        .out01(_t7_BIT),
        .out0x(_t7_RRRBIT),
        .out1x(_t7_RESSET)
    );

    assign PA_Select_Dt_low = _t7_RRRBIT;
    assign PA_Select_Dt_high = _t7_RESSET;

    wire _t_notBIT = _notdecodedXPT7 ~| _t7_BIT;

    assign PR_Write_Dt = (_t_notBIT | _decodedXPT[6]); // 2

    // 8~9
    
    assign PI_SelectDt_Dt = _t10xx;

    // 8

    assign PC_W0 = _decodedXPT[8];

    // 9

    assign PC_W1 = _decodedXPT[9];

    // 10

    assign PC_W2 = _decodedXPT[10];

    // end

    assign PR_Reset_XPT = (_PR_Reset_XPT_r | _t7_BIT | _decodedXPT[10]); // 4
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign P2_Reset_XBIT = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

endmodule