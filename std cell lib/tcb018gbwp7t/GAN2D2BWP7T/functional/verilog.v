// Created by ihdl
`timescale 1ns/1ps

`celldefine

module GAN2D2BWP7T (A1, A2, Z, VDD, VSS);
    input A1, A2;
    output Z;
   inout VDD, VSS;
    and		(Z, A1, A2);

  specify
    (A1 => Z) = (0, 0);
    (A2 => Z) = (0, 0);
  endspecify
endmodule

`endcelldefine
