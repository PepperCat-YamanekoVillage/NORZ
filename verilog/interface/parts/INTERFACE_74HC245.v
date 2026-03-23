module INTERFACE_74HC245(
        input wire nullify,
        input wire [7:0] in,
        output wire [7:0] out
    );

    assign out[0] = (nullify) ? 1'bz : in[0];
    assign out[1] = (nullify) ? 1'bz : in[1];
    assign out[2] = (nullify) ? 1'bz : in[2];
    assign out[3] = (nullify) ? 1'bz : in[3];
    assign out[4] = (nullify) ? 1'bz : in[4];
    assign out[5] = (nullify) ? 1'bz : in[5];
    assign out[6] = (nullify) ? 1'bz : in[6];
    assign out[7] = (nullify) ? 1'bz : in[7];

endmodule