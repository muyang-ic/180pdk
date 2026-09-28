// Created by ihdl
`timescale 1ns/1ps

`celldefine

module IOA21D1BWP7T (A1, A2, B, ZN, VDD, VSS);
    input A1, A2, B;
    output ZN;
   inout VDD, VSS;
    not          (A1N,A1);
    not          (A2N,A2);
    or           (A,A1N,A2N);
    nand         (ZN,A,B);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
    if (A1 == 1'b1 && A2 == 1'b0)
    (B => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b1)
    (B => ZN) = (0, 0);
    if (A1 == 1'b0 && A2 == 1'b0)
    (B => ZN) = (0, 0);
    ifnone (B => ZN) = (0, 0);
  endspecify
endmodule

`endcelldefine
