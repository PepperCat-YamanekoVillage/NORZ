// 8(54)
module DECODER_I_00001xx1(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PI_SelectAd_OPOPold,
        output wire PI_SelectDt_A,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PR_Write_L,
        output wire PI_SelectAdt1,
        output wire PR_Write_H,
        output wire PR_InvertIn,
        output wire PR_Write_IX_high,
        output wire PR_Write_IY_high
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00001x01;
    wire _00001x11;

    DECODER_1bit_decoder d_00001xd1(
        .notEnable(_not_enable),
        .In(ITABLE[1]),
        .notIn(notITABLE[1]),
        .out0(_00001x01),
        .out1(_00001x11)
    );

    wire _not_00001x01 = _00001x01 ~| _00001x01;

    wire _00001001;
    wire _00001101;

    DECODER_1bit_decoder d_00001d01(
        .notEnable(_not_00001x01),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_00001001),
        .out1(_00001101)
    );

    wire _PI_SelectAd_OPOPold_00;
    wire _PR_Reset_XPT_00; // <
    wire _P2_Set_CM1_00;
    wire _P2_Reset_ITABLE_00;
    wire _Pa_Ophd_00; // >

    DECODER_I_00001001 d00001001(
        .enable(_00001001),
        .XPT(XPT),
        .notXPT(notXPT),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_00), // <
        .PI_SelectDt_A(PI_SelectDt_A), // >
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .PR_Reset_XPT(_PR_Reset_XPT_00), // <
        .P2_Set_CM1(_P2_Set_CM1_00),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_00),
        .Pa_Ophd(_Pa_Ophd_00) // >
    );

    wire _PI_SelectAd_OPOPold_10;
    wire _PR_Reset_XPT_10; // <
    wire _P2_Set_CM1_10;
    wire _P2_Reset_ITABLE_10;
    wire _PR_InvertIn_10;
    wire _Pa_Ophd_10; // >

    DECODER_I_00001101 d00001101(
        .enable(_00001101),
        .XPT(XPT),
        .notXPT(notXPT),
        .PI_SelectAd_OPOPold(_PI_SelectAd_OPOPold_10),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PR_Write_L(PR_Write_L),
        .PI_SelectAdt1(PI_SelectAdt1),
        .PR_Reset_XPT(_PR_Reset_XPT_10), // <
        .P2_Set_CM1(_P2_Set_CM1_10),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_10),
        .PR_Write_H(PR_Write_H),
        .PR_InvertIn(_PR_InvertIn_10),
        .Pa_Ophd(_Pa_Ophd_10) // >
    );

    wire _PR_Reset_XPT_x1; // <
    wire _P2_Set_CM1_x1;
    wire _P2_Reset_ITABLE_x1;
    wire _PR_InvertIn_x1;
    wire _Pa_Ophd_x1; // >

    DECODER_I_00001x11 d00001x11(
        .enable(_00001x11),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PR_Write_IX_high(PR_Write_IX_high),
        .PR_Write_IY_high(PR_Write_IY_high),
        .PR_Reset_XPT(_PR_Reset_XPT_x1), // <
        .P2_Set_CM1(_P2_Set_CM1_x1),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_x1),
        .PR_InvertIn(_PR_InvertIn_x1),
        .Pa_Ophd(_Pa_Ophd_x1) // >
    );

    assign PR_InvertIn = (_PR_InvertIn_10 | _PR_InvertIn_x1); // 2

    assign PR_Reset_XPT = (PR_InvertIn | _PR_Reset_XPT_00); // 2
    assign P2_Set_CM1 = PR_Reset_XPT;
    assign P2_Reset_ITABLE = PR_Reset_XPT;
    assign Pa_Ophd = PR_Reset_XPT;

    assign PI_SelectAd_OPOPold = (_PI_SelectAd_OPOPold_00 | _PI_SelectAd_OPOPold_10); // 2

endmodule