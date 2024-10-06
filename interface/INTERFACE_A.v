// (80)
module INTERFACE_A(
        input wire PI_SelectAdt1,
        input wire notPI_Activate_Ad_high,
        input wire notPI_Activate_Ad_low,
        input wire [15:0] notSelectedAd,
        output wire [15:0] interfaceAd
    );

    wire [15:0] _Inc;

    INTERFACE_16bit_inc Inc(
        .notIn(notSelectedAd),
        .Cin(PI_SelectAdt1),
        .S(_Inc)
    );

    INTERFACE_74HC245 out_low(
        .nullify(notPI_Activate_Ad_low),
        .in(_Inc[7:0]),
        .out(interfaceAd[7:0])
    );

    INTERFACE_74HC245 out_high(
        .nullify(notPI_Activate_Ad_high),
        .in(_Inc[15:8]),
        .out(interfaceAd[15:8])
    );

endmodule