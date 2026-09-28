// Created by ihdl
`timescale 1ns/10ps

`celldefine

module DFKCNQD2 (D, CP, CN, Q, VDD, VSS);
    input D, CP, CN;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, CP_d, CN_d ;
    pullup   (CDN); 
    pullup   (SDN);     
    and      (D_i, CN_d, D_d);
    tsmc_dff (Q_buf, D_i, CP_d, CDN, SDN, notifier);  
    buf      (Q, Q_buf);        
  `else 	// Reserve for non NTC.
    pullup   (CDN); 
    pullup   (SDN);     
    and      (D_i, CN, D);
    tsmc_dff (Q_buf, D_i, CP, CDN, SDN, notifier);  
    buf      (Q, Q_buf);        
  `endif
  `ifdef NTC
  `else
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    buf  (D_check, CN_d);
  `else
    buf  (D_check, CN);
  `endif
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:((CN && D)))) = (0, 0);
    $width (posedge CP, 0, 0, notifier);
    $width (negedge CP, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP, posedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP, negedge CN, 0, 0, notifier,,, CP_d, CN_d);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
  `else
    $setuphold (posedge CP, posedge CN, 0, 0, notifier);
    $setuphold (posedge CP, negedge CN, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
