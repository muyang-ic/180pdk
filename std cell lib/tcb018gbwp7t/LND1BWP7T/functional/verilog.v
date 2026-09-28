// Created by ihdl
`timescale 1ns/1ps

`celldefine

module LND1BWP7T (D, EN, Q, QN, VDD, VSS);
    input D, EN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, EN_d ;
    pullup	 (CDN);
    pullup	 (SDN);
    not		 (E, EN_d);
    tsmc_dla (Q_buf, D_d, E, CDN, SDN, notifier);
    buf      (Q, Q_buf);
    not		 (QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup	 (CDN);
    pullup	 (SDN);
    not		 (E, EN);
    tsmc_dla (Q_buf, D, E, CDN, SDN, notifier);
    buf      (Q, Q_buf);
    not		 (QN, Q_buf);
  `endif



  specify
    (D => Q) = (0, 0);
    (negedge EN => (Q+:D)) = (0, 0);
    (D => QN) = (0, 0);
    (negedge EN => (QN-:D)) = (0, 0);
    $width (negedge EN, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge EN, posedge D, 0, 0, notifier,,, EN_d, D_d);
    $setuphold (posedge EN, negedge D, 0, 0, notifier,,, EN_d, D_d);
  `else
    $setuphold (posedge EN, posedge D, 0, 0, notifier);
    $setuphold (posedge EN, negedge D, 0, 0, notifier);
  `endif
  endspecify
endmodule

`endcelldefine
