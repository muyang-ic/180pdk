// Created by ihdl
`timescale 1ns/1ps

`celldefine

module DFXD0BWP7T (DA, DB, SA, CP, Q, QN, VDD, VSS);
    input DA, DB, SA, CP;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire DA_d, DB_d, SA_d, CP_d ;
    pullup       (CDN);
    pullup       (SDN);
    tsmc_mux     (D, DB_d, DA_d, SA_d);
    tsmc_dff     (Q_buf, D, CP_d, CDN, SDN, notifier);
    buf          (Q, Q_buf);
    not          (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup       (CDN);
    pullup       (SDN);
    tsmc_mux     (D, DB, DA, SA);
    tsmc_dff     (Q_buf, D, CP, CDN, SDN, notifier);
    buf          (Q, Q_buf);
    not          (QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (SA_int_not, SA_d);
    buf  (DA_check, SA_d);
  `else
    not  (SA_int_not, SA);
    buf  (DA_check, SA);
  `endif
  buf  (DB_check, SA_int_not);
  pullup  (CP_check);
  pullup  (SA_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (SA_DEFCHK, SA_check, 1'b1);
    tsmc_xbuf (DB_DEFCHK, DB_check, 1'b1);
    tsmc_xbuf (DA_DEFCHK, DA_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((DA && DB) || (DA && !(DB) && SA) || (!(DA) && DB && !(SA))))) = (0, 0);
    (posedge CP => (QN-:((DA && DB) || (DA && !(DB) && SA) || (!(DA) && DB && !(SA))))) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& DA_DEFCHK, posedge DA, 0, 0, notifier,,, CP_d, DA_d);
    $setuphold (posedge CP &&& DA_DEFCHK, negedge DA, 0, 0, notifier,,, CP_d, DA_d);
    $setuphold (posedge CP &&& DB_DEFCHK, posedge DB, 0, 0, notifier,,, CP_d, DB_d);
    $setuphold (posedge CP &&& DB_DEFCHK, negedge DB, 0, 0, notifier,,, CP_d, DB_d);
    $setuphold (posedge CP &&& SA_DEFCHK, posedge SA, 0, 0, notifier,,, CP_d, SA_d);
    $setuphold (posedge CP &&& SA_DEFCHK, negedge SA, 0, 0, notifier,,, CP_d, SA_d);
  `else
    $setuphold (posedge CP &&& DA_DEFCHK, posedge DA, 0, 0, notifier);
    $setuphold (posedge CP &&& DA_DEFCHK, negedge DA, 0, 0, notifier);
    $setuphold (posedge CP &&& DB_DEFCHK, posedge DB, 0, 0, notifier);
    $setuphold (posedge CP &&& DB_DEFCHK, negedge DB, 0, 0, notifier);
    $setuphold (posedge CP &&& SA_DEFCHK, posedge SA, 0, 0, notifier);
    $setuphold (posedge CP &&& SA_DEFCHK, negedge SA, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
