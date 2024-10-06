// 8
module DECODER_basic_I(
        input wire PC_I0,
        input wire PC_I1,
        input wire PC_I2,
        input wire PC_I3,
        input wire TWAIT,
        output wire PI_Flag_IORQ, // < 1or2
        output wire PI_Flag_RD, // >
        output wire PI_Activate_Ad_high, // < 0~3
        output wire PI_Activate_Ad_low, // >
        output wire PhI_Flag_IORQ, // < 2
        output wire PhI_Flag_RD, // >
        output wire PR_Halt_XPT,
        output wire PI_Read_Dtcs, // < 3
        output wire PA_Select_Dtcs_low,
        output wire PA_NOP // >
    );

    // 1or2

    wire _not1or2 = PC_I1 ~| PC_I2;
    wire _1or2 = _not1or2 ~| _not1or2;
    assign PI_Flag_IORQ = _1or2;
    assign PI_Flag_RD = _1or2;

    // 0~3

    wire _not0_2 = PC_I0 ~| _1or2;
    wire _0_2 = _not0_2 ~| _not0_2;
    wire _not0_3 = _0_2 ~| PC_I3;
    wire _0_3 = _not0_3 ~| _not0_3;

    assign PI_Activate_Ad_high = _0_3;
    assign PI_Activate_Ad_low = _0_3;

    // 2

    assign PhI_Flag_IORQ = PC_I2;
    assign PhI_Flag_RD = PC_I2;

    wire _not2 = PC_I2 ~| PC_I2;
    wire _2notTWAIT = _not2 ~| TWAIT;

    assign PR_Halt_XPT = _2notTWAIT;

    // 3

    assign PI_Read_Dtcs = PC_I3;
    assign PA_Select_Dtcs_low = PC_I3;
    assign PA_NOP = PC_I3;

endmodule