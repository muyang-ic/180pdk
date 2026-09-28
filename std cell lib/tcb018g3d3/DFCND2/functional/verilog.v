// Created by ihdl
`timescale 1ns/10ps

`celldefine

module DFCND2 (D, CP, CDN, Q, QN, VDD, VSS);
    input D, CP, CDN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  CDN_d ;
      buf      (CDN_i, CDN_d);
    `else         	// Reserve for non RECREM. 
      buf      (CDN_i, CDN);
    `endif
    wire D_d, CP_d ;
    pullup	 (SDN);
    tsmc_dff (Q_buf, D_d, CP_d, CDN_i, SDN, notifier);
    buf      (Q, Q_buf);
    not		 (QN, Q_buf);
  `else 	// Reserve for non NTC.
    buf      (CDN_i, CDN);
    pullup	 (SDN);
    tsmc_dff (Q_buf, D, CP, CDN_i, SDN, notifier);
    buf      (Q, Q_buf);
    not		 (QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  buf  (CP_check, CDN_i);
  buf  (D_check, CDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (CP == 1'b1 && D == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    ifnone (negedge CDN => (Q+:1'b0)) = (0, 0);
    (posedge CP => (Q+:D)) = (0, 0);
    if (CP == 1'b1 && D == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    ifnone (negedge CDN => (QN-:1'b0)) = (0, 0);
    (posedge CP => (QN-:D)) = (0, 0);
    $width (negedge CDN, 0, 0, notifier);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $recrem (posedge CDN, posedge CP, 0,0, notifier, , , CDN_d, CP_d);
    `else
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $recovery (posedge CDN, posedge CP, 0, notifier);
      $hold (posedge CP, posedge CDN, 0, notifier);
    `endif
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $recovery (posedge CDN, posedge CP, 0, notifier);
    $hold (posedge CP, posedge CDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
