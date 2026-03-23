// 3(80)
module DECODER_op_X1_11xxx11(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CMA, // >
        output wire P2_Set_IADDAn,
        output wire P2_Set_IADCAn,
        output wire P2_Set_ISUBAn,
        output wire P2_Set_ISBCAn,
        output wire P2_Set_IANDn,
        output wire P2_Set_IXORn,
        output wire P2_Set_IORn,
        output wire P2_Set_ICPn,
        output wire PR_Dec_SP,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PI_SelectDt_PC_high,
        output wire PI_SelectDt_PC_low,
        output wire PI_SelectAd_SP,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low, // >
        output wire PA_Select_0x8_low,
        output wire PA_Select_0x10_low,
        output wire PA_Select_0x18_low,
        output wire PA_Select_0x20_low,
        output wire PA_Select_0x28_low,
        output wire PA_Select_0x30_low,
        output wire PA_Select_0x38_low
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11xxx110;
    wire _11xxx111;

    DECODER_1bit_decoder d_11xxx11d(
        .notEnable(_not_enable),
        .In(Source[0]),
        .notIn(notSource[0]),
        .out0(_11xxx110),
        .out1(_11xxx111)
    );

    wire _PR_Reset_XPT_0;

    DECODER_op_X1_11xxx110 d11xxx110(
        .enable(_11xxx110),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CMA(P2_Set_CMA), // >
        .P2_Set_IADDAn(P2_Set_IADDAn),
        .P2_Set_IADCAn(P2_Set_IADCAn),
        .P2_Set_ISUBAn(P2_Set_ISUBAn),
        .P2_Set_ISBCAn(P2_Set_ISBCAn),
        .P2_Set_IANDn(P2_Set_IANDn),
        .P2_Set_IXORn(P2_Set_IXORn),
        .P2_Set_IORn(P2_Set_IORn),
        .P2_Set_ICPn(P2_Set_ICPn)
    );

    wire _PR_Reset_XPT_1;

    DECODER_op_X1_11xxx111 d11xxx111(
        .enable(_11xxx111),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Dec_SP(PR_Dec_SP),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PI_SelectDt_PC_high(PI_SelectDt_PC_high),
        .PI_SelectDt_PC_low(PI_SelectDt_PC_low),
        .PI_SelectAd_SP(PI_SelectAd_SP),
        .PR_Reset_XPT(_PR_Reset_XPT_1), // <
        .P2_Set_CM1(P2_Set_CM1),
        .Pa_Ophd(Pa_Ophd),
        .PA_NOP(PA_NOP),
        .PR_Write_PC_high(PR_Write_PC_high),
        .PR_Write_PC_low(PR_Write_PC_low), // >
        .PA_Select_0x8_low(PA_Select_0x8_low),
        .PA_Select_0x10_low(PA_Select_0x10_low),
        .PA_Select_0x18_low(PA_Select_0x18_low),
        .PA_Select_0x20_low(PA_Select_0x20_low),
        .PA_Select_0x28_low(PA_Select_0x28_low),
        .PA_Select_0x30_low(PA_Select_0x30_low),
        .PA_Select_0x38_low
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2

endmodule