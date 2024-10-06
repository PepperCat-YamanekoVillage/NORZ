// 64(138)
module DECODER_basic(
        input wire TWAIT,
        input wire [1:0] XPT,
        input wire [1:0] notXPT,
        input wire PC_M1,
        input wire PC_MR,
        input wire PC_MR0,
        input wire PC_MR1,
        input wire PC_MR2,
        input wire PC_MA,
        input wire PC_W0,
        input wire PC_W1,
        input wire PC_W2,
        input wire PC_R0,
        input wire PC_R1,
        input wire PC_R2,
        input wire PC_RA0,
        input wire PC_RA1,
        input wire PC_RA2,
        input wire PC_I0,
        input wire PC_I1,
        input wire PC_I2,
        input wire PC_I3,
        input wire PC_O0,
        input wire PC_O1,
        input wire PC_O2,
        input wire PC_O3,
        output wire PI_Activate_Ad_high,
        output wire PI_Activate_Ad_low,
        output wire PI_SelectAd_PC,
        output wire PI_Flag_M1,
        output wire PhI_Flag_MREQ,
        output wire PhI_Flag_RD,
        output wire PI_Flag_MREQ,
        output wire PI_Flag_RD,
        output wire PA_Select_Din_low,
        output wire PA_NOP,
        output wire PR_Write_OP,
        output wire PR_Halt_XPT,
        output wire PI_SelectAd_IR,
        output wire PI_Flag_RFSH,
        output wire P2_Reset_CM1,
        output wire PR_Inc_R,
        output wire PR_SlideOP,
        output wire P2_Reset_CMR,
        output wire PR_Inc_PC,
        output wire PI_Read_Dtcs,
        output wire PA_Select_Dtcs_low,
        output wire P2_Reset_CMA,
        output wire PI_Flag_IORQ,
        output wire PhI_Flag_IORQ,
        output wire PI_Flag_WR,
        output wire PI_Activate_Dt,
        output wire PhI_Activate_Dt,
        output wire PhI_Flag_WR
    );

    wire _PI_Activate_Ad_high_m1; // <
    wire _PI_Activate_Ad_low_m1; // >
    wire _PI_SelectAd_PC_m1;
    wire _PhI_Flag_MREQ_m1;
    wire _PhI_Flag_RD_m1;
    wire _PI_Flag_RD_m1; // <
    wire _PA_NOP_m1; // >
    wire _PR_Write_OP_m1; // <
    wire _PR_SlideOP_m1; // >
    wire _PR_Halt_XPT_m1;

    DECODER_basic_M1 m1(
        .TWAIT(TWAIT),
        .XPT(XPT),
        .notXPT(notXPT),
        .PC_M1(PC_M1),
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_m1), // < 0~3
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_m1), // >
        .PI_SelectAd_PC(_PI_SelectAd_PC_m1), // < 0or1
        .PI_Flag_M1(PI_Flag_M1), // >
        .PhI_Flag_MREQ(_PhI_Flag_MREQ_m1),
        .PhI_Flag_RD(_PhI_Flag_RD_m1),
        .PI_Flag_MREQ(PI_Flag_MREQ), // < 1
        .PI_Flag_RD(_PI_Flag_RD_m1),
        .PA_Select_Din_low(PA_Select_Din_low),
        .PA_NOP(_PA_NOP_m1), // >
        .PR_Write_OP(_PR_Write_OP_m1), // < 1W
        .PR_SlideOP(_PR_SlideOP_m1), // >
        .PR_Halt_XPT(_PR_Halt_XPT_m1),
        .PI_SelectAd_IR(PI_SelectAd_IR), // < 2or3
        .PI_Flag_RFSH(PI_Flag_RFSH), // >
        .P2_Reset_CM1(P2_Reset_CM1), // < 3
        .PR_Inc_R(PR_Inc_R) // >
    );

    wire _PC_MA0;
    wire _PC_MA1;
    wire _PC_MA2;

    wire _PR_SlideOP_mr; // <
    wire _PA_NOP_mr;
    wire _PR_Write_OP_mr; // >
    wire _PR_Inc_PC_mr;

    DECODER_basic_MR mr(
        .XPT(XPT),
        .notXPT(notXPT),
        .PC_MR(PC_MR),
        .PC_MR0(PC_MR0),
        .PC_MR1(PC_MR1),
        .PC_MR2(PC_MR2),
        .PC_MA0(_PC_MA0),
        .PC_MA1(_PC_MA1),
        .PC_MA2(_PC_MA2),
        .PR_SlideOP(_PR_SlideOP_mr), // < 3
        .PA_NOP(_PA_NOP_mr),
        .PR_Write_OP(_PR_Write_OP_mr),
        .P2_Reset_CMR(P2_Reset_CMR), // >
        .PR_Inc_PC(_PR_Inc_PC_mr)
    );

    wire _PhI_Flag_MREQ_ma; // <
    wire _PhI_Flag_RD_ma; // >
    wire _PI_Activate_Ad_high_ma; // <
    wire _PI_Activate_Ad_low_ma;
    wire _PI_SelectAd_PC_ma; // >
    wire _PR_Halt_XPT_ma;
    wire _PI_Read_Dtcs_ma; // <
    wire _PA_Select_Dtcs_low_ma; // >
    wire _PR_Inc_PC_ma;

    DECODER_basic_MA ma(
        .XPT(XPT),
        .notXPT(notXPT),
        .TWAIT(TWAIT),
        .PC_MA(PC_MA),
        .PC_MA0(_PC_MA0),
        .PC_MA1(_PC_MA1),
        .PC_MA2(_PC_MA2),
        .PhI_Flag_MREQ(_PhI_Flag_MREQ_ma), // < 0or1
        .PhI_Flag_RD(_PhI_Flag_RD_ma), // >
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_ma), // < 0~2
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_ma),
        .PI_SelectAd_PC(_PI_SelectAd_PC_ma), // >
        .PR_Halt_XPT(_PR_Halt_XPT_ma),
        .PI_Read_Dtcs(_PI_Read_Dtcs_ma), // < 2
        .PA_Select_Dtcs_low(_PA_Select_Dtcs_low_ma), // >
        .PR_Inc_PC(_PR_Inc_PC_ma), // < 2 PC_MA 
        .P2_Reset_CMA(P2_Reset_CMA) // >
    );

    wire _PC_RA0_r;
    wire _PC_RA1_r;
    wire _PC_RA2_r;

    wire _PA_NOP_r;

    DECODER_basic_R r(
        .PC_R0(PC_R0),
        .PC_R1(PC_R1),
        .PC_R2(PC_R2),
        .PC_RA0(_PC_RA0_r),
        .PC_RA1(_PC_RA1_r),
        .PC_RA2(_PC_RA2_r),
        .PA_NOP(_PA_NOP_r)
    );

    wire _PC_RA0 = (PC_RA0 | _PC_RA0_r); // 2
    wire _PC_RA1 = (PC_RA1 | _PC_RA1_r); // 2
    wire _PC_RA2 = (PC_RA2 | _PC_RA2_r); // 2

    wire _PhI_Flag_MREQ_ra; // <
    wire _PhI_Flag_RD_ra; // >
    wire _PI_Activate_Ad_high_ra; // <
    wire _PI_Activate_Ad_low_ra; // >
    wire _PR_Halt_XPT_ra;
    wire _PI_Read_Dtcs_ra; // <
    wire _PA_Select_Dtcs_low_ra; // >

    DECODER_basic_RA ra(
        .PC_RA0(_PC_RA0),
        .PC_RA1(_PC_RA1),
        .PC_RA2(_PC_RA2),
        .TWAIT(TWAIT),
        .PhI_Flag_MREQ(_PhI_Flag_MREQ_ra), // < 0or1
        .PhI_Flag_RD(_PhI_Flag_RD_ra), // >
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_ra), // < 0~2
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_ra), // >
        .PR_Halt_XPT(_PR_Halt_XPT_ra),
        .PI_Read_Dtcs(_PI_Read_Dtcs_ra), // < 2
        .PA_Select_Dtcs_low(_PA_Select_Dtcs_low_ra) // >
    );

    wire _PhI_Flag_MREQ_w;
    wire _PI_Activate_Ad_high_w; // <
    wire _PI_Activate_Ad_low_w; // >
    wire _PhI_Activate_Dt_w;
    wire _PhI_Flag_WR_w;
    wire _PR_Halt_XPT_w;
    wire _PI_Activate_Dt_w;

    DECODER_basic_W w(
        .PC_W0(PC_W0),
        .PC_W1(PC_W1),
        .PC_W2(PC_W2),
        .TWAIT(TWAIT),
        .PhI_Flag_MREQ(_PhI_Flag_MREQ_w),
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_w), // < 0~2
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_w), // >
        .PhI_Activate_Dt(_PhI_Activate_Dt_w),
        .PhI_Flag_WR(_PhI_Flag_WR_w),
        .PR_Halt_XPT(_PR_Halt_XPT_w),
        .PI_Activate_Dt(_PI_Activate_Dt_w)
    );

    wire _PI_Flag_IORQ_i; // <
    wire _PI_Flag_RD_i; // >
    wire _PI_Activate_Ad_high_i; // <
    wire _PI_Activate_Ad_low_i; // >
    wire _PhI_Flag_IORQ_i; // <
    wire _PhI_Flag_RD_i; // >
    wire _PR_Halt_XPT_i;
    wire _PI_Read_Dtcs_i; // <
    wire _PA_Select_Dtcs_low_i;
    wire _PA_NOP_i; // >

    DECODER_basic_I i(
        .PC_I0(PC_I0),
        .PC_I1(PC_I1),
        .PC_I2(PC_I2),
        .PC_I3(PC_I3),
        .TWAIT(TWAIT),
        .PI_Flag_IORQ(_PI_Flag_IORQ_i), // < 1or2
        .PI_Flag_RD(_PI_Flag_RD_i), // >
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_i), // < 0~3
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_i), // >
        .PhI_Flag_IORQ(_PhI_Flag_IORQ_i), // < 2
        .PhI_Flag_RD(_PhI_Flag_RD_i), // >
        .PR_Halt_XPT(_PR_Halt_XPT_i),
        .PI_Read_Dtcs(_PI_Read_Dtcs_i), // < 3
        .PA_Select_Dtcs_low(_PA_Select_Dtcs_low_i),
        .PA_NOP(_PA_NOP_i) // >
    );

    wire _PI_Activate_Dt_o;
    wire _PI_Flag_IORQ_o;
    wire _PI_Activate_Ad_high_o; // <
    wire _PI_Activate_Ad_low_o; // >
    wire _PhI_Activate_Dt_o;
    wire _PhI_Flag_IORQ_o; // <
    wire _PhI_Flag_WR_o; // >
    wire _PR_Halt_XPT_o;

    DECODER_basic_O o(
        .PC_O0(PC_O0),
        .PC_O1(PC_O1),
        .PC_O2(PC_O2),
        .PC_O3(PC_O3),
        .TWAIT(TWAIT),
        .PI_Flag_IORQ(_PI_Flag_IORQ_o), // < 1or2
        .PI_Flag_WR(PI_Flag_WR), // >
        .PI_Activate_Dt(_PI_Activate_Dt_o),
        .PI_Activate_Ad_high(_PI_Activate_Ad_high_o), // < 0~3
        .PI_Activate_Ad_low(_PI_Activate_Ad_low_o), // >
        .PhI_Activate_Dt(_PhI_Activate_Dt_o),
        .PhI_Flag_IORQ(_PhI_Flag_IORQ_o), // < 2
        .PhI_Flag_WR(_PhI_Flag_WR_o), // >
        .PR_Halt_XPT(_PR_Halt_XPT_o)
    );

    assign PI_Activate_Ad_high = (_PI_Activate_Ad_high_m1|_PI_Activate_Ad_high_ma|_PI_Activate_Ad_high_ra|_PI_Activate_Ad_high_w|_PI_Activate_Ad_high_i|_PI_Activate_Ad_high_o); // 10
    assign PI_Activate_Ad_low = PI_Activate_Ad_high;

    assign PR_Write_OP = (_PR_Write_OP_m1|_PR_Write_OP_mr); // 2
    assign PR_SlideOP = PR_Write_OP;

    assign PI_Read_Dtcs = (_PI_Read_Dtcs_ma|_PI_Read_Dtcs_ra|_PI_Read_Dtcs_i); // 4
    assign PA_Select_Dtcs_low = PI_Read_Dtcs;

    wire _phi_ma_ra = (_PhI_Flag_MREQ_ma|_PhI_Flag_MREQ_ra); // 2
    assign PhI_Flag_MREQ = (_PhI_Flag_MREQ_m1|_PhI_Flag_MREQ_w|_phi_ma_ra); // 4
    assign PhI_Flag_RD = (_PhI_Flag_RD_m1|_PhI_Flag_RD_i|_phi_ma_ra); // 4

    assign PA_NOP = (_PA_NOP_m1|_PA_NOP_mr|_PA_NOP_r|_PA_NOP_i); // 6
    assign PI_Flag_RD = (_PI_Flag_RD_m1|_PI_Flag_RD_i); // 2
    assign PI_SelectAd_PC = (_PI_SelectAd_PC_m1|_PI_SelectAd_PC_ma); // 2
    assign PR_Halt_XPT = (_PR_Halt_XPT_m1|_PR_Halt_XPT_ma|_PR_Halt_XPT_ra|_PR_Halt_XPT_w|_PR_Halt_XPT_i|_PR_Halt_XPT_o); // 10
    assign PR_Inc_PC = (_PR_Inc_PC_mr|_PR_Inc_PC_ma); // 2
    assign PI_Flag_IORQ = (_PI_Flag_IORQ_i|_PI_Flag_IORQ_o); // 2
    assign PhI_Flag_IORQ = (_PhI_Flag_IORQ_i|_PhI_Flag_IORQ_o); // 2
    assign PhI_Activate_Dt = (_PhI_Activate_Dt_w|_PhI_Activate_Dt_o); // 2
    assign PI_Activate_Dt = (_PI_Activate_Dt_w|_PI_Activate_Dt_o); // 2
    assign PhI_Flag_WR = (_PhI_Flag_WR_w|_PhI_Flag_WR_o); // 2

endmodule