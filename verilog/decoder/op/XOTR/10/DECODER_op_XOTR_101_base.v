// 25
module DECODER_op_XOTR_101_base(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        input wire Flag_PV,
        input wire notFlag_Z,
        output wire [16:0] _decodedXPT,
        output wire PA_Select_PC_high, // <
        output wire PA_Select_0x1_low,
        output wire PA_SUB,
        output wire PR_Write_PC_high,
        output wire PR_Write_PC_low, // >
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd // >
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // XPT
    //

    wire _not_enable = enable ~| enable;

    assign _decodedXPT[16] = _not_enable ~| notXPT[4];

    wire _or = (_not_enable | notXPT[3]); // 2

    assign _decodedXPT[11] = ~(_or | XPT[2] | notXPT[1] | notXPT[0]); // 5

    wire _t12or13 = ~(_or | notXPT[3] | notXPT[2] | XPT[1]); // 5

    //
    // decoder
    //

    wire _nott11 = _decodedXPT[11] ~| _decodedXPT[11];
    wire _d1010_t11 = _nott11 ~| Source[4];

    // 00 LDIR/LDDR -> Flag_PV == 0
    // 01 CPIR/CPDR -> Flag_PV == 0 or FLAG_Z == 1
    // 1x INIR/INDR/OTIR/OTDR -> Flag_Z == 1
    // でリセットする

    wire _killPV = Source[1];
    wire _killZ = Source[1] ~| Source[0];

    wire _processedPV = Flag_PV ~| _killPV;
    wire _processedZ = notFlag_Z ~| _killZ;
    wire _not_or = _processedPV ~| _processedZ;
    wire _d1011_t11 = _not_or ~| _nott11;

    // 11 or 16

    wire _cancel = (_d1010_t11 | _d1011_t11 | _decodedXPT[16]); // 4

    assign PR_Reset_XPT = _cancel;
    assign P2_Set_CM1 = _cancel;
    assign P2_Reset_XOTR = _cancel;
    assign Pa_Ophd = _cancel;

    // 12

    assign PA_Select_PC_high = _t12or13;
    assign PA_Select_0x1_low = _t12or13;
    assign PA_SUB = _t12or13;
    assign PR_Write_PC_high = _t12or13;
    assign PR_Write_PC_low = _t12or13;

endmodule