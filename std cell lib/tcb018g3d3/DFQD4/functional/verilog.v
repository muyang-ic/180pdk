// Created by ihdl
`timescale 1ns/10ps

`celldefine

module DFQD4 (D, CP, Q, VDD, VSS);
    input D, CP;
    output Q;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, CP_d ;
    pullup	 (CDN);
    pullup	 (SDN);
    tsmc_dff (Q_buf, D_d, CP_d, CDN, SDN, notifier);
    buf      (Q, Q_buf);
  `else 	// Reserve for non NTC.
    pullup	 (CDN);
    pullup	 (SDN);
    tsmc_dff (Q_buf, D, CP, CDN, SDN, notifier);
    buf      (Q, Q_buf);
  `endif
  pullup  (CP_check);
  pullup  (D_check);



  // Timing logics defined for default constraint check
  pullup  (CP_check);
  pullup  (D_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (posedge CP => (Q+:D)) = (0, 0);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
  `else
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
