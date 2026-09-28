// Created by ihdl
`timescale 1ns/1ps

`celldefine

module EDFD0BWP7T (D, E, CP, Q, QN, VDD, VSS);
    input D, E, CP;  
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, E_d, CP_d ;
    pullup   (CDN);
    pullup   (SDN);
    tsmc_mux (DE, Q_buf, D_d, E_d);
    tsmc_dff (Q_buf, DE, CP_d, CDN, SDN, notifier);
    buf      (Q, Q_buf);
    not      (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup   (CDN);
    pullup   (SDN);
    tsmc_mux (DE, Q_buf, D, E);
    tsmc_dff (Q_buf, DE, CP, CDN, SDN, notifier);
    buf      (Q, Q_buf);
    not      (QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (E_int_not, E_d);
    buf  (D_check, E_d);
  `else
    not  (E_int_not, E);
    buf  (D_check, E);
  `endif
  buf  (CP_check, D_check);
  pullup  (E_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((E && D) || (!(E) && Q_buf)))) = (0, 0);
    (posedge CP => (QN-:((E && D) || (!(E) && Q_buf)))) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CP_d, E_d);
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
