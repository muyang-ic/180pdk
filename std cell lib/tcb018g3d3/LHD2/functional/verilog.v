// Created by ihdl
`timescale 1ns/10ps

`celldefine

module LHD2 (D, E, Q, QN, VDD, VSS);
    input D, E;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, E_d ;
    pullup	 (CDN);
    pullup	 (SDN);
    tsmc_dla (Q_buf, D_d, E_d, CDN, SDN, notifier);
    buf      (Q, Q_buf);
    not		 (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup	 (CDN);
    pullup	 (SDN);
    tsmc_dla (Q_buf, D, E, CDN, SDN, notifier);
    buf      (Q, Q_buf);
    not		 (QN, Q_buf);
  `endif



  specify
    (D => Q) = (0, 0);
    (posedge E => (Q+:D)) = (0, 0);
    (D => QN) = (0, 0);
    (posedge E => (QN-:D)) = (0, 0);
    $width (posedge E, 0, 0, notifier);
  `ifdef NTC
    $setuphold (negedge E, posedge D, 0, 0, notifier,,, E_d, D_d);
    $setuphold (negedge E, negedge D, 0, 0, notifier,,, E_d, D_d);
  `else
    $setuphold (negedge E, posedge D, 0, 0, notifier);
    $setuphold (negedge E, negedge D, 0, 0, notifier);
  `endif
  endspecify
endmodule

`endcelldefine
