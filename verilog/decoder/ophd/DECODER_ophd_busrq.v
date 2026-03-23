// 3
module DECODER_ophd_busrq(
        input wire BUSRQ,
        input wire not_enable_busrq,
        output wire P2_Set_CBUSRQ, // <
        output wire PI_Nullify_MREQ,
        output wire PI_Nullify_RD,
        output wire PI_Nullify_WR,
        output wire PI_Nullify_IORQ,
        output wire PI_Flag_BUSAK,
        output wire PR_Halt_XPT,
        output wire PhI_Flag_BUSAK,// >
        output wire not_enable_nmi
    );

    wire _is_ophd_busrq = not_enable_busrq ~| BUSRQ;

    wire _enable_nmi = _is_ophd_busrq ~| not_enable_busrq;
    assign not_enable_nmi = _enable_nmi ~| _enable_nmi;

    assign P2_Set_CBUSRQ = _is_ophd_busrq;
    assign PI_Nullify_MREQ = _is_ophd_busrq;
    assign PI_Nullify_RD = _is_ophd_busrq;
    assign PI_Nullify_WR = _is_ophd_busrq;
    assign PI_Nullify_IORQ = _is_ophd_busrq;
    assign PI_Flag_BUSAK = _is_ophd_busrq;
    assign PR_Halt_XPT = _is_ophd_busrq;
    assign PhI_Flag_BUSAK = _is_ophd_busrq;

endmodule