// Created by ihdl
`timescale 1ns/10ps

`celldefine

module PCLAMP (VDDESD,VSSESD);
    inout   VDDESD,VSSESD;
    tran (VDDESD,VDDESD);
    tran (VSSESD,VSSESD);
endmodule

`endcelldefine
