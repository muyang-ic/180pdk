// Created by ihdl
`timescale 1ns/1ps

`celldefine

module INVD12BWP7T (I, ZN, VDD, VSS);
    input I;
    output ZN;
   inout VDD, VSS;
    not		(ZN, I);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine
