// Created by ihdl
`timescale 1ns/10ps

`celldefine

module XNR2D2 (A1, A2, ZN, VDD, VSS);
  input		A1, A2;
  output 	ZN;
   inout VDD, VSS;
  xnor		(ZN, A1, A2);

  specify
    if (A2 == 1'b1)
    (A1 => ZN) = (0, 0);
    if (A2 == 1'b0)
    (A1 => ZN) = (0, 0);
    ifnone (A1 => ZN) = (0, 0);
    if (A1 == 1'b1)
    (A2 => ZN) = (0, 0);
    if (A1 == 1'b0)
    (A2 => ZN) = (0, 0);
    ifnone (A2 => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine
