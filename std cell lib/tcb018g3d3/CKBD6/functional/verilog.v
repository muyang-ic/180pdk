// Created by ihdl
`timescale 1ns/10ps

`celldefine

module CKBD6 (I, Z, VDD, VSS);
    input I;
    output Z;
   inout VDD, VSS;
    buf		(Z, I);

  specify
    (I => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine
