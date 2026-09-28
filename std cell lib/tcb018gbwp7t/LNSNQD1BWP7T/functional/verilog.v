// Created by ihdl
`timescale 1ns/1ps

`celldefine

module LNSNQD1BWP7T (D, EN, SDN, Q, VDD, VSS);
    input D, EN, SDN;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  SDN_d ;
      buf          (SDN_i, SDN_d);
    `else         	// Reserve for non RECREM. 
      buf          (SDN_i, SDN);
    `endif
    wire D_d, EN_d ;
    pullup       (CDN);
    not		(E, EN_d);
    tsmc_dla	(Q_buf, D_d, E, CDN, SDN_i, notifier);
    buf          (Q, Q_buf);
  `else 	// Reserve for non NTC.
    buf          (SDN_i, SDN);
    pullup       (CDN);
    not		(E, EN);
    tsmc_dla	(Q_buf, D, E, CDN, SDN_i, notifier);
    buf          (Q, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  buf  (D_check, SDN_i);
  buf  (EN_check, SDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (EN_DEFCHK, EN_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (D => Q) = (0, 0);
    (negedge EN => (Q+:D)) = (0, 0);
    if (D == 1'b1 && EN == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (D == 1'b0 && EN == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (D == 1'b0 && EN == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    ifnone (SDN => Q) = (0, 0);
    $width (negedge EN, 0, 0, notifier);
    $width (negedge SDN, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, EN_d, D_d);
      $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, EN_d, D_d);
      $recrem (posedge SDN, posedge EN, 0,0, notifier, , , SDN_d, EN_d);
    `else
      $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, EN_d, D_d);
      $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, EN_d, D_d);
      $recovery (posedge SDN, posedge EN, 0, notifier);
      $hold (posedge EN, posedge SDN, 0, notifier);
    `endif
  `else
    $setuphold (posedge EN &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge EN &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $recovery (posedge SDN, posedge EN, 0, notifier);
    $hold (posedge EN, posedge SDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
