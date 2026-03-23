// 8
module DECODER_basic_W(
        input wire PC_W0,
        input wire PC_W1,
        input wire PC_W2,
        input wire TWAIT,
        output wire PhI_Flag_MREQ,
        output wire PI_Activate_Ad_high, // < 0~2
        output wire PI_Activate_Ad_low, // >
        output wire PhI_Activate_Dt,
        output wire PhI_Flag_WR,
        output wire PR_Halt_XPT,
        output wire PI_Activate_Dt
    );

    // 0or1

    wire _not0or1 = PC_W0 ~| PC_W1;
    wire _0or1 = _not0or1 ~| _not0or1;
    assign PhI_Flag_MREQ = _0or1;

    // 0~2

    wire _not0_2 = _0or1 ~| PC_W2;
    wire _0_2 = _not0_2 ~| _not0_2;

    assign PI_Activate_Ad_high = _0_2;
    assign PI_Activate_Ad_low = _0_2;

    // 0

    assign PhI_Activate_Dt = PC_W0;

    // 1

    assign PhI_Flag_WR = PC_W1;

    wire _not1 = PC_W1 ~| PC_W1;
    wire _1notTWAIT = _not1 ~| TWAIT;

    assign PR_Halt_XPT = _1notTWAIT;

    // 1or2

    wire _not1or2 = PC_W1 ~| PC_W2;
    wire _1or2 = _not1or2 ~| _not1or2;
    assign PI_Activate_Dt = _1or2;

endmodule