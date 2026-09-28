// Created by ihdl
`timescale 1ns/1ps

`celldefine

module EDFKCNQD1BWP7T (D, E, CP, CN, Q, VDD, VSS);
    input D, E, CP, CN;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, E_d, CP_d, CN_d ;
    pullup   (CDN);
    pullup   (SDN);
    tsmc_mux (D1, Q_buf, D_d, E_d);
    and      (D2, CN_d, D1);
    tsmc_dff (Q_buf, D2, CP_d, CDN, SDN, notifier);
    buf      (Q, Q_buf);
  `else 	// Reserve for non NTC.
    pullup   (CDN);
    pullup   (SDN);
    tsmc_mux (D1, Q_buf, D, E);
    and      (D2, CN, D1);
    tsmc_dff (Q_buf, D2, CP, CDN, SDN, notifier);
    buf      (Q, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (CN_int_not, CN_d);
    buf  (E_check, CN_d);
    and  (D_check, CN_d, E_d);
  `else
    not  (CN_int_not, CN);
    buf  (E_check, CN);
    and  (D_check, CN, E);
  `endif
  or   (CP_check, CN_int_not, D_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((CN && E && D) || (CN && !(E) && Q_buf)))) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP, posedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP, negedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CP_d, E_d);
  `else
    $setuphold (posedge CP, posedge CN, 0, 0, notifier);
    $setuphold (posedge CP, negedge CN, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
