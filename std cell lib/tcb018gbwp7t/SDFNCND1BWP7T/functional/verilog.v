// Created by ihdl
`timescale 1ns/1ps

`celldefine

module SDFNCND1BWP7T (SI, D, SE, CPN, CDN, Q, QN, VDD, VSS);
    input SI, D, SE, CPN, CDN;
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
    wire SI_d, D_d, SE_d, CPN_d ;
    pullup   (SDN);
    tsmc_mux (D_i, D_d, SI_d, SE_d);
    not      (CP, CPN_d);
    tsmc_dff (Q_buf, D_i, CP, CDN_i, SDN, notifier);
    buf      (Q, Q_buf);
    not      (QN, Q_buf);
  `else 	// Reserve for non NTC.
    buf      (CDN_i, CDN);
    pullup   (SDN);
    tsmc_mux (D_i, D, SI, SE);
    not      (CP, CPN);
    tsmc_dff (Q_buf, D_i, CP, CDN_i, SDN, notifier);
    buf      (Q, Q_buf);
    not      (QN, Q_buf);
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
  buf  (CPN_check, CDN_i);
  buf  (SE_check, CDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CPN_DEFCHK, CPN_check, 1'b1);
    tsmc_xbuf (SE_DEFCHK, SE_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (SI_DEFCHK, SI_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (CPN == 1'b1 && D == 1'b1 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    ifnone (negedge CDN => (Q+:1'b0)) = (0, 0);
    (negedge CPN => (Q+:((SE && SI) || (!(SE) && D)))) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b1 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0 && SE == 1'b1 && SI == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0 && SE == 1'b1 && SI == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0 && SE == 1'b0 && SI == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0 && SE == 1'b0 && SI == 1'b0)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    ifnone (negedge CDN => (QN-:1'b0)) = (0, 0);
    (negedge CPN => (QN-:((SE && SI) || (!(SE) && D)))) = (0, 0);
    $width (negedge CDN, 0, 0, notifier);
    $width (posedge CPN &&& CPN_DEFCHK, 0, 0, notifier);
    $width (negedge CPN &&& CPN_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CPN_d, D_d);
      $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CPN_d, D_d);
      $setuphold (negedge CPN &&& SE_DEFCHK, posedge SE, 0, 0, notifier,,, CPN_d, SE_d);
      $setuphold (negedge CPN &&& SE_DEFCHK, negedge SE, 0, 0, notifier,,, CPN_d, SE_d);
      $setuphold (negedge CPN &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CPN_d, SI_d);
      $setuphold (negedge CPN &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CPN_d, SI_d);
      $recrem (posedge CDN, negedge CPN, 0,0, notifier, , , CDN_d, CPN_d);
    `else
      $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CPN_d, D_d);
      $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CPN_d, D_d);
      $setuphold (negedge CPN &&& SE_DEFCHK, posedge SE, 0, 0, notifier,,, CPN_d, SE_d);
      $setuphold (negedge CPN &&& SE_DEFCHK, negedge SE, 0, 0, notifier,,, CPN_d, SE_d);
      $setuphold (negedge CPN &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CPN_d, SI_d);
      $setuphold (negedge CPN &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CPN_d, SI_d);
      $recovery (posedge CDN, negedge CPN, 0, notifier);
      $hold (negedge CPN, posedge CDN, 0, notifier);
    `endif
  `else
    $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (negedge CPN &&& SE_DEFCHK, posedge SE, 0, 0, notifier);
    $setuphold (negedge CPN &&& SE_DEFCHK, negedge SE, 0, 0, notifier);
    $setuphold (negedge CPN &&& SI_DEFCHK, posedge SI, 0, 0, notifier);
    $setuphold (negedge CPN &&& SI_DEFCHK, negedge SI, 0, 0, notifier);
    $recovery (posedge CDN, negedge CPN, 0, notifier);
    $hold (negedge CPN, posedge CDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
