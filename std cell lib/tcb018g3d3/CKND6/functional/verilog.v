// Created by ihdl
`timescale 1ns/10ps

`celldefine

module CKND6 (I, ZN, VDD, VSS);
    input I;
    output ZN;
   inout VDD, VSS;
    not		(ZN, I);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine
