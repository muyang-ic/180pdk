// Created by ihdl
`timescale 1ns/1ps

`celldefine

module DFNSND0BWP7T (D, CPN, SDN, Q, QN, VDD, VSS);
    input D, CPN, SDN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  SDN_d ;
      buf          (SDN_i, SDN_d);
    `else         	// Reserve for non RECREM. 
      buf          (SDN_i, SDN);
    `endif
    wire D_d, CPN_d ;
    pullup	(CDN);
    not		(CP, CPN_d);
    tsmc_dff	(Q_buf, D_d, CP, CDN, SDN_i, notifier);
    buf          (Q, Q_buf);
    not		(QN, Q_buf);
  `else 	// Reserve for non NTC.
    buf          (SDN_i, SDN);
    pullup	(CDN);
    not		(CP, CPN);
    tsmc_dff	(Q_buf, D, CP, CDN, SDN_i, notifier);
    buf          (Q, Q_buf);
    not		(QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  buf  (CPN_check, SDN_i);
  buf  (D_check, SDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CPN_DEFCHK, CPN_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (negedge CPN => (Q+:D)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    ifnone (negedge SDN => (Q+:1'b1)) = (0, 0);
    (negedge CPN => (QN-:D)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    ifnone (negedge SDN => (QN-:1'b1)) = (0, 0);
    $width (posedge CPN &&& CPN_DEFCHK, 0, 0, notifier);
    $width (negedge CPN &&& CPN_DEFCHK, 0, 0, notifier);
    $width (negedge SDN, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CPN_d, D_d);
      $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CPN_d, D_d);
      $recrem (posedge SDN, negedge CPN, 0,0, notifier, , , SDN_d, CPN_d);
    `else
      $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CPN_d, D_d);
      $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CPN_d, D_d);
      $recovery (posedge SDN, negedge CPN, 0, notifier);
      $hold (negedge CPN, posedge SDN, 0, notifier);
    `endif
  `else
    $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $recovery (posedge SDN, negedge CPN, 0, notifier);
    $hold (negedge CPN, posedge SDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
