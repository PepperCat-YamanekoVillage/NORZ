// BUSAK/RFSH/M1/HALT
module INTERFACE_out2(
        input wire notPI_Flag,
        output wire interface_out
    );

    assign interface_out = notPI_Flag;

endmodule