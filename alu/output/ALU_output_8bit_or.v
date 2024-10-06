// ALU_input_8bit_or と同じ
// 16
module ALU_output_8bit_or(
        input wire [7:0] A,
        input wire [7:0] B,
        output wire [7:0] Out,
        output wire [7:0] notOut
    );

    assign notOut[0] = A[0] ~| B[0];
    assign notOut[1] = A[1] ~| B[1];
    assign notOut[2] = A[2] ~| B[2];
    assign notOut[3] = A[3] ~| B[3];
    assign notOut[4] = A[4] ~| B[4];
    assign notOut[5] = A[5] ~| B[5];
    assign notOut[6] = A[6] ~| B[6];
    assign notOut[7] = A[7] ~| B[7];
    assign Out[0] = notOut[0] ~| notOut[0];
    assign Out[1] = notOut[1] ~| notOut[1];
    assign Out[2] = notOut[2] ~| notOut[2];
    assign Out[3] = notOut[3] ~| notOut[3];
    assign Out[4] = notOut[4] ~| notOut[4];
    assign Out[5] = notOut[5] ~| notOut[5];
    assign Out[6] = notOut[6] ~| notOut[6];
    assign Out[7] = notOut[7] ~| notOut[7];

endmodule