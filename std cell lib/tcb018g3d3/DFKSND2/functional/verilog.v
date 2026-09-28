// Created by ihdl
`timescale 1ns/10ps

`celldefine

module DFKSND2 (D, CP, SN, Q, QN, VDD, VSS);
    input D, CP, SN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, CP_d, SN_d ;
    pullup   (CDN);
    pullup   (SDN);
    not      (S, SN_d);
    or       (D_i, S, D_d);
    tsmc_dff (Q_buf, D_i, CP_d, CDN, SDN, notifier);
    buf      (Q, Q_buf);
    not      (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup   (CDN);
    pullup   (SDN);
    not      (S, SN);
    or       (D_i, S, D);
    tsmc_dff (Q_buf, D_i, CP, CDN, SDN, notifier);
    buf      (Q, Q_buf);
    not      (QN, Q_buf);
  `endif
  `ifdef NTC
  `else
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    buf  (D_check, SN_d);
  `else
    buf  (D_check, SN);
  `endif
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((D) || (!(D) && !(SN))))) = (0, 0);
    (posedge CP => (QN-:((D) || (!(D) && !(SN))))) = (0, 0);
    $width (posedge CP, 0, 0, notifier);
    $width (negedge CP, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP, posedge SN, 0, 0, notifier,,, CP_d, SN_d);
    $setuphold (posedge CP, negedge SN, 0, 0, notifier,,, CP_d, SN_d);
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP, posedge SN, 0, 0, notifier);
    $setuphold (posedge CP, negedge SN, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
