// Created by ihdl
`timescale 1ns/1ps

`celldefine

module LHSNQD1BWP7T (D, E, SDN, Q, VDD, VSS);
    input D, E, SDN;
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
    wire D_d, E_d ;
    pullup	(CDN);
    tsmc_dla	(Q_buf, D_d, E_d, CDN, SDN_i, notifier);
    buf         (Q, Q_buf);
  `else 	// Reserve for non NTC.
    buf          (SDN_i, SDN);
    pullup	(CDN);
    tsmc_dla	(Q_buf, D, E, CDN, SDN_i, notifier);
    buf         (Q, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  buf  (D_check, SDN_i);
  buf  (E_check, SDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (D => Q) = (0, 0);
    (posedge E => (Q+:D)) = (0, 0);
    if (D == 1'b1 && E == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (D == 1'b0 && E == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (D == 1'b0 && E == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    ifnone (SDN => Q) = (0, 0);
    $width (posedge E, 0, 0, notifier);
    $width (negedge SDN, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (negedge E &&& D_DEFCHK, posedge D, 0, 0, notifier,,, E_d, D_d);
      $setuphold (negedge E &&& D_DEFCHK, negedge D, 0, 0, notifier,,, E_d, D_d);
      $recrem (posedge SDN, negedge E, 0,0, notifier, , , SDN_d, E_d);
    `else
      $setuphold (negedge E &&& D_DEFCHK, posedge D, 0, 0, notifier,,, E_d, D_d);
      $setuphold (negedge E &&& D_DEFCHK, negedge D, 0, 0, notifier,,, E_d, D_d);
      $recovery (posedge SDN, negedge E, 0, notifier);
      $hold (negedge E, posedge SDN, 0, notifier);
    `endif
  `else
    $setuphold (negedge E &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (negedge E &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $recovery (posedge SDN, negedge E, 0, notifier);
    $hold (negedge E, posedge SDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
