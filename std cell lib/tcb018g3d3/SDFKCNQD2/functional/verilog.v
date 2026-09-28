// Created by ihdl
`timescale 1ns/10ps

`celldefine

module SDFKCNQD2 (SI, D, SE, CP, CN, Q, VDD, VSS);
    input SI, D, SE, CP, CN;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire SI_d, D_d, SE_d, CP_d, CN_d ;
    pullup (CDN);
    pullup (SDN);
    and (D1, CN_d, D_d);
    tsmc_mux (D2, D1, SI_d, SE_d);
    tsmc_dff (Q_buf, D2, CP_d, CDN, SDN, notifier);
    buf (Q, Q_buf);
  `else 	// Reserve for non NTC.
    pullup (CDN);
    pullup (SDN);
    and (D1, CN, D);
    tsmc_mux (D2, D1, SI, SE);
    tsmc_dff (Q_buf, D2, CP, CDN, SDN, notifier);
    buf (Q, Q_buf);
  `endif
  `ifdef NTC
  `else
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (SE_int_not, SE_d);
    buf  (SI_check, SE_d);
    and  (D_check, SE_int_not, CN_d);
  `else
    not  (SE_int_not, SE);
    buf  (SI_check, SE);
    and  (D_check, SE_int_not, CN);
  `endif
  buf  (CN_check, SE_int_not);
   `ifdef TETRAMAX
  `else
    tsmc_xbuf (SI_DEFCHK, SI_check, 1'b1);
    tsmc_xbuf (CN_DEFCHK, CN_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((SE && SI) || (!(SE) && D && CN)))) = (0, 0);
    $width (posedge CP, 0, 0, notifier);
    $width (negedge CP, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& CN_DEFCHK, posedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP &&& CN_DEFCHK, negedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP, posedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP, negedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CP_d, SI_d);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CP_d, SI_d);
  `else
    $setuphold (posedge CP &&& CN_DEFCHK, posedge CN, 0, 0, notifier);
    $setuphold (posedge CP &&& CN_DEFCHK, negedge CN, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP, posedge SE, 0, 0, notifier);
    $setuphold (posedge CP, negedge SE, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
