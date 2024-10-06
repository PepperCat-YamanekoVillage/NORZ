// ばらしてデコーダーの近くに置くことになるかも
// nor省略!!
// 162
module FLIPFLOP_I_encoder_3(
        input wire P2_Set_ILDlIXtdln_0,   // 1111 1010
        input wire P2_Set_ILDlIXtdln_1,   // 1111 1011
        input wire P2_Set_ILDlIYtdln_0,   // 1111 1110
        input wire P2_Set_ILDlIYtdln_1,   // 1111 1111
        input wire P2_Set_ILDlnnlA_0,     // 0000 1000
        input wire P2_Set_ILDlnnlA_1,     // 0000 1001
        input wire P2_Set_ILDIXnn_0,      // 0000 1010
        input wire P2_Set_ILDIXnn_1,      // 0000 1011
        input wire P2_Set_ILDIYnn_0,      // 0000 1110
        input wire P2_Set_ILDIYnn_1,      // 0000 1111
        input wire P2_Set_ILDHLlnnl_0,    // 0000 1100
        input wire P2_Set_ILDHLlnnl_1,    // 0000 1101
        input wire P2_Set_ILDIXlnnl_0,    // 0001 1010
        input wire P2_Set_ILDIXlnnl_1,    // 0001 1011
        input wire P2_Set_ILDIYlnnl_0,    // 0001 1110
        input wire P2_Set_ILDIYlnnl_1,    // 0001 1111
        input wire P2_Set_ILDlnnlIX_0,    // 0010 1010
        input wire P2_Set_ILDlnnlIX_1,    // 0010 1011
        input wire P2_Set_ILDlnnlIY_0,    // 0010 1110
        input wire P2_Set_ILDlnnlIY_1,    // 0010 1111
        input wire P2_Set_IADDAlIXtdl,    // 1100 1000
        input wire P2_Set_IADDAlIYtdl,    // 1101 1000
        input wire P2_Set_IADCAlIXtdl,    // 1100 1100
        input wire P2_Set_IADCAlIYtdl,    // 1101 1100
        input wire P2_Set_ISUBAlIXtdl,    // 1100 1001
        input wire P2_Set_ISUBAlIYtdl,    // 1101 1001
        input wire P2_Set_ISBCAlIXtdl,    // 1100 1101
        input wire P2_Set_ISBCAlIYtdl,    // 1101 1101
        input wire P2_Set_IANDlIXtdl,     // 1100 1010
        input wire P2_Set_IANDlIYtdl,     // 1101 1010
        input wire P2_Set_IORlIXtdl,      // 1100 1011
        input wire P2_Set_IORlIYtdl,      // 1101 1011
        input wire P2_Set_IXORlIXtdl,     // 1100 1110
        input wire P2_Set_IXORlIYtdl,     // 1101 1110
        input wire P2_Set_ICPlIXtdl,      // 1100 1111
        input wire P2_Set_ICPlIYtdl,      // 1101 1111
        input wire P2_Set_IINClIXtdl,     // 1111 1000
        input wire P2_Set_IINClIYtdl,     // 1111 1001
        input wire P2_Set_IDEClIXtdl,     // 1111 1100
        input wire P2_Set_IDEClIYtdl,     // 1111 1101
        input wire P2_Set_IJPccnn_0_0,    // 0100 1000
        input wire P2_Set_IJPccnn_1_0,    // 0100 1001
        input wire P2_Set_IJPccnn_2_0,    // 0100 1010
        input wire P2_Set_IJPccnn_3_0,    // 0100 1011
        input wire P2_Set_IJPccnn_4_0,    // 0100 1100
        input wire P2_Set_IJPccnn_5_0,    // 0100 1101
        input wire P2_Set_IJPccnn_6_0,    // 0100 1110
        input wire P2_Set_IJPccnn_7_0,    // 0100 1111
        input wire P2_Set_IJPccnn_0_1,    // 0101 1000
        input wire P2_Set_IJPccnn_1_1,    // 0101 1001
        input wire P2_Set_IJPccnn_2_1,    // 0101 1010
        input wire P2_Set_IJPccnn_3_1,    // 0101 1011
        input wire P2_Set_IJPccnn_4_1,    // 0101 1100
        input wire P2_Set_IJPccnn_5_1,    // 0101 1101
        input wire P2_Set_IJPccnn_6_1,    // 0101 1110
        input wire P2_Set_IJPccnn_7_1,    // 0101 1111
        input wire P2_Set_IJRe,           // 0011 1000
        input wire P2_Set_IJRCe,          // 0011 1010
        input wire P2_Set_IJRNCe,         // 0011 1011
        input wire P2_Set_IJRZe,          // 0011 1110
        input wire P2_Set_IJRNZe,         // 0011 1111
        input wire P2_Set_IDJNZe,         // 0011 1100
        input wire P2_Set_ICALLnn_0,      // 0001 1100
        input wire P2_Set_ICALLnn_1,      // 0001 1101
        input wire P2_Set_IINAlnl,        // 0010 1000
        input wire P2_Set_IOUTlnlA,       // 0010 1001
        input wire P2_Set_ICALLnn_0_0,    // 1000 1000
        input wire P2_Set_ICALLnn_1_0,    // 1000 1001
        input wire P2_Set_ICALLnn_2_0,    // 1000 1010
        input wire P2_Set_ICALLnn_3_0,    // 1000 1011
        input wire P2_Set_ICALLnn_4_0,    // 1000 1100
        input wire P2_Set_ICALLnn_5_0,    // 1000 1101
        input wire P2_Set_ICALLnn_6_0,    // 1000 1110
        input wire P2_Set_ICALLnn_7_0,    // 1000 1111
        input wire P2_Set_ICALLnn_0_1,    // 1001 1000
        input wire P2_Set_ICALLnn_1_1,    // 1001 1001
        input wire P2_Set_ICALLnn_2_1,    // 1001 1010
        input wire P2_Set_ICALLnn_3_1,    // 1001 1011
        input wire P2_Set_ICALLnn_4_1,    // 1001 1100
        input wire P2_Set_ICALLnn_5_1,    // 1001 1101
        input wire P2_Set_ICALLnn_6_1,    // 1001 1110
        input wire P2_Set_ICALLnn_7_1,    // 1001 1111
        output wire encoded3
    );

    // or

    assign encoded3 = (P2_Set_ILDlIXtdln_0 | P2_Set_ILDlIXtdln_1 | P2_Set_ILDlIYtdln_0 | P2_Set_ILDlIYtdln_1 | P2_Set_ILDlnnlA_0 | P2_Set_ILDlnnlA_1 | P2_Set_ILDIXnn_0 | P2_Set_ILDIXnn_1 | P2_Set_ILDIYnn_0 | P2_Set_ILDIYnn_1 | P2_Set_ILDHLlnnl_0 | P2_Set_ILDHLlnnl_1 | P2_Set_ILDIXlnnl_0 | P2_Set_ILDIXlnnl_1 | P2_Set_ILDIYlnnl_0 | P2_Set_ILDIYlnnl_1 | P2_Set_ILDlnnlIX_0 | P2_Set_ILDlnnlIX_1 | P2_Set_ILDlnnlIY_0 | P2_Set_ILDlnnlIY_1 | P2_Set_IADDAlIXtdl | P2_Set_IADDAlIYtdl | P2_Set_IADCAlIXtdl | P2_Set_IADCAlIYtdl | P2_Set_ISUBAlIXtdl | P2_Set_ISUBAlIYtdl | P2_Set_ISBCAlIXtdl | P2_Set_ISBCAlIYtdl | P2_Set_IANDlIXtdl | P2_Set_IANDlIYtdl | P2_Set_IORlIXtdl | P2_Set_IORlIYtdl | P2_Set_IXORlIXtdl | P2_Set_IXORlIYtdl | P2_Set_ICPlIXtdl | P2_Set_ICPlIYtdl | P2_Set_IINClIXtdl | P2_Set_IINClIYtdl | P2_Set_IDEClIXtdl | P2_Set_IDEClIYtdl | P2_Set_IJPccnn_0_0 | P2_Set_IJPccnn_1_0 | P2_Set_IJPccnn_2_0 | P2_Set_IJPccnn_3_0 | P2_Set_IJPccnn_4_0 | P2_Set_IJPccnn_5_0 | P2_Set_IJPccnn_6_0 | P2_Set_IJPccnn_7_0 | P2_Set_IJPccnn_0_1 | P2_Set_IJPccnn_1_1 | P2_Set_IJPccnn_2_1 | P2_Set_IJPccnn_3_1 | P2_Set_IJPccnn_4_1 | P2_Set_IJPccnn_5_1 | P2_Set_IJPccnn_6_1 | P2_Set_IJPccnn_7_1 | P2_Set_IJRe | P2_Set_IJRCe | P2_Set_IJRNCe | P2_Set_IJRZe | P2_Set_IJRNZe | P2_Set_IDJNZe | P2_Set_ICALLnn_0 | P2_Set_ICALLnn_1 | P2_Set_IINAlnl | P2_Set_IOUTlnlA | P2_Set_ICALLnn_0_0 | P2_Set_ICALLnn_1_0 | P2_Set_ICALLnn_2_0 | P2_Set_ICALLnn_3_0 | P2_Set_ICALLnn_4_0 | P2_Set_ICALLnn_5_0 | P2_Set_ICALLnn_6_0 | P2_Set_ICALLnn_7_0 | P2_Set_ICALLnn_0_1 | P2_Set_ICALLnn_1_1 | P2_Set_ICALLnn_2_1 | P2_Set_ICALLnn_3_1 | P2_Set_ICALLnn_4_1 | P2_Set_ICALLnn_5_1 | P2_Set_ICALLnn_6_1 | P2_Set_ICALLnn_7_1);

endmodule