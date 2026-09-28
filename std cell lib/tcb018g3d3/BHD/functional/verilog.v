// Created by ihdl
`timescale 1ns/10ps

`celldefine

module BHD (Z, VDD, VSS);
   inout Z;
   inout VDD, VSS;
   not(weak0,weak1) (Z, Z_buf);
   not              (Z_buf, Z);

endmodule

`endcelldefine
