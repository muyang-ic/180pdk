// Created by ihdl
`timescale 1ns/1ps

`celldefine

module SDFND1BWP7T (SI, D, SE, CPN, Q, QN, VDD, VSS);
    input SI, D, SE, CPN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire SI_d, D_d, SE_d, CPN_d ;
    pullup       (CDN);
    pullup       (SDN);
    tsmc_mux     (D_i, D_d, SI_d, SE_d);
    not		 (CP, CPN_d);
    tsmc_dff     (Q_buf, D_i, CP, CDN, SDN, notifier);
    buf          (Q, Q_buf);
    not          (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup       (CDN);
    pullup       (SDN);
    tsmc_mux     (D_i, D, SI, SE);
    not		 (CP, CPN);
    tsmc_dff     (Q_buf, D_i, CP, CDN, SDN, notifier);
    buf          (Q, Q_buf);
    not          (QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (SE_int_not, SE_d);
    buf  (SI_check, SE_d);
  `else
    not  (SE_int_not, SE);
    buf  (SI_check, SE);
  `endif
  buf  (D_check, SE_int_not);
  pullup  (CPN_check);
  pullup  (SE_check);
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
    (negedge CPN => (Q+:((SE && SI) || (!(SE) && D)))) = (0, 0);
    (negedge CPN => (QN-:((SE && SI) || (!(SE) && D)))) = (0, 0);
    $width (posedge CPN &&& CPN_DEFCHK, 0, 0, notifier);
    $width (negedge CPN &&& CPN_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CPN_d, D_d);
    $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CPN_d, D_d);
    $setuphold (negedge CPN &&& SE_DEFCHK, posedge SE, 0, 0, notifier,,, CPN_d, SE_d);
    $setuphold (negedge CPN &&& SE_DEFCHK, negedge SE, 0, 0, notifier,,, CPN_d, SE_d);
    $setuphold (negedge CPN &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CPN_d, SI_d);
    $setuphold (negedge CPN &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CPN_d, SI_d);
  `else
    $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (negedge CPN &&& SE_DEFCHK, posedge SE, 0, 0, notifier);
    $setuphold (negedge CPN &&& SE_DEFCHK, negedge SE, 0, 0, notifier);
    $setuphold (negedge CPN &&& SI_DEFCHK, posedge SI, 0, 0, notifier);
    $setuphold (negedge CPN &&& SI_DEFCHK, negedge SI, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
