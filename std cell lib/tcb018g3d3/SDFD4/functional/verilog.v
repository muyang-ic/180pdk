// Created by ihdl
`timescale 1ns/10ps

`celldefine

module SDFD4 (SI, D, SE, CP, Q, QN, VDD, VSS);
    input SI, D, SE, CP;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire SI_d, D_d, SE_d, CP_d ;
    pullup       (CDN);
    pullup       (SDN);
    tsmc_mux     (D_i, D_d, SI_d, SE_d);
    tsmc_dff     (Q_buf, D_i, CP_d, CDN, SDN, notifier);
    buf          (Q, Q_buf);
    not          (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup       (CDN);
    pullup       (SDN);
    tsmc_mux     (D_i, D, SI, SE);
    tsmc_dff     (Q_buf, D_i, CP, CDN, SDN, notifier);
    buf          (Q, Q_buf);
    not          (QN, Q_buf);
  `endif
  `ifdef NTC
  `else
  `endif
  pullup  (CP_check);
  pullup  (SE_check);



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (SE_int_not, SE_d);
    buf  (SI_check, SE_d);
  `else
    not  (SE_int_not, SE);
    buf  (SI_check, SE);
  `endif
  buf  (D_check, SE_int_not);
  pullup  (CP_check);
  pullup  (SE_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (SE_DEFCHK, SE_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
    tsmc_xbuf (SI_DEFCHK, SI_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((SE && SI) || (!(SE) && D)))) = (0, 0);
    (posedge CP => (QN-:((SE && SI) || (!(SE) && D)))) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& SE_DEFCHK, posedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP &&& SE_DEFCHK, negedge SE, 0, 0, notifier,,, CP_d, SE_d);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier,,, CP_d, SI_d);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier,,, CP_d, SI_d);
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& SE_DEFCHK, posedge SE, 0, 0, notifier);
    $setuphold (posedge CP &&& SE_DEFCHK, negedge SE, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, posedge SI, 0, 0, notifier);
    $setuphold (posedge CP &&& SI_DEFCHK, negedge SI, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
