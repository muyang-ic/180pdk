// Created by ihdl
`timescale 1ns/1ps

`celldefine

module EDFCNQD2BWP7T (D, E, CP, CDN, Q, VDD, VSS);
    input D, E, CP, CDN;  
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  CDN_d ;
      buf      (CDN_i, CDN_d);
    `else         	// Reserve for non RECREM. 
      buf      (CDN_i, CDN);
    `endif
    wire D_d, E_d, CP_d ;
    pullup   (SDN);
    tsmc_mux (DE, Q_buf, D_d, E_d);
    tsmc_dff (Q_buf, DE, CP_d, CDN_i, SDN, notifier);
    buf      (Q, Q_buf);
  `else 	// Reserve for non NTC.
    pullup   (SDN);
    buf      (CDN_i, CDN);
    tsmc_mux (DE, Q_buf, D, E);
    tsmc_dff (Q_buf, DE, CP, CDN_i, SDN, notifier);
    buf      (Q, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (E_int_not, E_d);
    and  (D_check, CDN_i, E_d);
  `else
    not  (E_int_not, E);
    and  (D_check, CDN_i, E);
  `endif
  and  (CP_check, CDN_i, D_check);
  buf  (E_check, CDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (CP == 1'b1 && D == 1'b1 && E == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0 && E == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b1 && E == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0 && E == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1 && E == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0 && E == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1 && E == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0 && E == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    ifnone (negedge CDN => (Q+:1'b0)) = (0, 0);
    (posedge CP => (Q+:((E && D) || (!(E) && Q_buf)))) = (0, 0);
    $width (negedge CDN, 0, 0, notifier);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CP_d, E_d);
      $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CP_d, E_d);
      $recrem (posedge CDN, posedge CP, 0,0, notifier, , , CDN_d, CP_d);
    `else
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CP_d, E_d);
      $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CP_d, E_d);
      $recovery (posedge CDN, posedge CP, 0, notifier);
      $hold (posedge CP, posedge CDN, 0, notifier);
    `endif
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier);
    $recovery (posedge CDN, posedge CP, 0, notifier);
    $hold (posedge CP, posedge CDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
