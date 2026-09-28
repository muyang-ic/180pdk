// Created by ihdl
`timescale 1ns/1ps

`celldefine

module DFSNQD2BWP7T (D, CP, SDN, Q, VDD, VSS);
    input D, CP, SDN;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  SDN_d ;
      buf      (SDN_i, SDN_d);
    `else         	// Reserve for non RECREM. 
      buf      (SDN_i, SDN);
    `endif
    wire D_d, CP_d ;
    pullup   (CDN);
    tsmc_dff (Q_buf, D_d, CP_d, CDN, SDN_i, notifier);
    buf      (Q, Q_buf);
  `else 	// Reserve for non NTC.
    buf      (SDN_i, SDN);
    pullup   (CDN);
    tsmc_dff (Q_buf, D, CP, CDN, SDN_i, notifier);
    buf      (Q, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  buf  (CP_check, SDN_i);
  buf  (D_check, SDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:D)) = (0, 0);
    if (CP == 1'b1 && D == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    ifnone (negedge SDN => (Q+:1'b1)) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge SDN, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $recrem (posedge SDN, posedge CP, 0,0, notifier, , , SDN_d, CP_d);
    `else
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $recovery (posedge SDN, posedge CP, 0, notifier);
      $hold (posedge CP, posedge SDN, 0, notifier);
    `endif
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $recovery (posedge SDN, posedge CP, 0, notifier);
    $hold (posedge CP, posedge SDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
