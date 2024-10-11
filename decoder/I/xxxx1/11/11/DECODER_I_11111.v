// 23(85)
module DECODER_I_11111(
        input wire enable,
        input wire [3:0] XPT,
        input wire [3:0] notXPT,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire PA_Select_IX_high,
        output wire PA_Select_IY_high,
        output wire PA_Select_OP_low,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit21,
        output wire PF_Select_N_bit17,
        output wire PF_Select_H_bit22,
        output wire PA_SUB,
        output wire PA_ADD,
        output wire PR_Write_Dtex,
        output wire PR_Write_Dt,
        output wire PI_SelectAd_DtexDt,
        output wire PC_R0,
        output wire PC_R1,
        output wire PC_R2,
        output wire PA_Select_Dt_high,
        output wire PA_Select_0x1_low,
        output wire PF_Write_S,
        output wire PF_Select_S_bit7,
        output wire PF_Write_Z,
        output wire PF_Select_Z_bit24,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Select_PV_bit25,
        output wire PF_Write_N,
        output wire PI_SelectAd_ALU,
        output wire PI_SelectDt_Dt,
        output wire PC_W0,
        output wire PC_W1,
        output wire PC_W2,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire P2_Reset_ITABLE,
        output wire Pa_Ophd, // >
        output wire P2_Set_ILDlIXtdln_1,
        output wire P2_Set_ILDlIYtdln_1,
        output wire P2_Set_CMR,
        output wire PA_Select_OPold_low,
        output wire PI_SelectDt_OP
    );

    // wire [3:0] notXPT = ~XPT;
    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _11111x0x;
    wire _11111x1x;

    DECODER_1bit_decoder d_11111xdx(
        .notEnable(_not_enable),
        .In(ITABLE[1]),
        .notIn(notITABLE[1]),
        .out0(_11111x0x),
        .out1(_11111x1x)
    );

    wire _PA_Select_IX_high_0;
    wire _PA_Select_IY_high_0;
    wire _PA_ADD_0;
    wire _PR_Write_Dtex_0;
    wire _PR_Write_Dt_0;
    wire _PI_SelectAd_DtexDt_0;
    wire _PC_W0_0;
    wire _PC_W1_0;
    wire _PC_W2_0;
    wire _PR_Reset_XPT_0; // <
    wire _P2_Set_CM1_0;
    wire _P2_Reset_ITABLE_0;
    wire _Pa_Ophd_0; // >

    DECODER_I_11111x0x d11111x0x(
        .enable(_11111x0x),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .PA_Select_IX_high(_PA_Select_IX_high_0),
        .PA_Select_IY_high(_PA_Select_IY_high_0),
        .PA_Select_OP_low(PA_Select_OP_low),
        .PF_Select_N_bit16(PF_Select_N_bit16), // <
        .PF_Select_H_bit21(PF_Select_H_bit21), // >
        .PF_Select_N_bit17(PF_Select_N_bit17), // <
        .PF_Select_H_bit22(PF_Select_H_bit22),
        .PA_SUB(PA_SUB), // >
        .PA_ADD(_PA_ADD_0),
        .PR_Write_Dtex(_PR_Write_Dtex_0),
        .PR_Write_Dt(_PR_Write_Dt_0),
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_0),
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PA_Select_Dt_high(PA_Select_Dt_high), // <
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PF_Write_S(PF_Write_S),
        .PF_Select_S_bit7(PF_Select_S_bit7),
        .PF_Write_Z(PF_Write_Z),
        .PF_Select_Z_bit24(PF_Select_Z_bit24),
        .PF_Write_H(PF_Write_H),
        .PF_Write_PV(PF_Write_PV),
        .PF_Select_PV_bit25(PF_Select_PV_bit25),
        .PF_Write_N(PF_Write_N), // >
        .PI_SelectAd_ALU(PI_SelectAd_ALU), // <
        .PI_SelectDt_Dt(PI_SelectDt_Dt), // >
        .PC_W0(_PC_W0_0),
        .PC_W1(_PC_W1_0),
        .PC_W2(_PC_W2_0),
        .PR_Reset_XPT(_PR_Reset_XPT_0), // <
        .P2_Set_CM1(_P2_Set_CM1_0),
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_0),
        .Pa_Ophd(_Pa_Ophd_0) // >
    );

    wire _PA_Select_IX_high_1;
    wire _PA_Select_IY_high_1;
    wire _PA_ADD_1;
    wire _PR_Write_Dtex_1;
    wire _PR_Write_Dt_1;
    wire _PI_SelectAd_DtexDt_1;
    wire _PC_W0_1;
    wire _PC_W1_1;
    wire _PC_W2_1;
    wire _PR_Reset_XPT_1;
    wire _P2_Set_CM1_1; // <
    wire _P2_Reset_ITABLE_1;
    wire _Pa_Ophd_1; // >

    DECODER_I_11111x1x d11111x1x(
        .enable(_11111x1x),
        .XPT(XPT),
        .notXPT(notXPT),
        .ITABLE(ITABLE),
        .notITABLE(notITABLE),
        .P2_Set_ILDlIXtdln_1(P2_Set_ILDlIXtdln_1),
        .P2_Set_ILDlIYtdln_1(P2_Set_ILDlIYtdln_1),
        .P2_Set_CMR(P2_Set_CMR),
        .PR_Reset_XPT(_PR_Reset_XPT_1),
        .PA_Select_IX_high(_PA_Select_IX_high_1),
        .PA_Select_IY_high(_PA_Select_IY_high_1),
        .PA_Select_OPold_low(PA_Select_OPold_low), // <
        .PA_ADD(_PA_ADD_1),
        .PR_Write_Dt(_PR_Write_Dt_1),
        .PR_Write_Dtex(_PR_Write_Dtex_1), // >
        .PI_SelectAd_DtexDt(_PI_SelectAd_DtexDt_1), // <
        .PI_SelectDt_OP(PI_SelectDt_OP), // >
        .PC_W0(_PC_W0_1),
        .PC_W1(_PC_W1_1),
        .PC_W2(_PC_W2_1),
        .P2_Set_CM1(_P2_Set_CM1_1), // <
        .P2_Reset_ITABLE(_P2_Reset_ITABLE_1),
        .Pa_Ophd(_Pa_Ophd_1) // >
    );

    assign P2_Set_CM1 = (_P2_Set_CM1_0 | _P2_Set_CM1_1); // 2
    assign P2_Reset_ITABLE = P2_Set_CM1;
    assign Pa_Ophd = P2_Set_CM1;

    assign PA_Select_IX_high = (_PA_Select_IX_high_0 | _PA_Select_IX_high_1); // 2
    assign PA_Select_IY_high = (_PA_Select_IY_high_0 | _PA_Select_IY_high_1); // 2
    assign PA_ADD = (_PA_ADD_0 | _PA_ADD_1); // 2
    assign PR_Write_Dt = (_PR_Write_Dt_0 | _PR_Write_Dt_1); // 2
    assign PR_Write_Dtex = (_PR_Write_Dtex_0 | _PR_Write_Dtex_1); // 2
    assign PI_SelectAd_DtexDt = (_PI_SelectAd_DtexDt_0 | _PI_SelectAd_DtexDt_1); // 2
    assign PR_Reset_XPT = (_PR_Reset_XPT_0 | _PR_Reset_XPT_1); // 2
    assign PC_W0 = (_PC_W0_0 | _PC_W0_1); // 2
    assign PC_W1 = (_PC_W1_0 | _PC_W1_1); // 2
    assign PC_W2 = (_PC_W2_0 | _PC_W2_1); // 2

endmodule