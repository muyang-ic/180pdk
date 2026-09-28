// Created by ihdl
`timescale 1ns/10ps

`celldefine

module DFKCSND1 (D, CP, CN, SN, Q, QN, VDD, VSS);
    input D, CP, CN, SN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, CP_d, CN_d, SN_d ;
    pullup   (CDN); 
    pullup   (SDN);
    not      (S, SN_d);
    or       (DS, S, D_d);   
    and      (D_i, CN_d, DS);
    tsmc_dff (Q_buf, D_i, CP_d, CDN, SDN, notifier);  
    buf      (Q, Q_buf);        
    not      (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup   (CDN); 
    pullup   (SDN);
    not      (S, SN);
    or       (DS, S, D);   
    and      (D_i, CN, DS);
    tsmc_dff (Q_buf, D_i, CP, CDN, SDN, notifier);  
    buf      (Q, Q_buf);        
    not      (QN, Q_buf);
  `endif
  `ifdef NTC
  `else
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    buf  (SN_check, CN_d);
    and  (D_check, SN_d, CN_d);
  `else
    buf  (SN_check, CN);
    and  (D_check, SN, CN);
  `endif
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (SN_DEFCHK, SN_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((CN && D) || (CN && !(D) && !(SN))))) = (0, 0);
    (posedge CP => (QN-:((CN && D) || (CN && !(D) && !(SN))))) = (0, 0);
    $width (posedge CP, 0, 0, notifier);
    $width (negedge CP, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP, posedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP, negedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& SN_DEFCHK, posedge SN, 0, 0, notifier,,, CP_d, SN_d);
    $setuphold (posedge CP &&& SN_DEFCHK, negedge SN, 0, 0, notifier,,, CP_d, SN_d);
  `else
    $setuphold (posedge CP, posedge CN, 0, 0, notifier);
    $setuphold (posedge CP, negedge CN, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& SN_DEFCHK, posedge SN, 0, 0, notifier);
    $setuphold (posedge CP &&& SN_DEFCHK, negedge SN, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
