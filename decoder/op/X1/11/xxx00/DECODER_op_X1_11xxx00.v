// 19(150)
module DECODER_op_X1_11xxx00(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_PV,
        input wire Flag_S,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd, // >
        output wire PI_SelectAd_SP,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Inc_SP,
        output wire PR_Write_PC_low,
        output wire PR_Write_PC_high,
        output wire PR_InvertIn,
        output wire PA_NOP, // <
        output wire PA_Select_HL_low, // >
        output wire PR_Write_SP,
        output wire PR_Exx,
        output wire PR_Write_B,
        output wire PR_Write_C,
        output wire PR_Write_D,
        output wire PR_Write_E,
        output wire PR_Write_H,
        output wire PR_Write_L,
        output wire PR_Write_A,
        output wire PR_Write_F
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11xxx000;
    wire _11xxx001;

    DECODER_1bit_decoder d_11xxx00d(
        .notEnable(_not_enable),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_11xxx000),
        .out1(_11xxx001)
    );

    wire _PR_Reset_XPT_0; // <
    wire _P2_Set_CM1_0;
    wire _Pa_Ophd_0; // >
    wire _PI_SelectAd_SP_0;
    wire _PC_R0_0;
    wire _PC_R1_0;
    wire _PC_R2_0;
    wire _PR_Inc_SP_0;
    wire _PR_Write_PC_low_0;
    wire _PR_Write_PC_high_0;
    wire _PR_InvertIn_0;

    DECODER_op_X1_11xxx000 d11xxx000(
        .enable(_11xxx000),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .Flag_Z(Flag_Z),
        .Flag_C(Flag_C),
        .Flag_PV(Flag_PV),
        .Flag_S(Flag_S),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .Pa_Ophd(_Pa_Ophd_0), // >
        .PI_SelectAd_SP(_PI_SelectAd_SP_0),
        .PC_R0(_PC_R0_0),
        .PC_R1(_PC_R1_0),
        .PC_R2(_PC_R2_0),
        .PR_Inc_SP(_PR_Inc_SP_0),
        .PR_Write_PC_low(_PR_Write_PC_low_0),
        .PR_Write_PC_high(_PR_Write_PC_high_0), // <
        .PR_InvertIn(_PR_InvertIn_0) // >
    );

    wire _PR_Reset_XPT_1; // <
    wire _P2_Set_CM1_1;
    wire _Pa_Ophd_1; // >
    wire _PI_SelectAd_SP_1;
    wire _PC_R0_1;
    wire _PC_R1_1;
    wire _PC_R2_1;
    wire _PR_Inc_SP_1;
    wire _PR_Write_PC_low_1;
    wire _PR_Write_PC_high_1;
    wire _PR_InvertIn_1;

    DECODER_op_X1_11xxx001 d11xxx001(
        .enable(_11xxx001),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(_P2_Set_CM1_1),
        .Pa_Ophd(_Pa_Ophd_1), // >
        .PA_NOP(PA_NOP), // <
        .PA_Select_HL_low(PA_Select_HL_low), // >
        .PR_Write_SP(PR_Write_SP),
        .PR_Exx(PR_Exx),
        .PR_Write_PC_high(_PR_Write_PC_high_1),
        .PR_Write_PC_low(_PR_Write_PC_low_1),
        .PI_SelectAd_SP(_PI_SelectAd_SP_1),
        .PC_R0(_PC_R0_1),
        .PC_R1(_PC_R1_1),
        .PC_R2(_PC_R2_1),
        .PR_Inc_SP(_PR_Inc_SP_1),
        .PR_InvertIn(_PR_InvertIn_1),
        .PR_Write_B(PR_Write_B),
        .PR_Write_C(PR_Write_C),
        .PR_Write_D(PR_Write_D),
        .PR_Write_E(PR_Write_E),
        .PR_Write_H(PR_Write_H),
        .PR_Write_L(PR_Write_L),
        .PR_Write_A(PR_Write_A),
        .PR_Write_F(PR_Write_F)
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2 // <
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;
    
    assign PI_SelectAd_SP = (_PI_SelectAd_SP_0 | _PI_SelectAd_SP_1); // 2
    assign PC_R0 = (_PC_R0_0 | _PC_R0_1); // 2
    assign PC_R1 = (_PC_R1_0 | _PC_R1_1); // 2
    assign PC_R2 = (_PC_R2_0 | _PC_R2_1); // 2
    assign PR_Inc_SP = (_PR_Inc_SP_0 | _PR_Inc_SP_1); // 2
    assign PR_Write_PC_low = (_PR_Write_PC_low_0 | _PR_Write_PC_low_1); // 2
    assign PR_Write_PC_high = (_PR_Write_PC_high_0 | _PR_Write_PC_high_1); // 2
    assign PR_InvertIn = (_PR_InvertIn_0 | _PR_InvertIn_1); // 2

endmodule