// Created by ihdl
`timescale 1ns/1ps

`celldefine

module DFND0BWP7T (D, CPN, Q, QN, VDD, VSS);
    input D, CPN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire D_d, CPN_d ;
    pullup	(CDN);
    pullup      (SDN);
    not		(CP, CPN_d);
    tsmc_dff	(Q_buf, D_d, CP, CDN, SDN, notifier);
    buf         (Q, Q_buf);
    not		(QN, Q_buf);
  `else 	// Reserve for non NTC.
    pullup	(CDN);
    pullup      (SDN);
    not		(CP, CPN);
    tsmc_dff	(Q_buf, D, CP, CDN, SDN, notifier);
    buf         (Q, Q_buf);
    not		(QN, Q_buf);
  `endif



  // Timing logics defined for default constraint check
  pullup  (CPN_check);
  pullup  (D_check);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CPN_DEFCHK, CPN_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    (negedge CPN => (Q+:D)) = (0, 0);
    (negedge CPN => (QN-:D)) = (0, 0);
    $width (posedge CPN &&& CPN_DEFCHK, 0, 0, notifier);
    $width (negedge CPN &&& CPN_DEFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CPN_d, D_d);
    $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CPN_d, D_d);
  `else
    $setuphold (negedge CPN &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (negedge CPN &&& D_DEFCHK, negedge D, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
