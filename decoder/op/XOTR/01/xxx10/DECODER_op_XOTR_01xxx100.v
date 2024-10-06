// NEG
// 2
module DECODER_op_XOTR_01xxx100(
        input wire enable,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        output wire PR_Reset_XPT, // <
        output wire P2_Set_CM1,
        output wire P2_Reset_XOTR,
        output wire Pa_Ophd,
        output wire PA_Select_A_low,
        output wire PA_SUB,
        output wire PR_Write_A,
        output wire PR_InvertIn,
        output wire PF_Write_C,
        output wire PF_Write_Z,
        output wire PF_Write_PV,
        output wire PF_Write_S,
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_C_bit26,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit25,
        output wire PF_Select_S_bit7,
        output wire PF_Select_N_bit17,
        output wire PF_Select_H_bit22 // >
    );

    // wire [4:0] notXPT = ~XPT;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _decodedXPT3 = _not_enable ~| notXPT[0];

    assign PR_Reset_XPT = _decodedXPT3;
    assign P2_Set_CM1 = _decodedXPT3;
    assign P2_Reset_XOTR = _decodedXPT3;
    assign Pa_Ophd = _decodedXPT3;
    assign PA_Select_A_low = _decodedXPT3;
    assign PA_SUB = _decodedXPT3;
    assign PR_Write_A = _decodedXPT3;
    assign PR_InvertIn = _decodedXPT3;
    assign PF_Write_C = _decodedXPT3;
    assign PF_Write_Z = _decodedXPT3;
    assign PF_Write_PV = _decodedXPT3;
    assign PF_Write_S = _decodedXPT3;
    assign PF_Write_N = _decodedXPT3;
    assign PF_Write_H = _decodedXPT3;
    assign PF_Select_C_bit26 = _decodedXPT3;
    assign PF_Select_Z_bit24 = _decodedXPT3;
    assign PF_Select_PV_bit25 = _decodedXPT3;
    assign PF_Select_S_bit7 = _decodedXPT3;
    assign PF_Select_N_bit17 = _decodedXPT3;
    assign PF_Select_H_bit22 = _decodedXPT3;

endmodule