// Created by ihdl
`timescale 1ns/10ps

`celldefine

module SDFCNQD4 (SI, D, SE, CP, CDN, Q, VDD, VSS);
    input SI, D, SE, CP, CDN;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  CDN_d ;
      buf          (CDN_i, CDN_d);
    `else         	// Reserve for non RECREM. 
      buf          (CDN_i, CDN);
    `endif
    wire SI_d, D_d, SE_d, CP_d ;
    pullup       (SDN);
    tsmc_mux     (D_i, D_d, SI_d, SE_d);
    tsmc_dff     (Q_buf, D_i, CP_d, CDN_i, SDN, notifier);
    buf          (Q, Q_buf);
  `else 	// Reserve for non NTC.
    buf          (CDN_i, CDN);
    pullup       (SDN);
    tsmc_mux     (D_i, D, SI, SE);
    tsmc_dff     (Q_buf, D_i, CP, CDN_i, SDN, notifier);
    buf          (Q, Q_buf);
  `endif
  `ifdef NTC
  `else
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (SE_int_not, SE_d);
    and  (SI_check, CDN_i, SE_d);
  `else
    not  (SE_int_not, SE);
    and  (SI_check, CDN_i, SE);
  `endif
  and  (D_check, CDN_i, SE_int_not);
  buf  (CP_check, CDN_i);
  buf  (SE_check, CDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (SE_DEFCHK, SE_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (SI_DEFCHK, SI_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (CP == 1'b1 && D == 1'b1 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b1 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b1 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b1 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    ifnone (negedge CDN => (Q+:1'b0)) = (0, 0);
    (posedge CP => (Q+:((SE && SI) || (!(SE) && D)))) = (0, 0);
    $width (negedge CDN, 0, 0, notifier);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& SE_DEFCHK, posedge SE, 0, 0, notifier,,, CP_d, SE_d);
      $setuphold (posedge CP &&& SE_DEFCHK, negedge SE, 0, 0, notifier,,, CP_d, SE_d);
      $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CP_d, SI_d);
      $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CP_d, SI_d);
      $recrem (posedge CDN, posedge CP, 0,0, notifier, , , CDN_d, CP_d);
    `else
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& SE_DEFCHK, posedge SE, 0, 0, notifier,,, CP_d, SE_d);
      $setuphold (posedge CP &&& SE_DEFCHK, negedge SE, 0, 0, notifier,,, CP_d, SE_d);
      $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CP_d, SI_d);
      $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CP_d, SI_d);
      $recovery (posedge CDN, posedge CP, 0, notifier);
      $hold (posedge CP, posedge CDN, 0, notifier);
    `endif
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& SE_DEFCHK, posedge SE, 0, 0, notifier);
    $setuphold (posedge CP &&& SE_DEFCHK, negedge SE, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier);
    $recovery (posedge CDN, posedge CP, 0, notifier);
    $hold (posedge CP, posedge CDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
