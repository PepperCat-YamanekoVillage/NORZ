// JP (IX/IY)
// 6
module DECODER_op_XIX_11101001(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire [3:0] _decodedXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire Pa_Ophd,
        output wire PA_NOP,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low, // >
        output wire P2_Reset_XIX, // <
        output wire PA_Select_IX_low, // >
        output wire P2_Reset_XIY, // <
        output wire PA_Select_IY_low // >
    );

    // wire [4:0] notXPT = ~XPT;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[3] = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT[3];
    assign P2_Set_CM1 = _decodedXPT[3];
    assign Pa_Ophd = _decodedXPT[3];
    assign PA_NOP = _decodedXPT[3];
    assign PR_Write_PC_high = _decodedXPT[3];
    assign PR_Write_PC_low = _decodedXPT[3];

    //
    // decoder
    //

    wire _nott3 = _decodedXPT[3] ~| _decodedXPT[3];

    wire _not_is_Y = is_Y ~| is_Y;

    assign P2_Reset_XIX = _nott3 ~| is_Y;
    assign PA_Select_IX_low = P2_Reset_XIX;

    assign P2_Reset_XIY = _nott3 ~| _not_is_Y;
    assign PA_Select_IY_low = P2_Reset_XIY;

endmodule