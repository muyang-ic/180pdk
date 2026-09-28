// Created by ihdl
`timescale 1ns/1ps

`celldefine

module CKLNQD8BWP7T (TE, E, CP, Q, VDD, VSS);
    input TE, E, CP;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire TE_d, E_d, CP_d ;
    pullup	(CDN);
    pullup	(SDN);
    or		(D_i, E_d, TE_d);
    not		(CPB, CP_d);
    tsmc_dla 	(Q_buf, D_i, CPB, CDN, SDN, notifier);
    and         (Q, Q_buf, CP_d);
  `else 	// Reserve for non NTC.
    pullup	(CDN);
    pullup	(SDN);
    or		(D_i, E, TE);
    not		(CPB, CP);
    tsmc_dla 	(Q_buf, D_i, CPB, CDN, SDN, notifier);
    and         (Q, Q_buf, CP);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (E_int_not, E_d);
    not  (TE_int_not, TE_d);
  `else
    not  (E_int_not, E);
    not  (TE_int_not, TE);
  `endif
    buf  (E_check, TE_int_not);
  buf  (TE_check, E_int_not);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (TE_DEFCHK, TE_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (E == 1'b1 && TE == 1'b1)
    (CP => Q) = (0, 0);
    if (E == 1'b1 && TE == 1'b0)
    (CP => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b1)
    (CP => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b0)
    (negedge CP => (Q+:1'b0)) = (0, 0);
    ifnone (CP => Q) = (0, 0);
    $width (posedge CP, 0, 0, notifier);
    $width (negedge CP, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& TE_DEFCHK, posedge TE, 0, 0, notifier,,, CP_d, TE_d);
    $setuphold (posedge CP &&& TE_DEFCHK, negedge TE, 0, 0, notifier,,, CP_d, TE_d);
  `else
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier);
    $setuphold (posedge CP &&& TE_DEFCHK, posedge TE, 0, 0, notifier);
    $setuphold (posedge CP &&& TE_DEFCHK, negedge TE, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
