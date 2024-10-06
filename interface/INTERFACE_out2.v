// BUSAK/RFSH/M1/HALT
module INTERFACE_out2(
        input wire notPI_Flag,
        output wire interface
    );

    assign interface = notPI_Flag;

endmodule