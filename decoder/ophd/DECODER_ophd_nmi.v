// 3
module DECODER_ophd_nmi(
        input wire TNMI,
        input wire not_enable_nmi,
        output wire P2_Set_CNMI, // <
        output wire P2_Reset_TNMI,
        output wire P2_Reset_LHALT,
        output wire P2_EvacuateIFF,
        output wire P2_Reset_IFF1,
        output wire PC_M1, // >
        output wire not_enable_int
    );

    wire _is_ophd_nmi = not_enable_nmi ~| TNMI;

    wire _enable_int = _is_ophd_nmi ~| not_enable_nmi;
    assign not_enable_int = _enable_int ~| _enable_int;

    assign P2_Set_CNMI = _is_ophd_nmi;
    assign P2_Reset_TNMI = _is_ophd_nmi;
    assign P2_Reset_LHALT = _is_ophd_nmi;
    assign P2_EvacuateIFF = _is_ophd_nmi;
    assign P2_Reset_IFF1 = _is_ophd_nmi;
    assign PC_M1 = _is_ophd_nmi;

endmodule