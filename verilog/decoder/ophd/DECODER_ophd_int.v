// 12
module DECODER_ophd_int(
        input wire TINT,
        input wire notIFF1,
        input wire IMFa,
        input wire IMFb,
        input wire not_enable_int,
        output wire P2_Set_CINT0,
        output wire P2_Set_CINT1,
        output wire P2_Set_CINT2,
        output wire P2_Reset_LHALT, // <
        output wire P2_Reset_TINT,
        output wire P2_Reset_IFF1,
        output wire P2_Reset_IFF2,
        output wire PI_Activate_Ad_high,
        output wire PI_Activate_Ad_low,
        output wire PI_SelectAd_PC,
        output wire PI_Flag_M1, // >
        output wire enable
    );

    wire _is_ophd_int0 = not_enable_int ~| TINT;
    wire _not_is_ophd_int0 = _is_ophd_int0 ~| _is_ophd_int0;
    wire _is_ophd_int = notIFF1 ~| _not_is_ophd_int0;
    wire _not_is_ophd_int = _is_ophd_int ~| _is_ophd_int;

    assign enable = _is_ophd_int ~| not_enable_int;

    wire _notIMFa = IMFa ~| IMFa;
    wire _notIMFb = IMFb ~| IMFb;

    wire _cint0 = IMFa ~| _not_is_ophd_int;
    wire _cint12 = _notIMFa ~| _not_is_ophd_int;
    wire _not_cint12 = _cint12 ~| _cint12;
    wire _cint1 = _not_cint12 ~| IMFb;
    wire _cint2 = _not_cint12 ~| _notIMFb;

    assign P2_Set_CINT0 = _cint0;
    assign P2_Set_CINT1 = _cint1;
    assign P2_Set_CINT2 = _cint2;
    assign P2_Reset_LHALT = _is_ophd_int;
    assign P2_Reset_TINT = _is_ophd_int;
    assign P2_Reset_IFF1 = _is_ophd_int;
    assign P2_Reset_IFF2 = _is_ophd_int;
    assign PI_Activate_Ad_high = _is_ophd_int;
    assign PI_Activate_Ad_low = _is_ophd_int;
    assign PI_SelectAd_PC = _is_ophd_int;
    assign PI_Flag_M1 = _is_ophd_int;

endmodule