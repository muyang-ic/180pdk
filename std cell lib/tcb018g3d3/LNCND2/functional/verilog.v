// Created by ihdl
`timescale 1ns/10ps

`celldefine

module LNCND2 (D, EN, CDN, Q, QN, VDD, VSS);
    input D, EN, CDN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  CDN_d ;
      buf          (CDN_i, CDN_d);
    `else         	// Reserve for non RECREM. 
      buf          (CDN_i, CDN);
    `endif
    wire D_d, EN_d ;
    pullup       (SDN);
    not		(E, EN_d);
    tsmc_dla	(Q_buf, D_d, E, CDN_i, SDN, notifier);
    buf          (Q, Q_buf);
    not		(QN, Q_buf);
  `else 	// Reserve for non NTC.
    buf          (CDN_i, CDN);
    pullup       (SDN);
    not		(E, EN);
    tsmc_dla	(Q_buf, D, E, CDN_i, SDN, notifier);
    buf          (Q, Q_buf);
    not		(QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  buf  (D_check, CDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (D == 1'b1 && EN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (D == 1'b0 && EN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (D == 1'b1 && EN == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    ifnone (CDN => Q) = (0, 0);
    (D => Q) = (0, 0);
    (negedge EN => (Q+:D)) = (0, 0);
    if (D == 1'b1 && EN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (D == 1'b0 && EN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (D == 1'b1 && EN == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    ifnone (CDN => QN) = (0, 0);
    (D => QN) = (0, 0);
    (negedge EN => (QN-:D)) = (0, 0);
    $width (negedge CDN, 0, 0, notifier);
    $width (negedge EN, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, EN_d, D_d);
      $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, EN_d, D_d);
      $recrem (posedge CDN, posedge EN, 0,0, notifier, , , CDN_d, EN_d);
    `else
      $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, EN_d, D_d);
      $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, EN_d, D_d);
      $recovery (posedge CDN, posedge EN, 0, notifier);
      $hold (posedge EN, posedge CDN, 0, notifier);
    `endif
  `else
    $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $recovery (posedge CDN, posedge EN, 0, notifier);
    $hold (posedge EN, posedge CDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
