// 3(34)
module DECODER_op_XOTR_01xxx10(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd,
        output wire PR_InvertIn, // >
        output wire PA_Select_A_low, // <
        output wire PA_SUB,
        output wire PR_Write_A,
        output wire PF_Write_C,
        output wire PF_Write_Z,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_C_bit26,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit25,
        output wire PF_Select_S_bit7,
        output wire PF_Select_N_bit17,
        output wire PF_Select_H_bit22, // >
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire P2_RestoreIFF
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _01xxx100;
    wire _01xxx101;

    DECODER_1bit_decoder d_01xxx10d(
        .notEnable(_not_enable),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_01xxx100),
        .out1(_01xxx101),
    );

    wire _PR_Reset_XPT_0; // <
    wire _P2_Set_CM1_0;
    wire _P2_Reset_XOTR_0;
    wire _PR_InvertIn_0;
    wire _Pa_Ophd_0; // >

    DECODER_op_XOTR_01xxx100 d01xxx100(
        .enable(_01xxx100),
        .XPT(XPT),
        .notXPT(notXPT),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .P2_Reset_XOTR(_P2_Reset_XOTR_0),
        .Pa_Ophd(_Pa_Ophd_0),
        .PA_Select_A_low(PA_Select_A_low),
        .PA_SUB(PA_SUB),
        .PR_Write_A(PR_Write_A),
        .PR_InvertIn(_PR_InvertIn_0),
        .PF_Write_C(PF_Write_C),
        .PF_Write_Z(PF_Write_Z),
        .PF_Write_PV(PF_Write_PV),
        .PF_Write_S(PF_Write_S),
        .PF_Write_N(PF_Write_N),
        .PF_Write_H(PF_Write_H),
        .PF_Select_C_bit26(PF_Select_C_bit26),
        .PF_Select_Z_bit24(PF_Select_Z_bit24),
        .PF_Select_PV_bit25(PF_Select_PV_bit25),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PF_Select_N_bit17(PF_Select_N_bit17),
        .PF_Select_H_bit22(PF_Select_H_bit22) // >
    );

    wire _PR_Reset_XPT_1; // <
    wire _P2_Set_CM1_1;
    wire _P2_Reset_XOTR_1;
    wire _PR_InvertIn_1;
    wire _Pa_Ophd_1; // >

    DECODER_op_XOTR_01xxx101 d01xxx101(
        .enable(_01xxx101),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Inc_SP(PR_Inc_SP),
        .PR_Write_PC_low(PR_Write_PC_low),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .P2_Reset_XOTR(_P2_Reset_XOTR_1),
        .Pa_Ophd(_Pa_Ophd_1),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_InvertIn(_PR_InvertIn_1), // >
        .P2_RestoreIFF(P2_RestoreIFF)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign P2_Reset_XOTR = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;
    assign PR_InvertIn = PR_Reset_XPT;

endmodule