// MREQ/RD/WR/IORQ
module INTERFACE_out3(
        input wire PI_Nullify,
        input wire notPI_Flag,
        output wire interface_out
    );

    INTERFACE_74HC125 tri_(
        .nullify(PI_Nullify),
        .in(notPI_Flag),
        .out(interface_out)
    );

endmodule