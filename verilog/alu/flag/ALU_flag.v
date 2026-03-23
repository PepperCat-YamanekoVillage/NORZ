// 9(158)
module ALU_flag(
        input wire [15:0] High,
        input wire [15:0] notHigh,
        input wire [15:0] Low,
        input wire [15:0] notLow,
        input wire notCY4,
        input wire CY8,
        input wire ProcessedLow7,
        input wire notProcessedLow7,
        input wire ProcessedLow15,
        input wire notProcessedLow15,
        input wire [15:0] Result,
        input wire [7:0] notResult,
        input wire notResult15,
        output wire notIs8bitEqual,
        output wire is16bitEqual,
        output wire notIsResultLow0,
        output wire isResult0,
        output wire is8bitOverflow,
        output wire is16bitOverflow,
        output wire notIs8bitEvenParity,
        output wire DAA_Flag_H,
        output wire notDAACY8
    );

    //
    // Equal
    //

    wire _is8bitEqual;

    ALU_flag_is8bitEqual lowEq(
        .High(High[7:0]),
        .notHigh(notHigh[7:0]),
        .Low(Low[7:0]),
        .notLow(notLow[7:0]),
        .is8bitEqual(_is8bitEqual)
    );

    wire _isHigh8bitEqual;

    ALU_flag_is8bitEqual highEq(
        .High(High[15:8]),
        .notHigh(notHigh[15:8]),
        .Low(Low[15:8]),
        .notLow(notLow[15:8]),
        .is8bitEqual(_isHigh8bitEqual)
    );

    // and

    assign notIs8bitEqual = _is8bitEqual ~| _is8bitEqual;
    wire _notIs16bitEqual = _isHigh8bitEqual ~| _isHigh8bitEqual;
    assign is16bitEqual = notIs8bitEqual ~| _notIs16bitEqual;

    //
    // Zero
    //

    wire _isResultLow0;

    ALU_flag_is8bitZero lowZero(
        .Result(Result[7:0]),
        .is8bitZero(_isResultLow0)
    );

    wire _isResultHigh0;

    ALU_flag_is8bitZero highZero(
        .Result(Result[15:8]),
        .is8bitZero(_isResultHigh0)
    );

    // and

    assign notIsResultLow0 = _isResultLow0 ~| _isResultLow0;
    wire _notIsResultHigh0 = _isResultHigh0 ~| _isResultHigh0;
    assign isResult0 = notIsResultLow0 ~| _notIsResultHigh0;

    //
    // Overflow
    //

    ALU_flag_isOverflow lowOverflow(
        .High(High[7]),
        .notHigh(notHigh[7]),
        .ProcessedLow(ProcessedLow7),
        .notProcessedLow(notProcessedLow7),
        .Result(Result[7]),
        .notResult(notResult[7]),
        .isOverflow(is8bitOverflow)
    );

    ALU_flag_isOverflow highOverflow(
        .High(High[15]),
        .notHigh(notHigh[15]),
        .ProcessedLow(ProcessedLow15),
        .notProcessedLow(notProcessedLow15),
        .Result(Result[15]),
        .notResult(notResult15),
        .isOverflow(is16bitOverflow)
    );

    //
    // EvenParity
    //

    ALU_flag_is8bitEvenParity EvenParity(
        .Result(Result[7:0]),
        .notResult(notResult[7:0]),
        .notIs8bitEvenParity(notIs8bitEvenParity)
    );

    //
    // DAA_Flag_H
    //

    // xor

    wire _xor_n = notHigh[4] ~| notResult[4];
    wire _xor_p = High[4] ~| Result[4];
    assign DAA_Flag_H = _xor_n ~| _xor_p;

    //
    // DAACY8
    //

    ALU_flag_DAACY daacy(
        .notHigh(notHigh[7:0]),
        .notCY4(notCY4),
        .CY8(CY8),
        .notDAACY8(notDAACY8)
    );

endmodule