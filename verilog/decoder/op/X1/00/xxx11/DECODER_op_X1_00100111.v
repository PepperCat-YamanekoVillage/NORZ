// DAA
// 10(20)
module DECODER_op_X1_00100111(
        input wire t2,
        input wire t3,
        input wire Flag_H,
        input wire Flag_Z,
        input wire Flag_C,
        input wire Flag_S,
        input wire Flag_N,
        output wire PA_Select_A_high,
        output wire PA_Select_0xaa_low, // <
        output wire PF_Select_S_bit39,
        output wire PF_Select_Z_bit21, // >
        output wire PF_Write_S,
        output wire PF_Write_Z,
        output wire PR_Write_A, // <
        output wire PR_InvertIn,
        output wire PF_Write_C,
        output wire PF_Write_PV,
        output wire PF_Write_H,
        output wire PF_Select_C_bit29,
        output wire PF_Select_Z_bit24,
        output wire PF_Select_PV_bit27,
        output wire PF_Select_S_bit7,
        output wire PF_Select_H_bit28, // >
        output wire PA_ADD,
        output wire PA_SUB,
        output wire PA_Select_0x60_low,
        output wire PA_Select_0x06_low,
        output wire PA_Select_0x66_low
    );

    // 2
    
    assign PA_Select_0xaa_low = t2;
    assign PF_Select_S_bit39 = t2;
    assign PF_Select_Z_bit21 = t2;

    // 2or3

    assign PA_Select_A_high = (t2 | t3); // 2
    assign PF_Write_S = PA_Select_A_high;
    assign PF_Write_Z = PA_Select_A_high;

    // 3

    assign PR_Write_A = t3;
    assign PR_InvertIn = t3;
    assign PF_Write_C = t3;
    assign PF_Write_PV = t3;
    assign PF_Write_H = t3;
    assign PF_Select_C_bit29 = t3;
    assign PF_Select_Z_bit24 = t3;
    assign PF_Select_PV_bit27 = t3;
    assign PF_Select_S_bit7 = t3;
    assign PF_Select_H_bit28 = t3;

    wire _nott3 = t3 ~| t3;

    wire _notFlag_N = Flag_N ~| Flag_N;

    wire _PA_SUB;

    DECODER_1bit_decoder pa_alu(
        .notEnable(_nott3),
        .In(Flag_N),
        .notIn(_notFlag_N),
        .out0(PA_ADD),
        .out1(_PA_SUB)
    );

    assign PA_SUB = (_PA_SUB | t2); // 2

    wire _notFlag_HorZ = Flag_H ~| Flag_Z;
    wire _notFlag_CorS = Flag_C ~| Flag_S;
    wire _Flag_HorZ = _notFlag_HorZ ~| _notFlag_HorZ;
    wire _Flag_CorS = _notFlag_CorS ~| _notFlag_CorS;

    wire [1:0] _In = {_Flag_HorZ,_Flag_CorS};
    wire [1:0] _notIn = {_notFlag_HorZ,_notFlag_CorS};

    DECODER_2bit_decoder pa_low( // 8
        .notEnable(_nott3),
        .In(_In),
        .notIn(_notIn),
        .out00(PA_Select_0x0_low),
        .out01(PA_Select_0x60_low),
        .out10(PA_Select_0x06_low),
        .out11(PA_Select_0x66_low)
    );

endmodule