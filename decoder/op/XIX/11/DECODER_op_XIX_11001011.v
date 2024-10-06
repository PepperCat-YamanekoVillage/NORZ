// XIX4/XIY4
// 6
module DECODER_op_XIX_11001011(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CMR, // >
        output wire P2_Reset_XIX,
        output wire P2_Reset_XIY,
        output wire P2_Set_XIX4_0,
        output wire P2_Set_XIY4_0
    );

    // wire [4:0] notXPT = ~XPT;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CMR = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _not_is_Y = is_Y ~| is_Y;

    assign P2_Reset_XIX = _nott3 ~| is_Y;
    assign P2_Set_XIX4_0 = P2_Reset_XIX;

    assign P2_Reset_XIY = _nott3 ~| _not_is_Y;
    assign P2_Set_XIY4_0 = P2_Reset_XIY;

endmodule