module INTERFACE_74HC245(
        input wire nullify,
        input wire [7:0] in,
        output wire [7:0] out
    );

    assign out[0] = (nullify) ? z : in[0];
    assign out[1] = (nullify) ? z : in[1];
    assign out[2] = (nullify) ? z : in[2];
    assign out[3] = (nullify) ? z : in[3];
    assign out[4] = (nullify) ? z : in[4];
    assign out[5] = (nullify) ? z : in[5];
    assign out[6] = (nullify) ? z : in[6];
    assign out[7] = (nullify) ? z : in[7];

endmodule