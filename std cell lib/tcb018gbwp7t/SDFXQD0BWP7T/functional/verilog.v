// Created by ihdl
`timescale 1ns/1ps

`celldefine

module SDFXQD0BWP7T (DA, DB, SA, SI, SE, CP, Q, VDD, VSS);
    input DA, DB, SA, SI, SE, CP;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire DA_d, DB_d, SA_d, SI_d, SE_d, CP_d ;
    pullup       (CDN);
    pullup       (SDN);
    tsmc_mux     (D, DB_d, DA_d, SA_d);
    tsmc_mux     (D_i, D, SI_d, SE_d);
    tsmc_dff     (Q_buf, D_i, CP_d, CDN, SDN, notifier);
    buf          (Q, Q_buf);
  `else 	// Reserve for non NTC.
    pullup       (CDN);
    pullup       (SDN);
    tsmc_mux     (D, DB, DA, SA);
    tsmc_mux     (D_i, D, SI, SE);
    tsmc_dff     (Q_buf, D_i, CP, CDN, SDN, notifier);
    buf          (Q, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (SA_int_not, SA_d);
    not  (SE_int_not, SE_d);
    buf  (SI_check, SE_d);
    and  (DA_check, SA_d, SE_int_not);
  `else
    not  (SA_int_not, SA);
    not  (SE_int_not, SE);
    buf  (SI_check, SE);
    and  (DA_check, SA, SE_int_not);
  `endif
  buf  (SA_check, SE_int_not);
  and  (DB_check, SA_int_not, SE_int_not);
  or   (CP_check, SI_check, DA_check, SA_check, DB_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (DB_DEFCHK, DB_check, 1'b1);
    tsmc_xbuf (DA_DEFCHK, DA_check, 1'b1);
    tsmc_xbuf (SA_DEFCHK, SA_check, 1'b1);
    tsmc_xbuf (SI_DEFCHK, SI_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((SE && SI) || (!(SE) && SA && DA) || (!(SE) && !(SA) && DB)))) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& DA_DEFCHK, posedge DA, 0, 0, notifier,,, CP_d, DA_d);
    $setuphold (posedge CP &&& DA_DEFCHK, negedge DA, 0, 0, notifier,,, CP_d, DA_d);
    $setuphold (posedge CP &&& DB_DEFCHK, posedge DB, 0, 0, notifier,,, CP_d, DB_d);
    $setuphold (posedge CP &&& DB_DEFCHK, negedge DB, 0, 0, notifier,,, CP_d, DB_d);
    $setuphold (posedge CP &&& SA_DEFCHK, posedge SA, 0, 0, notifier,,, CP_d, SA_d);
    $setuphold (posedge CP &&& SA_DEFCHK, negedge SA, 0, 0, notifier,,, CP_d, SA_d);
    $setuphold (posedge CP, posedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP, negedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CP_d, SI_d);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CP_d, SI_d);
  `else
    $setuphold (posedge CP &&& DA_DEFCHK, posedge DA, 0, 0, notifier);
    $setuphold (posedge CP &&& DA_DEFCHK, negedge DA, 0, 0, notifier);
    $setuphold (posedge CP &&& DB_DEFCHK, posedge DB, 0, 0, notifier);
    $setuphold (posedge CP &&& DB_DEFCHK, negedge DB, 0, 0, notifier);
    $setuphold (posedge CP &&& SA_DEFCHK, posedge SA, 0, 0, notifier);
    $setuphold (posedge CP &&& SA_DEFCHK, negedge SA, 0, 0, notifier);
    $setuphold (posedge CP, posedge SE, 0, 0, notifier);
    $setuphold (posedge CP, negedge SE, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
