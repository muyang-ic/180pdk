// Created by ihdl
`timescale 1ns/1ps

`celldefine

module CKLHQD4BWP7T ( Q, TE, CPN, E , VDD, VSS);
    input TE, CPN, E;
    output Q;
   inout VDD, VSS;
    reg notifier;
    // Dummy Buffer
  `ifdef NTC 	// Reserve for NTC.
    wire TE_d, CPN_d, E_d ;
    buf ( _TE, TE_d );
    buf ( _CPN, CPN_d );
    buf ( _E, E_d );
    or ( _G001, _E, _TE );
    tsmc_dla ( _enl, _G001, _CPN, 1'b1, 1'b1, notifier );
    not ( _enlb, _enl );
    or ( Q, _enlb, _CPN );
  `else 	// Reserve for non NTC.
    buf ( _TE, TE );
    buf ( _CPN, CPN );
    buf ( _E, E );
    or ( _G001, _E, _TE );
    tsmc_dla ( _enl, _G001, _CPN, 1'b1, 1'b1, notifier );
    not ( _enlb, _enl );
    or ( Q, _enlb, _CPN );
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (E_int_not, E_d);
    not  (TE_int_not, TE_d);
  `else
    not  (E_int_not, E);
    not  (TE_int_not, TE);
  `endif
    buf  (E_check, TE_int_not);
  buf  (TE_check, E_int_not);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (TE_DEFCHK, TE_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (E == 1'b1 && TE == 1'b1)
    (CPN => Q) = (0, 0);
    if (E == 1'b1 && TE == 1'b0)
    (CPN => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b1)
    (CPN => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b0)
    (posedge CPN => (Q+:1'b1)) = (0, 0);
    ifnone (CPN => Q) = (0, 0);
    $width (posedge CPN, 0, 0, notifier);
    $width (negedge CPN, 0, 0, notifier);
  `ifdef NTC
    $setuphold (negedge CPN &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CPN_d, E_d);
    $setuphold (negedge CPN &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CPN_d, E_d);
    $setuphold (negedge CPN &&& TE_DEFCHK, posedge TE, 0, 0, notifier,,, CPN_d, TE_d);
    $setuphold (negedge CPN &&& TE_DEFCHK, negedge TE, 0, 0, notifier,,, CPN_d, TE_d);
  `else
    $setuphold (negedge CPN &&& E_DEFCHK, posedge E, 0, 0, notifier);
    $setuphold (negedge CPN &&& E_DEFCHK, negedge E, 0, 0, notifier);
    $setuphold (negedge CPN &&& TE_DEFCHK, posedge TE, 0, 0, notifier);
    $setuphold (negedge CPN &&& TE_DEFCHK, negedge TE, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
