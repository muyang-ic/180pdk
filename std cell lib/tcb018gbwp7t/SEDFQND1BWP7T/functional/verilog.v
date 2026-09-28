// Created by ihdl
`timescale 1ns/1ps

`celldefine

module SEDFQND1BWP7T (E, SE, CP, SI, D, QN, VDD, VSS);
    input E, SE, CP, SI, D; 
    output QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire E_d, SE_d, CP_d, SI_d, D_d ;
    pullup   (CDN);
    pullup   (SDN);
    tsmc_mux (D1, Q_buf, D_d, E_d);
    tsmc_mux (D2, D1, SI_d, SE_d);
    tsmc_dff (Q_buf, D2, CP_d, CDN, SDN, notifier);
    not      (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup   (CDN);
    pullup   (SDN);
    tsmc_mux (D1, Q_buf, D, E);
    tsmc_mux (D2, D1, SI, SE);
    tsmc_dff (Q_buf, D2, CP, CDN, SDN, notifier);
    not      (QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (E_int_not, E_d);
    not  (SE_int_not, SE_d);
    buf  (SI_check, SE_d);
    and  (D_check, E_d, SE_int_not);
  `else
    not  (E_int_not, E);
    not  (SE_int_not, SE);
    buf  (SI_check, SE);
    and  (D_check, E, SE_int_not);
  `endif
  buf  (E_check, SE_int_not);
  or   (CP_check, D_check, E_check, SI_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (SI_DEFCHK, SI_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (QN-:((SE && SI) || (!(SE) && E && D) || (!(SE) && !(E) && Q_buf)))) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP, posedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP, negedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CP_d, SI_d);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CP_d, SI_d);
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier);
    $setuphold (posedge CP, posedge SE, 0, 0, notifier);
    $setuphold (posedge CP, negedge SE, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
