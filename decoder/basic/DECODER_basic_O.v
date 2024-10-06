// 8
module DECODER_basic_O(
        input wire PC_O0,
        input wire PC_O1,
        input wire PC_O2,
        input wire PC_O3,
        input wire TWAIT,
        output wire PI_Flag_IORQ, // < 1or2
        output wire PI_Flag_WR, // >
        output wire PI_Activate_Dt,
        output wire PI_Activate_Ad_high, // < 0~3
        output wire PI_Activate_Ad_low, // >
        output wire PhI_Activate_Dt,
        output wire PhI_Flag_IORQ, // < 2
        output wire PhI_Flag_WR, // >
        output wire PR_Halt_XPT
    );

    // 1or2

    wire _not1or2 = PC_O1 ~| PC_O2;
    wire _1or2 = _not1or2 ~| _not1or2;
    assign PI_Flag_IORQ = _1or2;
    assign PI_Flag_WR = _1or2;

    // 1~3

    wire _not1_3 = PC_O3 ~| _1or2;
    wire _1_3 = _not1_3 ~| _not1_3;

    assign PI_Activate_Dt = _1_3;

    // 0~3

    wire _not0_3 = PC_O0 ~| _1_3;
    wire _0_3 = _not0_3 ~| _not0_3;

    assign PI_Activate_Ad_high = _0_3;
    assign PI_Activate_Ad_low = _0_3;

    // 0

    assign PhI_Activate_Dt = PC_O0;

    // 2

    assign PhI_Flag_IORQ = PC_O2;
    assign PhI_Flag_WR = PC_O2;

    wire _not2 = PC_O2 ~| PC_O2;
    wire _2notTWAIT = _not2 ~| TWAIT;

    assign PR_Halt_XPT = _2notTWAIT;

endmodule