// 24(95)
module DECODER_op_XIX_00(
        input wire enable,
        input wire is_Y,
        input wire [4:0] XPT,
        input wire [4:0] notXPT,
        input wire [7:0] Source,
        input wire [7:0] notSource,
        output wire PR_Reset_XPT,
        output wire P2_Set_CM1, // <
        output wire Pa_Ophd, // >
        output wire PA_ADD,
        output wire PF_Write_C, // <
        output wire PF_Write_N,
        output wire PF_Write_H,
        output wire PF_Select_C_bit32,
        output wire PF_Select_N_bit16,
        output wire PF_Select_H_bit31, // >
        output wire PA_Select_IX_high, // <
        output wire PR_Write_IX_high,
        output wire PR_Write_IX_low, // >
        output wire P2_Reset_XIX,
        output wire PA_Select_IY_high, // <
        output wire PR_Write_IY_high,
        output wire PR_Write_IY_low, // >
        output wire P2_Reset_XIY,
        output wire PA_Select_BC_low,
        output wire PA_Select_DE_low,
        output wire PA_Select_SP_low,
        output wire PA_Select_IX_low,
        output wire PA_Select_IY_low,
        output wire PA_Select_0x1_low,
        output wire PA_SUB,
        output wire P2_Set_CMR,
        output wire P2_Set_ILDIXlnnl_0,
        output wire P2_Set_ILDIYlnnl_0,
        output wire P2_Set_ILDIXnn_0,
        output wire P2_Set_ILDIYnn_0,
        output wire P2_Set_ILDlnnlIX_0,
        output wire P2_Set_ILDlnnlIY_0,
        output wire P2_Set_IINClIXtdl,
        output wire P2_Set_IINClIYtdl,
        output wire P2_Set_IDEClIXtdl,
        output wire P2_Set_IDEClIYtdl,
        output wire P2_Set_ILDlIXtdln_0,
        output wire P2_Set_ILDlIYtdln_0
    );

    // wire [4:0] notXPT = ~XPT;
    // wire [7:0] notSource = ~Source;

    //
    // decoder
    //

    wire _not_enable = enable ~| enable;

    wire _00xx1x0x = ~(_not_enable | notSource[3] | Source[1]); // 3
    wire _00xxxx11 = ~(_not_enable | notSource[1] | notSource[0]); // 3
    wire _00other = ~(_not_enable | _00xx1x0x | _00xxxx11); // 3

    wire _PR_Reset_XPT_add; // <
    wire _P2_Set_CM1_add;
    wire _Pa_Ophd_add;
    wire _PA_ADD_add; // >
    wire _PA_Select_IX_high_add; // <
    wire _PR_Write_IX_high_add;
    wire _PR_Write_IX_low_add;
    wire _P2_Reset_XIX_add; // >
    wire _PA_Select_IY_high_add; // <
    wire _PR_Write_IY_high_add;
    wire _PR_Write_IY_low_add;
    wire _P2_Reset_XIY_add; // >

    DECODER_op_XIX_00xx1001 d00xx1001(
        .enable(_00xx1x0x),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_add), // <
        .P2_Set_CM1(_P2_Set_CM1_add),
        .Pa_Ophd(_Pa_Ophd_add),
        .PA_ADD(_PA_ADD_add),
        .PF_Write_C(PF_Write_C),
        .PF_Write_N(PF_Write_N),
        .PF_Write_H(PF_Write_H),
        .PF_Select_C_bit32(PF_Select_C_bit32),
        .PF_Select_N_bit16(PF_Select_N_bit16),
        .PF_Select_H_bit31(PF_Select_H_bit31), // >
        .PA_Select_IX_high(_PA_Select_IX_high_add), // <
        .PR_Write_IX_high(_PR_Write_IX_high_add),
        .PR_Write_IX_low(_PR_Write_IX_low_add),
        .P2_Reset_XIX(_P2_Reset_XIX_add), // >
        .PA_Select_IY_high(_PA_Select_IY_high_add), // <
        .PR_Write_IY_high(_PR_Write_IY_high_add),
        .PR_Write_IY_low(_PR_Write_IY_low_add),
        .P2_Reset_XIY(_P2_Reset_XIY_add), // >
        .PA_Select_BC_low(PA_Select_BC_low),
        .PA_Select_DE_low(PA_Select_DE_low),
        .PA_Select_SP_low(PA_Select_SP_low),
        .PA_Select_IX_low(PA_Select_IX_low),
        .PA_Select_IY_low(PA_Select_IY_low)
    );

    wire _PR_Reset_XPT_inc; // <
    wire _P2_Set_CM1_inc;
    wire _Pa_Ophd_inc; // >
    wire _PA_Select_IX_high_inc; // <
    wire _PR_Write_IX_high_inc;
    wire _PR_Write_IX_low_inc;
    wire _P2_Reset_XIX_inc; // >
    wire _PA_Select_IY_high_inc; // <
    wire _PR_Write_IY_high_inc;
    wire _PR_Write_IY_low_inc;
    wire _P2_Reset_XIY_inc; // >
    wire _PA_ADD_inc;

    DECODER_op_XIX_0010x011 d0010x011(
        .enable(_00xxxx11),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_inc), // <
        .P2_Set_CM1(_P2_Set_CM1_inc),
        .Pa_Ophd(_Pa_Ophd_inc),
        .PA_Select_0x1_low(PA_Select_0x1_low), // >
        .PA_Select_IX_high(_PA_Select_IX_high_inc), // <
        .PR_Write_IX_high(_PR_Write_IX_high_inc),
        .PR_Write_IX_low(_PR_Write_IX_low_inc),
        .P2_Reset_XIX(_P2_Reset_XIX_inc), // >
        .PA_Select_IY_high(_PA_Select_IY_high_inc), // <
        .PR_Write_IY_high(_PR_Write_IY_high_inc),
        .PR_Write_IY_low(_PR_Write_IY_low_inc),
        .P2_Reset_XIY(_P2_Reset_XIY_inc), // >
        .PA_ADD(_PA_ADD_inc),
        .PA_SUB(PA_SUB)
    );

    wire _PR_Reset_XPT_otr;
    wire _P2_Reset_XIX_otr;
    wire _P2_Reset_XIY_otr;

    DECODER_op_XIX_00other d00other(
        .enable(_00other),
        .is_Y(is_Y),
        .XPT(XPT),
        .notXPT(notXPT),
        .Source(Source),
        .notSource(notSource),
        .PR_Reset_XPT(_PR_Reset_XPT_otr), // <
        .P2_Set_CMR(P2_Set_CMR), // >
        .P2_Reset_XIX(_P2_Reset_XIX_otr),
        .P2_Reset_XIY(_P2_Reset_XIY_otr),
        .P2_Set_ILDIXlnnl_0(P2_Set_ILDIXlnnl_0),
        .P2_Set_ILDIYlnnl_0(P2_Set_ILDIYlnnl_0),
        .P2_Set_ILDIXnn_0(P2_Set_ILDIXnn_0),
        .P2_Set_ILDIYnn_0(P2_Set_ILDIYnn_0),
        .P2_Set_ILDlnnlIX_0(P2_Set_ILDlnnlIX_0),
        .P2_Set_ILDlnnlIY_0(P2_Set_ILDlnnlIY_0),
        .P2_Set_IINClIXtdl(P2_Set_IINClIXtdl),
        .P2_Set_IINClIYtdl(P2_Set_IINClIYtdl),
        .P2_Set_IDEClIXtdl(P2_Set_IDEClIXtdl),
        .P2_Set_IDEClIYtdl(P2_Set_IDEClIYtdl),
        .P2_Set_ILDlIXtdln_0(P2_Set_ILDlIXtdln_0),
        .P2_Set_ILDlIYtdln_0(P2_Set_ILDlIYtdln_0)
    );

    assign P2_Set_CM1 = (_PR_Reset_XPT_add | _PR_Reset_XPT_inc); // 2
    assign Pa_Ophd = P2_Set_CM1;

    assign PR_Reset_XPT = (P2_Set_CM1 | _PR_Reset_XPT_otr); // 2

    assign PA_ADD = (_PA_ADD_add | _PA_ADD_inc); // 2

    assign PA_Select_IX_high = (_PA_Select_IX_high_add | _PA_Select_IX_high_inc); // 2
    assign PR_Write_IX_high = PA_Select_IX_high;
    assign PR_Write_IX_low = PA_Select_IX_high;

    assign P2_Reset_XIX = (PA_Select_IX_high | _P2_Reset_XIX_otr); // 2

    assign PA_Select_IY_high = (_PA_Select_IY_high_add | _PA_Select_IY_high_inc); // 2
    assign PR_Write_IY_high = PA_Select_IY_high;
    assign PR_Write_IY_low = PA_Select_IY_high;

    assign P2_Reset_XIY = (PA_Select_IY_high | _P2_Reset_XIY_otr); // 2

endmodule