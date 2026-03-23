// 4
module DECODER_op_XIX4_0(
        input wire not_enable,
        input wire is_Y,
        output wire PR_Reset_XPT,
        output wire P2_Set_CMR,
        output wire P2_Set_XIX4_1,
        output wire P2_Set_XIY4_1
    );

    wire _enable = not_enable ~| not_enable;

    assign PR_Reset_XPT = _enable;
    assign P2_Set_CMR = _enable;

    wire _not_is_Y = is_Y ~| is_Y;

    assign P2_Set_XIX4_1 = not_enable ~| is_Y;
    assign P2_Set_XIY4_1 = not_enable ~| _not_is_Y;

endmodule