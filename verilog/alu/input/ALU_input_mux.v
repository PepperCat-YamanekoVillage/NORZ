// (1157)
module ALU_input_mux(
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
        input wire notPA_Select_PC_low,// 未使用
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
        output wire [15:0] High,
        output wire [15:0] notHigh,
        output wire [15:0] Low,
        output wire [15:0] notLow
    );

    wire [7:0] _AFHigh;
    wire [7:0] _AFLow;
    
    ALU_input_mux_AF af(
        .notA(notA),
        .notF(notF),
        .notPA_Select_A_high(notPA_Select_A_high),
        .notPA_Select_A_low(notPA_Select_A_low),
        .notPA_Select_F_low(notPA_Select_F_low),
        .High(_AFHigh),
        .Low(_AFLow)
    );

    wire [15:0] _BCHigh;
    wire [15:0] _BCLow;

    ALU_input_mux_BC bc(
        .notB(notB),
        .notC(notC),
        .notPA_Select_B_high(notPA_Select_B_high),
        .PA_Select_C_high(PA_Select_C_high),
        .PA_Select_BC_high(PA_Select_BC_high),
        .notPA_Select_B_low(notPA_Select_B_low),
        .PA_Select_C_low(PA_Select_C_low),
        .PA_Select_BC_low(PA_Select_BC_low),
        .High(_BCHigh),
        .Low(_BCLow)
    );

    wire [15:0] _DEHigh;
    wire [15:0] _DELow;

    ALU_input_mux_BC de(
        .notB(notD),
        .notC(notE),
        .notPA_Select_B_high(notPA_Select_D_high),
        .PA_Select_C_high(PA_Select_E_high),
        .PA_Select_BC_high(PA_Select_DE_high),
        .notPA_Select_B_low(notPA_Select_D_low),
        .PA_Select_C_low(PA_Select_E_low),
        .PA_Select_BC_low(PA_Select_DE_low),
        .High(_DEHigh),
        .Low(_DELow)
    );

    wire [15:0] _HLHigh;
    wire [15:0] _HLLow;

    ALU_input_mux_BC hl(
        .notB(notH),
        .notC(notL),
        .notPA_Select_B_high(notPA_Select_H_high),
        .PA_Select_C_high(PA_Select_L_high),
        .PA_Select_BC_high(PA_Select_HL_high),
        .notPA_Select_B_low(notPA_Select_H_low),
        .PA_Select_C_low(PA_Select_L_low),
        .PA_Select_BC_low(PA_Select_HL_low),
        .High(_HLHigh),
        .Low(_HLLow)
    );

    wire [15:0] _PCHigh;
    wire [15:0] _PCLow;
    
    ALU_input_mux_PC pc(
        .notPC(notPC),
        .notPA_Select_PC_high(notPA_Select_PC_high),
        .notPA_Select_PC_low(notPA_Select_PC_low),// 未使用
        .High(_PCHigh),
        .Low(_PCLow)
    );

    wire [15:0] _SPHigh;
    wire [15:0] _SPLow;
    
    ALU_input_mux_PC sp(
        .notPC(notSP),
        .notPA_Select_PC_high(notPA_Select_SP_high),
        .notPA_Select_PC_low(notPA_Select_SP_low),
        .High(_SPHigh),
        .Low(_SPLow)
    );

    wire [15:0] _IXHigh;
    wire [15:0] _IXLow;
    
    ALU_input_mux_PC ix(
        .notPC(notIX),
        .notPA_Select_PC_high(notPA_Select_IX_high),
        .notPA_Select_PC_low(notPA_Select_IX_low),
        .High(_IXHigh),
        .Low(_IXLow)
    );

    wire [15:0] _IYHigh;
    wire [15:0] _IYLow;
    
    ALU_input_mux_PC iy(
        .notPC(notIY),
        .notPA_Select_PC_high(notPA_Select_IY_high),
        .notPA_Select_PC_low(notPA_Select_IY_low),
        .High(_IYHigh),
        .Low(_IYLow)
    );

    wire [15:0] _OPLow;
    
    ALU_input_mux_OP op(
        .notOP(notOP),
        .notOPold(notOPold),
        .PA_Select_OP_low(PA_Select_OP_low),
        .PA_Select_IOP_low(PA_Select_IOP_low),
        .notPA_Select_OPOPold_low(notPA_Select_OPOPold_low),
        .PA_Select_0xffOP_low(PA_Select_0xffOP_low),
        .PA_Select_OPold_low(PA_Select_OPold_low),
        .PA_Select_OPxx_low(PA_Select_OPxx_low),
        .Low(_OPLow)
    );

    wire [15:0] _IRLow;
    
    ALU_input_mux_IR ir(
        .notR(notR),
        .notI(notI),
        .notPA_Select_R_low(notPA_Select_R_low),
        .notPA_Select_I_low(notPA_Select_I_low),
        .PA_Select_IOP_low(PA_Select_IOP_low),
        .Low(_IRLow)
    );

    wire [7:0] _DtHigh;
    wire [7:0] _DtLow;
    
    ALU_input_mux_Dt dt(
        .notDt(notDt),
        .notPA_Select_Dt_high(notPA_Select_Dt_high),
        .notPA_Select_Dt_low(notPA_Select_Dt_low),
        .High(_DtHigh),
        .Low(_DtLow)
    );

    wire [7:0] _DtcsLow;
    
    ALU_input_mux_Dtcs dtcs(
        .notDtcs(notDtcs),
        .notPA_Select_Dtcs_low(notPA_Select_Dtcs_low),
        .Low(_DtcsLow)
    );

    wire [7:0] _DinLow;
    
    ALU_input_mux_Dtcs din(
        .notDtcs(notDin),
        .notPA_Select_Dtcs_low(notPA_Select_Din_low),
        .Low(_DinLow)
    );

    wire _directHigh;
    wire [15:0] _directLow;
    
    ALU_input_mux_direct direct(
        .PA_Select_0x1_high(PA_Select_0x1_high), // 未使用
        .PA_Select_0xffOP_low(PA_Select_0xffOP_low),
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
        .High(_directHigh),
        .Low(_directLow)
    );

    // BC

    wire [15:0] _AFBCHigh;
    ALU_input_8bit_or afbcHigh(
        .A(_AFHigh),
        .B(_BCHigh[7:0]),
        .Out(_AFBCHigh[7:0])
    );
    assign _AFBCHigh[15:8] = _BCHigh[15:8];

    wire [15:0] _AFBCLow;
    ALU_input_8bit_or afbcLow(
        .A(_AFLow),
        .B(_BCLow[7:0]),
        .Out(_AFBCLow[7:0])
    );
    assign _AFBCLow[15:8] = _BCLow[15:8];

    // DE

    wire [15:0] _AFBCDEHigh;
    ALU_input_8bit_or afbcdeHighLow(
        .A(_AFBCHigh[7:0]),
        .B(_DEHigh[7:0]),
        .Out(_AFBCDEHigh[7:0])
    );
    ALU_input_8bit_or afbcdeHighHigh(
        .A(_AFBCHigh[15:8]),
        .B(_DEHigh[15:8]),
        .Out(_AFBCDEHigh[15:8])
    );

    wire [15:0] _AFBCDELow;
    ALU_input_8bit_or afbcdeLowLow(
        .A(_AFBCLow[7:0]),
        .B(_DELow[7:0]),
        .Out(_AFBCDELow[7:0])
    );
    ALU_input_8bit_or afbcdeLowHigh(
        .A(_AFBCLow[15:8]),
        .B(_DELow[15:8]),
        .Out(_AFBCDELow[15:8])
    );

    // HL

    wire [15:0] _AFBCDEHLHigh;
    ALU_input_8bit_or afbcdehlHighLow(
        .A(_AFBCDEHigh[7:0]),
        .B(_HLHigh[7:0]),
        .Out(_AFBCDEHLHigh[7:0])
    );
    ALU_input_8bit_or afbcdehlHighHigh(
        .A(_AFBCDEHigh[15:8]),
        .B(_HLHigh[15:8]),
        .Out(_AFBCDEHLHigh[15:8])
    );

    wire [15:0] _AFBCDEHLLow;
    ALU_input_8bit_or afbcdehlLowLow(
        .A(_AFBCDELow[7:0]),
        .B(_HLLow[7:0]),
        .Out(_AFBCDEHLLow[7:0])
    );
    ALU_input_8bit_or afbcdehlLowHigh(
        .A(_AFBCDELow[15:8]),
        .B(_HLLow[15:8]),
        .Out(_AFBCDEHLLow[15:8])
    );

    // PC

    wire [15:0] _AFBCDEHLPCHigh;
    ALU_input_8bit_or afbcdehlpcHighLow(
        .A(_AFBCDEHLHigh[7:0]),
        .B(_PCHigh[7:0]),
        .Out(_AFBCDEHLPCHigh[7:0])
    );
    ALU_input_8bit_or afbcdehlpcHighHigh(
        .A(_AFBCDEHLHigh[15:8]),
        .B(_PCHigh[15:8]),
        .Out(_AFBCDEHLPCHigh[15:8])
    );

    wire [15:0] _AFBCDEHLPCLow;
    ALU_input_8bit_or afbcdehlpcLowLow(
        .A(_AFBCDEHLLow[7:0]),
        .B(_PCLow[7:0]),
        .Out(_AFBCDEHLPCLow[7:0])
    );
    ALU_input_8bit_or afbcdehlpcLowHigh(
        .A(_AFBCDEHLLow[15:8]),
        .B(_PCLow[15:8]),
        .Out(_AFBCDEHLPCLow[15:8])
    );

    // SP

    wire [15:0] _AFBCDEHLPCSPHigh;
    ALU_input_8bit_or afbcdehlpcspHighLow(
        .A(_AFBCDEHLPCHigh[7:0]),
        .B(_SPHigh[7:0]),
        .Out(_AFBCDEHLPCSPHigh[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspHighHigh(
        .A(_AFBCDEHLPCHigh[15:8]),
        .B(_SPHigh[15:8]),
        .Out(_AFBCDEHLPCSPHigh[15:8])
    );

    wire [15:0] _AFBCDEHLPCSPLow;
    ALU_input_8bit_or afbcdehlpcspLowLow(
        .A(_AFBCDEHLPCLow[7:0]),
        .B(_SPLow[7:0]),
        .Out(_AFBCDEHLPCSPLow[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspLowHigh(
        .A(_AFBCDEHLPCLow[15:8]),
        .B(_SPLow[15:8]),
        .Out(_AFBCDEHLPCSPLow[15:8])
    );

    // IX

    wire [15:0] _AFBCDEHLPCSPIXHigh;
    ALU_input_8bit_or afbcdehlpcspixHighLow(
        .A(_AFBCDEHLPCSPHigh[7:0]),
        .B(_IXHigh[7:0]),
        .Out(_AFBCDEHLPCSPIXHigh[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspixHighHigh(
        .A(_AFBCDEHLPCSPHigh[15:8]),
        .B(_IXHigh[15:8]),
        .Out(_AFBCDEHLPCSPIXHigh[15:8])
    );

    wire [15:0] _AFBCDEHLPCSPIXLow;
    ALU_input_8bit_or afbcdehlpcspixLowLow(
        .A(_AFBCDEHLPCSPLow[7:0]),
        .B(_IXLow[7:0]),
        .Out(_AFBCDEHLPCSPIXLow[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspixLowHigh(
        .A(_AFBCDEHLPCSPLow[15:8]),
        .B(_IXLow[15:8]),
        .Out(_AFBCDEHLPCSPIXLow[15:8])
    );

    // IY

    wire [15:0] _AFBCDEHLPCSPIXIYHigh;
    wire [7:0] _notAFBCDEHLPCSPIXIYHighHigh;
    ALU_input_8bit_or afbcdehlpcspixiyHighLow(
        .A(_AFBCDEHLPCSPIXHigh[7:0]),
        .B(_IYHigh[7:0]),
        .Out(_AFBCDEHLPCSPIXIYHigh[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspixiyHighHigh(
        .A(_AFBCDEHLPCSPIXHigh[15:8]),
        .B(_IYHigh[15:8]),
        .Out(_AFBCDEHLPCSPIXIYHigh[15:8]),
        .notOut(_notAFBCDEHLPCSPIXIYHighHigh)
    );

    wire [15:0] _AFBCDEHLPCSPIXIYLow;
    ALU_input_8bit_or afbcdehlpcspixiyLowLow(
        .A(_AFBCDEHLPCSPIXLow[7:0]),
        .B(_IYLow[7:0]),
        .Out(_AFBCDEHLPCSPIXIYLow[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspixiyLowHigh(
        .A(_AFBCDEHLPCSPIXLow[15:8]),
        .B(_IYLow[15:8]),
        .Out(_AFBCDEHLPCSPIXIYLow[15:8])
    );

    // IR

    wire [15:0] _AFBCDEHLPCSPIXIYIRLow;
    ALU_input_8bit_or afbcdehlpcspixiyirLowLow(
        .A(_AFBCDEHLPCSPIXIYLow[7:0]),
        .B(_IRLow[7:0]),
        .Out(_AFBCDEHLPCSPIXIYIRLow[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspixiyirLowHigh(
        .A(_AFBCDEHLPCSPIXIYLow[15:8]),
        .B(_IRLow[15:8]),
        .Out(_AFBCDEHLPCSPIXIYIRLow[15:8])
    );

    // Dt

    wire [15:0] _AFBCDEHLPCSPIXIYIRDtHigh;
    wire [15:0] _notAFBCDEHLPCSPIXIYIRDtHigh;
    ALU_input_8bit_or afbcdehlpcspixiydtHighLow(
        .A(_AFBCDEHLPCSPIXIYHigh[7:0]),
        .B(_DtHigh),
        .Out(_AFBCDEHLPCSPIXIYIRDtHigh[7:0]),
        .notOut(_notAFBCDEHLPCSPIXIYIRDtHigh[7:0])
    );
    assign _AFBCDEHLPCSPIXIYIRDtHigh[15:8] = _AFBCDEHLPCSPIXIYHigh[15:8];
    assign _notAFBCDEHLPCSPIXIYIRDtHigh[15:8] = _notAFBCDEHLPCSPIXIYHighHigh;

    wire [15:0] _AFBCDEHLPCSPIXIYIRDtLow;
    ALU_input_8bit_or afbcdehlpcspixiyirdtLowLow(
        .A(_AFBCDEHLPCSPIXIYIRLow[7:0]),
        .B(_DtLow),
        .Out(_AFBCDEHLPCSPIXIYIRDtLow[7:0])
    );
    assign _AFBCDEHLPCSPIXIYIRDtLow[15:8] = _AFBCDEHLPCSPIXIYIRLow[15:8];

    // Dtcs

    wire [15:0] _AFBCDEHLPCSPIXIYIRDtDtcsLow;
    ALU_input_8bit_or afbcdehlpcspixiyirdtdtcsLowLow(
        .A(_AFBCDEHLPCSPIXIYIRDtLow[7:0]),
        .B(_DtcsLow),
        .Out(_AFBCDEHLPCSPIXIYIRDtDtcsLow[7:0])
    );
    assign _AFBCDEHLPCSPIXIYIRDtDtcsLow[15:8] = _AFBCDEHLPCSPIXIYIRDtLow[15:8];

    // Din

    wire [15:0] _AFBCDEHLPCSPIXIYIRDtDtcsDinLow;
    ALU_input_8bit_or afbcdehlpcspixiyirdtdtcsdinLowLow(
        .A(_AFBCDEHLPCSPIXIYIRDtDtcsLow[7:0]),
        .B(_DinLow),
        .Out(_AFBCDEHLPCSPIXIYIRDtDtcsDinLow[7:0])
    );
    assign _AFBCDEHLPCSPIXIYIRDtDtcsDinLow[15:8] = _AFBCDEHLPCSPIXIYIRDtDtcsLow[15:8];

    // direct

    wire [15:0] _AFBCDEHLPCSPIXIYIRDtDtcsDindirectLow;
    ALU_input_8bit_or afbcdehlpcspixiyirdtdtcsdindirectLowLow(
        .A(_AFBCDEHLPCSPIXIYIRDtDtcsDinLow[7:0]),
        .B(_directLow[7:0]),
        .Out(_AFBCDEHLPCSPIXIYIRDtDtcsDindirectLow[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspixiyirdtdtcsdindirectLowHigh(
        .A(_AFBCDEHLPCSPIXIYIRDtDtcsDinLow[15:8]),
        .B(_directLow[15:8]),
        .Out(_AFBCDEHLPCSPIXIYIRDtDtcsDindirectLow[15:8])
    );

    // OP

    assign High[15:0] = _AFBCDEHLPCSPIXIYIRDtHigh[15:0];
    assign notHigh[15:0] = _notAFBCDEHLPCSPIXIYIRDtHigh[15:0];

    ALU_input_8bit_or afbcdehlpcspixiyirdtdtcsdindirectopLowLow(
        .A(_AFBCDEHLPCSPIXIYIRDtDtcsDindirectLow[7:0]),
        .B(_OPLow[7:0]),
        .Out(Low[7:0]),
        .notOut(notLow[7:0])
    );
    ALU_input_8bit_or afbcdehlpcspixiyirdtdtcsdindirectopLowHigh(
        .A(_AFBCDEHLPCSPIXIYIRDtDtcsDindirectLow[15:8]),
        .B(_OPLow[15:8]),
        .Out(Low[15:8]),
        .notOut(notLow[15:8])
    );

endmodule