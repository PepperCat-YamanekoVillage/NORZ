// ADD/SUB/AND/OR/ADC/SBC/XOR/CP A,n
// 18(36)
module DECODER_I_11110(
        input wire enable,
        input wire [7:0] ITABLE,
        input wire [7:0] notITABLE,
        output wire P2_Reset_ITABLE, // <
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1,
        output wire PA_Select_A_high,
        output wire PR_InvertIn,
        output wire PF_Write_S,
        output wire PF_Select_S_bit7,
        output wire PF_Write_Z,
        output wire PF_Select_Z_bit24,
        output wire PF_Write_H,
        output wire PF_Write_PV,
        output wire PF_Write_N,
        output wire PF_Write_C,
        output wire Pa_Ophd, // >
        output wire PR_Write_A,
        output wire PA_ADD,
        output wire PA_ADC,
        output wire PA_SUB,
        output wire PA_SBC,
        output wire PA_AND,
        output wire PA_OR,
        output wire PA_XOR,
        output wire PF_Select_H_bit22, // <
        output wire PF_Select_N_bit17,
        output wire PF_Select_C_bit26, // >
        output wire PF_Select_H_bit21, // <
        output wire PF_Select_C_bit23, // >
        output wire PF_Select_H_bit16,
        output wire PF_Select_PV_bit27, // <
        output wire PF_Select_C_bit16, // >
        output wire PF_Select_H_bit17,
        output wire PF_Select_N_bit16,
        output wire PF_Select_PV_bit25
    );

    // wire [7:0] notITABLE = ~ITABLE;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _110000xx;
    wire _110001xx;

    DECODER_1bit_decoder d_11110dxx(
        .notEnable(_not_enable),
        .In(ITABLE[2]),
        .notIn(notITABLE[2]),
        .out0(_110000xx),
        .out1(_110001xx)
    ); 

    wire _not110000xx = _110000xx ~| _110000xx;
    wire _not110001xx = _110001xx ~| _110001xx;

    wire _11000000; // ADD
    wire _11000001; // SUB
    wire _11000010; // AND
    wire _11000011; // OR

    DECODER_2bit_decoder d_111100dd( // 8
        .notEnable(_not110000xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_11000000),
        .out01(_11000001),
        .out10(_11000010),
        .out11(_11000011)
    );

    wire _11000100; // ADC
    wire _11000101; // SBC
    wire _11000110; // XOR
    wire _11000111; // CP

    DECODER_2bit_decoder d_111101dd( // 8
        .notEnable(_not110001xx),
        .In(ITABLE[1:0]),
        .notIn(notITABLE[1:0]),
        .out00(_11000100),
        .out01(_11000101),
        .out10(_11000110),
        .out11(_11000111)
    );

    //
    // XPT 2
    //

    // 11110xxx

    assign P2_Reset_ITABLE = enable;
    assign PR_Reset_XPT = enable;
    assign P2_Set_CM1 = enable;
    assign PA_Select_A_high = enable;
    assign PR_InvertIn = enable;
    assign PF_Write_S = enable;
    assign PF_Select_S_bit7 = enable;
    assign PF_Write_Z = enable;
    assign PF_Select_Z_bit24 = enable;
    assign PF_Write_H = enable;
    assign PF_Write_PV = enable;
    assign PF_Write_N = enable;
    assign PF_Write_C = enable;
    assign Pa_Ophd = enable;

    // except CP

    wire _exceptCP = _11000111 ~| _not_enable;

    assign PR_Write_A = _exceptCP;

    // SUB or CP

    wire _SUB_CP = (_11000001 | _11000111); // 2

    assign PA_SUB = _SUB_CP;

    assign PA_ADD = _11000000;
    assign PA_AND = _11000010;
    assign PA_OR = _11000011;
    assign PA_ADC = _11000100;
    assign PA_SBC = _11000101;
    assign PA_XOR = _11000110;

    // Flag

    wire _FT_ADD = (_11000000 | _11000100); // 2
    wire _FT_SUB = (_SUB_CP | _11000101); // 2
    wire _FT_OR = (_11000011 | _11000110); // 2

    assign PF_Select_H_bit21 = _FT_ADD;
    assign PF_Select_C_bit23 = _FT_ADD;

    assign PF_Select_H_bit22 = _FT_SUB;
    assign PF_Select_N_bit17 = _FT_SUB;
    assign PF_Select_C_bit26 = _FT_SUB;

    assign PF_Select_H_bit16 = _FT_OR;

    assign PF_Select_PV_bit27 = (_FT_OR | _11000010); // 2
    assign PF_Select_C_bit16 = PF_Select_PV_bit27;

    assign PF_Select_H_bit17 = _11000010;

    assign PF_Select_N_bit16 = (_FT_ADD | PF_Select_PV_bit27); // 2

    assign PF_Select_PV_bit25 = (_FT_ADD | _FT_SUB); // 2

endmodule