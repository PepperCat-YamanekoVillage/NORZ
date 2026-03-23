// 4ゲートあるよ
module INTERFACE_74HC125(
        input wire nullify,
        input wire in,
        output wire out
    );

    assign out = (nullify) ? 1'bz : in;

endmodule