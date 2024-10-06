// ばらしてデコーダーの近くに置くことになるかも(その過程で多少ゲート数へらせるかもね)
// nor省略!!
// 110
module FLIPFLOP_I_encoder_7(
        input wire P2_Set_ILDlIXtdln_0,   // 1111 1010
        input wire P2_Set_ILDlIXtdln_1,   // 1111 1011
        input wire P2_Set_ILDlIYtdln_0,   // 1111 1110
        input wire P2_Set_ILDlIYtdln_1,   // 1111 1111
        input wire P2_Set_ILDlnnldd_BC_0, // 1000 0000
        input wire P2_Set_ILDlnnldd_DE_0, // 1000 0001
        input wire P2_Set_ILDlnnldd_HL_0, // 1000 0010
        input wire P2_Set_ILDlnnldd_SP_0, // 1000 0011
        input wire P2_Set_ILDlnnldd_BC_1, // 1000 0100
        input wire P2_Set_ILDlnnldd_DE_1, // 1000 0101
        input wire P2_Set_ILDlnnldd_HL_1, // 1000 0110
        input wire P2_Set_ILDlnnldd_SP_1, // 1000 0111
        input wire P2_Set_IADDAn,         // 1111 0000
        input wire P2_Set_IADDAlIXtdl,    // 1100 1000
        input wire P2_Set_IADDAlIYtdl,    // 1101 1000
        input wire P2_Set_IADCAn,         // 1111 0100
        input wire P2_Set_IADCAlIXtdl,    // 1100 1100
        input wire P2_Set_IADCAlIYtdl,    // 1101 1100
        input wire P2_Set_ISUBAn,         // 1111 0001
        input wire P2_Set_ISUBAlIXtdl,    // 1100 1001
        input wire P2_Set_ISUBAlIYtdl,    // 1101 1001
        input wire P2_Set_ISBCAn,         // 1111 0101
        input wire P2_Set_ISBCAlIXtdl,    // 1100 1101
        input wire P2_Set_ISBCAlIYtdl,    // 1101 1101
        input wire P2_Set_IANDn,          // 1111 0010
        input wire P2_Set_IANDlIXtdl,     // 1100 1010
        input wire P2_Set_IANDlIYtdl,     // 1101 1010
        input wire P2_Set_IORn,           // 1111 0011
        input wire P2_Set_IORlIXtdl,      // 1100 1011
        input wire P2_Set_IORlIYtdl,      // 1101 1011
        input wire P2_Set_IXORn,          // 1111 0110
        input wire P2_Set_IXORlIXtdl,     // 1100 1110
        input wire P2_Set_IXORlIYtdl,     // 1101 1110
        input wire P2_Set_ICPn,           // 1111 0111
        input wire P2_Set_ICPlIXtdl,      // 1100 1111
        input wire P2_Set_ICPlIYtdl,      // 1101 1111
        input wire P2_Set_IINClIXtdl,     // 1111 1000
        input wire P2_Set_IINClIYtdl,     // 1111 1001
        input wire P2_Set_IDEClIXtdl,     // 1111 1100
        input wire P2_Set_IDEClIYtdl,     // 1111 1101
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
        output wire encoded7
    );

    // or

    assign encoded7 = (P2_Set_ILDlIXtdln_0 | P2_Set_ILDlIXtdln_1 | P2_Set_ILDlIYtdln_0 | P2_Set_ILDlIYtdln_1 | P2_Set_ILDlnnldd_BC_0 | P2_Set_ILDlnnldd_DE_0 | P2_Set_ILDlnnldd_HL_0 | P2_Set_ILDlnnldd_SP_0 | P2_Set_ILDlnnldd_BC_1 | P2_Set_ILDlnnldd_DE_1 | P2_Set_ILDlnnldd_HL_1 | P2_Set_ILDlnnldd_SP_1 | P2_Set_IADDAn | P2_Set_IADDAlIXtdl | P2_Set_IADDAlIYtdl | P2_Set_IADCAn | P2_Set_IADCAlIXtdl | P2_Set_IADCAlIYtdl | P2_Set_ISUBAn | P2_Set_ISUBAlIXtdl | P2_Set_ISUBAlIYtdl | P2_Set_ISBCAn | P2_Set_ISBCAlIXtdl | P2_Set_ISBCAlIYtdl | P2_Set_IANDn | P2_Set_IANDlIXtdl | P2_Set_IANDlIYtdl | P2_Set_IORn | P2_Set_IORlIXtdl | P2_Set_IORlIYtdl | P2_Set_IXORn | P2_Set_IXORlIXtdl | P2_Set_IXORlIYtdl | P2_Set_ICPn | P2_Set_ICPlIXtdl | P2_Set_ICPlIYtdl | P2_Set_IINClIXtdl | P2_Set_IINClIYtdl | P2_Set_IDEClIXtdl | P2_Set_IDEClIYtdl | P2_Set_ICALLnn_0_0 | P2_Set_ICALLnn_1_0 | P2_Set_ICALLnn_2_0 | P2_Set_ICALLnn_3_0 | P2_Set_ICALLnn_4_0 | P2_Set_ICALLnn_5_0 | P2_Set_ICALLnn_6_0 | P2_Set_ICALLnn_7_0 | P2_Set_ICALLnn_0_1 | P2_Set_ICALLnn_1_1 | P2_Set_ICALLnn_2_1 | P2_Set_ICALLnn_3_1 | P2_Set_ICALLnn_4_1 | P2_Set_ICALLnn_5_1 | P2_Set_ICALLnn_6_1 | P2_Set_ICALLnn_7_1);

endmodule