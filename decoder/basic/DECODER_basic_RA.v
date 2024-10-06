// 6
module DECODER_basic_RA(
        input wire PC_RA0,
        input wire PC_RA1,
        input wire PC_RA2,
        input wire TWAIT,
        output wire PhI_Flag_MREQ, // < 0or1
        output wire PhI_Flag_RD, // >
        output wire PI_Activate_Ad_high, // < 0~2
        output wire PI_Activate_Ad_low, // >
        output wire PR_Halt_XPT,
        output wire PI_Read_Dtcs, // < 2
        output wire PA_Select_Dtcs_low // >
    );

    // 0or1

    wire _not0or1 = PC_RA0 ~| PC_RA1;
    wire _0or1 = _not0or1 ~| _not0or1;
    assign PhI_Flag_MREQ = _0or1;
    assign PhI_Flag_RD = _0or1;

    // 0~2

    wire _not0_2 = _0or1 ~| PC_RA2;
    wire _0_2 = _not0_2 ~| _not0_2;

    assign PI_Activate_Ad_high = _0_2;
    assign PI_Activate_Ad_low = _0_2;

    // 1

    wire _not1 = PC_RA1 ~| PC_RA1;
    wire _1notTWAIT = _not1 ~| TWAIT;

    assign PR_Halt_XPT = _1notTWAIT;

    // 2

    assign PI_Read_Dtcs = PC_RA2;
    assign PA_Select_Dtcs_low = PC_RA2;

endmodule