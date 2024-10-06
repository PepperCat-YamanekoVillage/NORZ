// 5(75)
module DECODER_I_00101(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PC_I0,
        output wire PC_I1,
        output wire PC_I2,
        output wire PC_I3,
        output wire PC_O0,
        output wire PC_O1,
        output wire PC_O2,
        output wire PC_O3,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire PI_SelectAd_AOP,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PI_SelectDt_A,
        output wire P2_Set_ILDlnnlIX_1,
        output wire P2_Set_ILDlnnlIY_1,
        output wire P2_Set_CMR,
        output wire PI_SelectDt_IX_low,
        output wire PI_SelectDt_IY_low,
        output wire PI_SelectDt_IX_high,
        output wire PI_SelectDt_IY_high,
        output wire PI_SelectAdt1,
        output wire PI_SelectAd_OPOPold,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //      
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00101x0x;
    wire _00101x1x;

    DECODER_1bit_decoder d_00101xdx(
        .notEnable(_not_enable),
        .In(ITABLE[1]),
        .notIn(notITABLE[1]),
        .out0(_00101x0x),
        .out1(_00101x1x),
    );

    wire _PR_Reset_XPT_0; // <
    wire _P2_Set_CM1_0;
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >

    DECODER_I_0010100 d0010100(
        .enable(_00101x0x),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PC_I0(PC_I0),
        .PC_I1(PC_I1),
        .PC_I2(PC_I2),
        .PC_I3(PC_I3),
        .PC_O0(PC_O0),
        .PC_O1(PC_O1),
        .PC_O2(PC_O2),
        .PC_O3(PC_O3),
        .PR_Write_A(PR_Write_A), // <
        .PR_InvertIn(PR_InvertIn), // >
        .PI_SelectAd_AOP(PI_SelectAd_AOP),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .Pa_Ophd(_Pa_Ophd_0), // >
        .PI_SelectDt_A(PI_SelectDt_A)
    );

    wire _PR_Reset_XPT_1;
    wire _P2_Set_CM1_1; // <
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >

    DECODER_I_00101x1 d00101x1(
        .enable(_00101x1x),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_ILDlnnlIX_1(P2_Set_ILDlnnlIX_1),
        .P2_Set_ILDlnnlIY_1(P2_Set_ILDlnnlIY_1),
        .P2_Set_CMR(P2_Set_CMR),
        .PR_Reset_XPT(_PR_Reset_XPT_1),
        .PI_SelectDt_IX_low(PI_SelectDt_IX_low),
        .PI_SelectDt_IY_low(PI_SelectDt_IY_low),
        .PI_SelectDt_IX_high(PI_SelectDt_IX_high),
        .PI_SelectDt_IY_high(PI_SelectDt_IY_high),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PI_SelectAd_OPOPold(PI_SelectAd_OPOPold),
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .P2_Set_CM1(_P2_Set_CM1_1), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .Pa_Ophd(_Pa_Ophd_1) // >
    );

    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

endmodule