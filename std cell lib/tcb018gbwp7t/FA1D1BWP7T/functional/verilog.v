// Created by ihdl
`timescale 1ns/1ps

`celldefine

module FA1D1BWP7T (A, B, CI, S, CO, VDD, VSS);
  input		A, B, CI;
  output	S, CO;
   inout VDD, VSS;
  xor		(S, A, B, CI);
  and		(n2, A, B);
  and		(n3, A, CI);
  and		(n4, B, CI);
  or		(CO, n2, n3, n4);

  specify
    if (B == 1'b1 && CI == 1'b0)
    (A => CO) = (0, 0);
    if (B == 1'b0 && CI == 1'b1)
    (A => CO) = (0, 0);
    ifnone (A => CO) = (0, 0);
    if (A == 1'b1 && CI == 1'b0)
    (B => CO) = (0, 0);
    if (A == 1'b0 && CI == 1'b1)
    (B => CO) = (0, 0);
    ifnone (B => CO) = (0, 0);
    if (A == 1'b1 && B == 1'b0)
    (CI => CO) = (0, 0);
    if (A == 1'b0 && B == 1'b1)
    (CI => CO) = (0, 0);
    ifnone (CI => CO) = (0, 0);
    if (B == 1'b1 && CI == 1'b1)
    (A => S) = (0, 0);
    if (B == 1'b0 && CI == 1'b0)
    (A => S) = (0, 0);
    if (B == 1'b1 && CI == 1'b0)
    (A => S) = (0, 0);
    if (B == 1'b0 && CI == 1'b1)
    (A => S) = (0, 0);
    ifnone (A => S) = (0, 0);
    if (A == 1'b1 && CI == 1'b1)
    (B => S) = (0, 0);
    if (A == 1'b0 && CI == 1'b0)
    (B => S) = (0, 0);
    if (A == 1'b1 && CI == 1'b0)
    (B => S) = (0, 0);
    if (A == 1'b0 && CI == 1'b1)
    (B => S) = (0, 0);
    ifnone (B => S) = (0, 0);
    if (A == 1'b1 && B == 1'b1)
    (CI => S) = (0, 0);
    if (A == 1'b0 && B == 1'b0)
    (CI => S) = (0, 0);
    if (A == 1'b1 && B == 1'b0)
    (CI => S) = (0, 0);
    if (A == 1'b0 && B == 1'b1)
    (CI => S) = (0, 0);
    ifnone (CI => S) = (0, 0);
  endspecify
endmodule

`endcelldefine
