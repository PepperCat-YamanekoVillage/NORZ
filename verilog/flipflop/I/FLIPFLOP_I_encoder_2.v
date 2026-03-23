// ばらしてデコーダーの近くに置くことになるかも
// nor省略!!
// 150
module FLIPFLOP_I_encoder_2(
        input wire P2_Set_ILDrn_H,        // 0001 0100
        input wire P2_Set_ILDrn_L,        // 0001 0101
        input wire P2_Set_ILDrn_A,        // 0001 0111
        input wire P2_Set_ILDrlIXtdl_H,   // 0010 0100
        input wire P2_Set_ILDrlIXtdl_L,   // 0010 0101
        input wire P2_Set_ILDrlIXtdl_A,   // 0010 0111
        input wire P2_Set_ILDrlIYtdl_H,   // 0011 0100
        input wire P2_Set_ILDrlIYtdl_L,   // 0011 0101
        input wire P2_Set_ILDrlIYtdl_A,   // 0011 0111
        input wire P2_Set_ILDlIXtdlr_H,   // 0100 0100
        input wire P2_Set_ILDlIXtdlr_L,   // 0100 0101
        input wire P2_Set_ILDlIXtdlr_A,   // 0100 0111
        input wire P2_Set_ILDlIYtdlr_H,   // 0101 0100
        input wire P2_Set_ILDlIYtdlr_L,   // 0101 0101
        input wire P2_Set_ILDlIYtdlr_A,   // 0101 0111
        input wire P2_Set_ILDlIYtdln_0,   // 1111 1110
        input wire P2_Set_ILDlIYtdln_1,   // 1111 1111
        input wire P2_Set_ILDAlnnl_0,     // 0000 0100
        input wire P2_Set_ILDAlnnl_1,     // 0000 0101
        input wire P2_Set_ILDddnn_BC_1,   // 0110 0100
        input wire P2_Set_ILDddnn_DE_1,   // 0110 0101
        input wire P2_Set_ILDddnn_HL_1,   // 0110 0110
        input wire P2_Set_ILDddnn_SP_1,   // 0110 0111
        input wire P2_Set_ILDIYnn_0,      // 0000 1110
        input wire P2_Set_ILDIYnn_1,      // 0000 1111
        input wire P2_Set_ILDHLlnnl_0,    // 0000 1100
        input wire P2_Set_ILDHLlnnl_1,    // 0000 1101
        input wire P2_Set_ILDddlnnl_BC_1, // 0111 0100
        input wire P2_Set_ILDddlnnl_DE_1, // 0111 0101
        input wire P2_Set_ILDddlnnl_HL_1, // 0111 0110
        input wire P2_Set_ILDddlnnl_SP_1, // 0111 0111
        input wire P2_Set_ILDIYlnnl_0,    // 0001 1110
        input wire P2_Set_ILDIYlnnl_1,    // 0001 1111
        input wire P2_Set_ILDlnnldd_BC_1, // 1000 0100
        input wire P2_Set_ILDlnnldd_DE_1, // 1000 0101
        input wire P2_Set_ILDlnnldd_HL_1, // 1000 0110
        input wire P2_Set_ILDlnnldd_SP_1, // 1000 0111
        input wire P2_Set_ILDlnnlIY_0,    // 0010 1110
        input wire P2_Set_ILDlnnlIY_1,    // 0010 1111
        input wire P2_Set_IADCAn,         // 1111 0100
        input wire P2_Set_IADCAlIXtdl,    // 1100 1100
        input wire P2_Set_IADCAlIYtdl,    // 1101 1100
        input wire P2_Set_ISBCAn,         // 1111 0101
        input wire P2_Set_ISBCAlIXtdl,    // 1100 1101
        input wire P2_Set_ISBCAlIYtdl,    // 1101 1101
        input wire P2_Set_IXORn,          // 1111 0110
        input wire P2_Set_IXORlIXtdl,     // 1100 1110
        input wire P2_Set_IXORlIYtdl,     // 1101 1110
        input wire P2_Set_ICPn,           // 1111 0111
        input wire P2_Set_ICPlIXtdl,      // 1100 1111
        input wire P2_Set_ICPlIYtdl,      // 1101 1111
        input wire P2_Set_IDEClIXtdl,     // 1111 1100
        input wire P2_Set_IDEClIYtdl,     // 1111 1101
        input wire P2_Set_IJPnn_0,        // 0000 0110
        input wire P2_Set_IJPnn_1,        // 0000 0111
        input wire P2_Set_IJPccnn_4_0,    // 0100 1100
        input wire P2_Set_IJPccnn_5_0,    // 0100 1101
        input wire P2_Set_IJPccnn_6_0,    // 0100 1110
        input wire P2_Set_IJPccnn_7_0,    // 0100 1111
        input wire P2_Set_IJPccnn_4_1,    // 0101 1100
        input wire P2_Set_IJPccnn_5_1,    // 0101 1101
        input wire P2_Set_IJPccnn_6_1,    // 0101 1110
        input wire P2_Set_IJPccnn_7_1,    // 0101 1111
        input wire P2_Set_IJRZe,          // 0011 1110
        input wire P2_Set_IJRNZe,         // 0011 1111
        input wire P2_Set_ICALLnn_0,      // 0001 1100
        input wire P2_Set_ICALLnn_1,      // 0001 1101
        input wire P2_Set_IDJNZe,         // 0011 1100
        input wire P2_Set_ICALLnn_4_0,    // 1000 1100
        input wire P2_Set_ICALLnn_5_0,    // 1000 1101
        input wire P2_Set_ICALLnn_6_0,    // 1000 1110
        input wire P2_Set_ICALLnn_7_0,    // 1000 1111
        input wire P2_Set_ICALLnn_4_1,    // 1001 1100
        input wire P2_Set_ICALLnn_5_1,    // 1001 1101
        input wire P2_Set_ICALLnn_6_1,    // 1001 1110
        input wire P2_Set_ICALLnn_7_1,    // 1001 1111
        output wire encoded2
    );

    // or

    assign encoded2 = (P2_Set_ILDrn_H | P2_Set_ILDrn_L | P2_Set_ILDrn_A | P2_Set_ILDrlIXtdl_H | P2_Set_ILDrlIXtdl_L | P2_Set_ILDrlIXtdl_A | P2_Set_ILDrlIYtdl_H | P2_Set_ILDrlIYtdl_L | P2_Set_ILDrlIYtdl_A | P2_Set_ILDlIXtdlr_H | P2_Set_ILDlIXtdlr_L | P2_Set_ILDlIXtdlr_A | P2_Set_ILDlIYtdlr_H | P2_Set_ILDlIYtdlr_L | P2_Set_ILDlIYtdlr_A | P2_Set_ILDlIYtdln_0 | P2_Set_ILDlIYtdln_1 | P2_Set_ILDAlnnl_0 | P2_Set_ILDAlnnl_1 | P2_Set_ILDddnn_BC_1 | P2_Set_ILDddnn_DE_1 | P2_Set_ILDddnn_HL_1 | P2_Set_ILDddnn_SP_1 | P2_Set_ILDIYnn_0 | P2_Set_ILDIYnn_1 | P2_Set_ILDHLlnnl_0 | P2_Set_ILDHLlnnl_1 | P2_Set_ILDddlnnl_BC_1 | P2_Set_ILDddlnnl_DE_1 | P2_Set_ILDddlnnl_HL_1 | P2_Set_ILDddlnnl_SP_1 | P2_Set_ILDIYlnnl_0 | P2_Set_ILDIYlnnl_1 | P2_Set_ILDlnnldd_BC_1 | P2_Set_ILDlnnldd_DE_1 | P2_Set_ILDlnnldd_HL_1 | P2_Set_ILDlnnldd_SP_1 | P2_Set_ILDlnnlIY_0 | P2_Set_ILDlnnlIY_1 | P2_Set_IADCAn | P2_Set_IADCAlIXtdl | P2_Set_IADCAlIYtdl | P2_Set_ISBCAn | P2_Set_ISBCAlIXtdl | P2_Set_ISBCAlIYtdl | P2_Set_IXORn | P2_Set_IXORlIXtdl | P2_Set_IXORlIYtdl | P2_Set_ICPn | P2_Set_ICPlIXtdl | P2_Set_ICPlIYtdl | P2_Set_IDEClIXtdl | P2_Set_IDEClIYtdl | P2_Set_IJPnn_0 | P2_Set_IJPnn_1 | P2_Set_IJPccnn_4_0 | P2_Set_IJPccnn_5_0 | P2_Set_IJPccnn_6_0 | P2_Set_IJPccnn_7_0 | P2_Set_IJPccnn_4_1 | P2_Set_IJPccnn_5_1 | P2_Set_IJPccnn_6_1 | P2_Set_IJPccnn_7_1 | P2_Set_IJRZe | P2_Set_IJRNZe | P2_Set_ICALLnn_0 | P2_Set_ICALLnn_1 | P2_Set_IDJNZe | P2_Set_ICALLnn_4_0 | P2_Set_ICALLnn_5_0 | P2_Set_ICALLnn_6_0 | P2_Set_ICALLnn_7_0 | P2_Set_ICALLnn_4_1 | P2_Set_ICALLnn_5_1 | P2_Set_ICALLnn_6_1 | P2_Set_ICALLnn_7_1);

endmodule