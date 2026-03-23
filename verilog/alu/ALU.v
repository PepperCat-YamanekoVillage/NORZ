// 10(1819)
module ALU(
        input wire [7:0] notA,
        input wire [7:0] notF,
        input wire [7:0] notB,
        input wire [7:0] notC,
        input wire [7:0] notD,
        input wire [7:0] notE,
        input wire [7:0] notH,
        input wire [7:0] notL,
        input wire [7:0] notDt,
        input wire [7:0] notDtcs,
        input wire [7:0] notDin,
        input wire [7:0] notR,
        input wire [7:0] notI,
        input wire [7:0] notOP,
        input wire [7:0] notOPold,
        input wire [15:0] notPC,
        input wire [15:0] notSP,
        input wire [15:0] notIX,
        input wire [15:0] notIY,
        input wire Flag_C,
        input wire notPA_Select_A_high,
        input wire notPA_Select_B_high,
        input wire PA_Select_C_high,
        input wire notPA_Select_D_high,
        input wire PA_Select_E_high,
        input wire notPA_Select_H_high,
        input wire PA_Select_L_high,
        input wire notPA_Select_Dt_high,
        input wire PA_Select_BC_high,
        input wire PA_Select_DE_high,
        input wire PA_Select_HL_high,
        input wire notPA_Select_PC_high,
        input wire notPA_Select_SP_high,
        input wire notPA_Select_IX_high,
        input wire notPA_Select_IY_high,
        input wire PA_Select_0x1_high, // 未使用
        input wire notPA_Select_A_low,
        input wire notPA_Select_F_low,
        input wire notPA_Select_B_low,
        input wire PA_Select_C_low,
        input wire notPA_Select_D_low,
        input wire PA_Select_E_low,
        input wire notPA_Select_H_low,
        input wire PA_Select_L_low,
        input wire notPA_Select_Dt_low,
        input wire notPA_Select_Dtcs_low,
        input wire notPA_Select_Din_low,
        input wire notPA_Select_R_low,
        input wire notPA_Select_I_low,
        input wire PA_Select_OP_low,
        input wire PA_Select_BC_low,
        input wire PA_Select_DE_low,
        input wire PA_Select_HL_low,
        input wire notPA_Select_PC_low, // 未使用
        input wire notPA_Select_SP_low,
        input wire notPA_Select_IX_low,
        input wire notPA_Select_IY_low,
        input wire PA_Select_IOP_low,
        input wire notPA_Select_OPOPold_low,
        input wire PA_Select_0xffOP_low,
        input wire PA_Select_OPold_low,
        input wire PA_Select_OPxx_low,
        input wire PA_Select_0x1_low,
        input wire PA_Select_0x8_low,
        input wire PA_Select_0x10_low,
        input wire PA_Select_0x18_low,
        input wire PA_Select_0x20_low,
        input wire PA_Select_0x28_low,
        input wire PA_Select_0x30_low,
        input wire PA_Select_0x38_low,
        input wire PA_Select_0x66_low,
        input wire PA_Select_0xaa_low,
        input wire PA_Select_0x06_low,
        input wire PA_Select_0x60_low,
        input wire PA_Select_0x2_low,
        input wire PA_Select_0x4_low,
        input wire PA_Select_0x40_low,
        input wire PA_Select_0x80_low,
        input wire PA_NOP,
        input wire PA_ADD,
        input wire PA_ADC,
        input wire PA_SUB,
        input wire PA_SBC,
        input wire PA_NOT,
        input wire PA_AND,
        input wire PA_NLAND,
        input wire PA_OR,
        input wire PA_XOR,
        input wire PA_RLC,
        input wire PA_RL,
        input wire PA_SLA,
        input wire PA_RRC,
        input wire PA_RR,
        input wire PA_SRA,
        input wire PA_SRL,
        input wire PA_RLD,
        input wire PA_RRD,
        output wire [15:0] notResult,
        output wire notLow0,
        output wire notLow7,
        output wire notCY4,
        output wire notCY8,
        output wire CY12,
        output wire CY16,
        output wire notIs8bitEqual,
        output wire is16bitEqual,
        output wire notIsResultLow0,
        output wire isResult0,
        output wire is8bitOverflow,
        output wire is16bitOverflow,
        output wire notIs8bitEvenParity,
        output wire DAA_Flag_H,
        output wire notDAACY8,
        output wire [15:0] debugHigh,
        output wire [15:0] debugLow
    );

    assign debugHigh = _High;
    assign debugLow = _Low;

    wire [15:0] _High;
    wire [15:0] _notHigh;
    wire [15:0] _Low;
    wire [15:0] _notLow;
    wire [15:0] _ProcessedLow;
    wire [7:0] _notProcessedLowLow;
    wire _notProcessedLow15 = _ProcessedLow[15] ~| _ProcessedLow[15];
    assign _notProcessedLowLow[0] = _ProcessedLow[0] ~| _ProcessedLow[0];
    assign _notProcessedLowLow[1] = _ProcessedLow[1] ~| _ProcessedLow[1];
    assign _notProcessedLowLow[2] = _ProcessedLow[2] ~| _ProcessedLow[2];
    assign _notProcessedLowLow[3] = _ProcessedLow[3] ~| _ProcessedLow[3];
    assign _notProcessedLowLow[4] = _ProcessedLow[4] ~| _ProcessedLow[4];
    assign _notProcessedLowLow[5] = _ProcessedLow[5] ~| _ProcessedLow[5];
    assign _notProcessedLowLow[6] = _ProcessedLow[6] ~| _ProcessedLow[6];
    assign _notProcessedLowLow[7] = _ProcessedLow[7] ~| _ProcessedLow[7];

    assign notLow0 = _notLow[0];
    assign notLow7 = _notLow[7];

    ALU_input_mux input_(
        .notA(notA),
        .notF(notF),
        .notB(notB),
        .notC(notC),
        .notD(notD),
        .notE(notE),
        .notH(notH),
        .notL(notL),
        .notDt(notDt),
        .notDtcs(notDtcs),
        .notDin(notDin),
        .notR(notR),
        .notI(notI),
        .notOP(notOP),
        .notOPold(notOPold),
        .notPC(notPC),
        .notSP(notSP),
        .notIX(notIX),
        .notIY(notIY),
        .notPA_Select_A_high(notPA_Select_A_high),
        .notPA_Select_B_high(notPA_Select_B_high),
        .PA_Select_C_high(PA_Select_C_high),
        .notPA_Select_D_high(notPA_Select_D_high),
        .PA_Select_E_high(PA_Select_E_high),
        .notPA_Select_H_high(notPA_Select_H_high),
        .PA_Select_L_high(PA_Select_L_high),
        .notPA_Select_Dt_high(notPA_Select_Dt_high),
        .PA_Select_BC_high(PA_Select_BC_high),
        .PA_Select_DE_high(PA_Select_DE_high),
        .PA_Select_HL_high(PA_Select_HL_high),
        .notPA_Select_PC_high(notPA_Select_PC_high),
        .notPA_Select_SP_high(notPA_Select_SP_high),
        .notPA_Select_IX_high(notPA_Select_IX_high),
        .notPA_Select_IY_high(notPA_Select_IY_high),
        .PA_Select_0x1_high(PA_Select_0x1_high), // 未使用
        .notPA_Select_A_low(notPA_Select_A_low),
        .notPA_Select_F_low(notPA_Select_F_low),
        .notPA_Select_B_low(notPA_Select_B_low),
        .PA_Select_C_low(PA_Select_C_low),
        .notPA_Select_D_low(notPA_Select_D_low),
        .PA_Select_E_low(PA_Select_E_low),
        .notPA_Select_H_low(notPA_Select_H_low),
        .PA_Select_L_low(PA_Select_L_low),
        .notPA_Select_Dt_low(notPA_Select_Dt_low),
        .notPA_Select_Dtcs_low(notPA_Select_Dtcs_low),
        .notPA_Select_Din_low(notPA_Select_Din_low),
        .notPA_Select_R_low(notPA_Select_R_low),
        .notPA_Select_I_low(notPA_Select_I_low),
        .PA_Select_OP_low(PA_Select_OP_low),
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_HL_low(PA_Select_HL_low),
        .notPA_Select_PC_low(notPA_Select_PC_low),// 未使用
        .notPA_Select_SP_low(notPA_Select_SP_low),
        .notPA_Select_IX_low(notPA_Select_IX_low),
        .notPA_Select_IY_low(notPA_Select_IY_low),
        .PA_Select_IOP_low(PA_Select_IOP_low),
        .notPA_Select_OPOPold_low(notPA_Select_OPOPold_low),
        .PA_Select_0xffOP_low(PA_Select_0xffOP_low),
        .PA_Select_OPold_low(PA_Select_OPold_low),
        .PA_Select_OPxx_low(PA_Select_OPxx_low),
        .PA_Select_0x1_low(PA_Select_0x1_low),
        .PA_Select_0x8_low(PA_Select_0x8_low),
        .PA_Select_0x10_low(PA_Select_0x10_low),
        .PA_Select_0x18_low(PA_Select_0x18_low),
        .PA_Select_0x20_low(PA_Select_0x20_low),
        .PA_Select_0x28_low(PA_Select_0x28_low),
        .PA_Select_0x30_low(PA_Select_0x30_low),
        .PA_Select_0x38_low(PA_Select_0x38_low),
        .PA_Select_0x66_low(PA_Select_0x66_low),
        .PA_Select_0xaa_low(PA_Select_0xaa_low),
        .PA_Select_0x06_low(PA_Select_0x06_low),
        .PA_Select_0x60_low(PA_Select_0x60_low),
        .PA_Select_0x2_low(PA_Select_0x2_low),
        .PA_Select_0x4_low(PA_Select_0x4_low),
        .PA_Select_0x40_low(PA_Select_0x40_low),
        .PA_Select_0x80_low(PA_Select_0x80_low),
        .High(_High),
        .notHigh(_notHigh),
        .Low(_Low),
        .notLow(_notLow)
    );

    wire _notRl7;
    wire _notRl0;
    wire _notRfC;
    wire _notPAs_ADD;
    wire _notPAs_AND;
    wire _notPAs_RL;
    wire _notPAs_RR;

    ALU_operation operation(
        .Low(_Low),
        .notLow(_notLow),
        .PA_NOP(PA_NOP),
        .PA_ADD(PA_ADD),
        .PA_ADC(PA_ADC),
        .PA_SUB(PA_SUB),
        .PA_SBC(PA_SBC),
        .PA_NOT(PA_NOT),
        .PA_AND(PA_AND),
        .PA_NLAND(PA_NLAND),
        .PA_RLC(PA_RLC),
        .PA_RL(PA_RL),
        .PA_SLA(PA_SLA),
        .PA_RRC(PA_RRC),
        .PA_RR(PA_RR),
        .PA_SRA(PA_SRA),
        .PA_SRL(PA_SRL),
        .ProcessedLow(_ProcessedLow),
        .notRl7(_notRl7),
        .notRl0(_notRl0),
        .notRfC(_notRfC),
        .notPAs_ADD(_notPAs_ADD),
        .notPAs_AND(_notPAs_AND),
        .notPAs_RL(_notPAs_RL),
        .notPAs_RR(_notPAs_RR)
    );

    wire [15:0] _ADD;
    wire [7:0] _AND;
    wire [7:0] _notOR;
    wire [7:0] _notXOR;
    wire [7:0] _notRL;
    wire [7:0] _notRR;
    wire [15:0] _notRLD;
    wire [15:0] _notRRD;

    ALU_calc calc(
        .High(_High),
        .notHigh(_notHigh[7:0]),
        .ProcessedLow(_ProcessedLow),
        .notProcessedLow(_notProcessedLowLow),
        .Flag_C(Flag_C),
        .PA_ADC(PA_ADC),
        .PA_SUB(PA_SUB),
        .PA_SBC(PA_SBC),
        .notRl7(_notRl7),
        .notRl0(_notRl0),
        .notRfC(_notRfC),
        .SUM(_ADD),
        .AND(_AND),
        .notOR(_notOR),
        .notXOR(_notXOR),
        .notRL(_notRL),
        .notRR(_notRR),
        .notRLD(_notRLD),
        .notRRD(_notRRD),
        .notCY4(notCY4),
        .notCY8(notCY8),
        .CY12(CY12),
        .CY16(CY16)
    );

    wire [15:0] _Result;
    
    ALU_output_mux output_(
        .ADD(_ADD),
        .AND(_AND),
        .notOR(_notOR),
        .notXOR(_notXOR),
        .notRL(_notRL),
        .notRR(_notRR),
        .notRLD(_notRLD),
        .notRRD(_notRRD),
        .notPAs_ADD(_notPAs_ADD),
        .notPAs_AND(_notPAs_AND),
        .PA_OR(PA_OR),
        .PA_XOR(PA_XOR),
        .notPAs_RL(_notPAs_RL),
        .notPAs_RR(_notPAs_RR),
        .PA_RLD(PA_RLD),
        .PA_RRD(PA_RRD),
        .Result(_Result),
        .notResult(notResult)
    );

    wire _notCY8 = notCY8 ~| notCY8;

    ALU_flag flag(
        .High(_High),
        .notHigh(_notHigh),
        .Low(_Low),
        .notLow(_notLow),
        .notCY4(notCY4),
        .CY8(_notCY8),
        .ProcessedLow7(_ProcessedLow[7]),
        .notProcessedLow7(_notProcessedLowLow[7]),
        .ProcessedLow15(_ProcessedLow[15]),
        .notProcessedLow15(_notProcessedLow15),
        .Result(_Result),
        .notResult(notResult[7:0]),
        .notResult15(notResult[15]),
        .notIs8bitEqual(notIs8bitEqual),
        .is16bitEqual(is16bitEqual),
        .notIsResultLow0(notIsResultLow0),
        .isResult0(isResult0),
        .is8bitOverflow(is8bitOverflow),
        .is16bitOverflow(is16bitOverflow),
        .notIs8bitEvenParity(notIs8bitEvenParity),
        .DAA_Flag_H(DAA_Flag_H),
        .notDAACY8(notDAACY8)
    );

endmodule