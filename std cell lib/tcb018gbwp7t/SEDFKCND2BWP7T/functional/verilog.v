// Created by ihdl
`timescale 1ns/1ps

`celldefine

module SEDFKCND2BWP7T (SI, D, E, SE, CP, CN, Q, QN, VDD, VSS);
    input SI, D, SE, CP, CN, E;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire SI_d, D_d, SE_d, CP_d, CN_d, E_d ;
    pullup (CDN);
    pullup (SDN);
    tsmc_mux (D1, Q_buf, D_d, E_d);
    and (D2, CN_d, D1);
    tsmc_mux (D3, D2, SI_d, SE_d);
    tsmc_dff (Q_buf, D3, CP_d, CDN, SDN, notifier);
    buf (Q, Q_buf);
    not (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup (CDN);
    pullup (SDN);
    tsmc_mux (D1, Q_buf, D, E);
    and (D2, CN, D1);
    tsmc_mux (D3, D2, SI, SE);
    tsmc_dff (Q_buf, D3, CP, CDN, SDN, notifier);
    buf (Q, Q_buf);
    not (QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (E_int_not, E_d);
    not  (SE_int_not, SE_d);
    and  (D_check, E_d, CN_d, SE_int_not);
    and  (E_check, CN_d, SE_int_not);
    buf  (SI_check, SE_d);
  `else
    not  (E_int_not, E);
    not  (SE_int_not, SE);
    and  (D_check, E, CN, SE_int_not);
    and  (E_check, CN, SE_int_not);
    buf  (SI_check, SE);
  `endif
  buf  (CN_check, SE_int_not);
  or   (CP_check, D_check, E_check, CN_check, SI_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (CN_DEFCHK, CN_check, 1'b1);
    tsmc_xbuf (SI_DEFCHK, SI_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((SE && SI) || (!(SE) && CN && E && D) || (!(SE) && CN && !(E) && Q_buf)))) = (0, 0);
    (posedge CP => (QN-:((SE && SI) || (!(SE) && CN && E && D) || (!(SE) && CN && !(E) && Q_buf)))) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& CN_DEFCHK, posedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP &&& CN_DEFCHK, negedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP, posedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP, negedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CP_d, SI_d);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CP_d, SI_d);
  `else
    $setuphold (posedge CP &&& CN_DEFCHK, posedge CN, 0, 0, notifier);
    $setuphold (posedge CP &&& CN_DEFCHK, negedge CN, 0, 0, notifier);
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
