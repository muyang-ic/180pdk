// Created by ihdl
`timescale 1ns/10ps

`celldefine

module DFCSND4 (D, CP, CDN, SDN, Q, QN, VDD, VSS);
    input D, CP, CDN, SDN;
    output Q, QN;
   inout VDD, VSS;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    `ifdef RECREM 	// Reserve for RECREM.
      wire  CDN_d , SDN_d ;
      buf      (CDN_i, CDN_d);
      buf      (SDN_i, SDN_d);
    `else         	// Reserve for non RECREM. 
      buf      (CDN_i, CDN);
      buf      (SDN_i, SDN);
    `endif
    wire D_d, CP_d ;
    tsmc_dff (Q_buf, D_d, CP_d, CDN_i, SDN_i, notifier);
    buf      (Q, Q_buf);
    not      (QN_buf, Q_buf);
    and      (QN, QN_buf, SDN_i);
  `else 	// Reserve for non NTC.
    buf      (CDN_i, CDN);
    buf      (SDN_i, SDN);
    tsmc_dff (Q_buf, D, CP, CDN_i, SDN_i, notifier);
    buf      (Q, Q_buf);
    not      (QN_buf, Q_buf);
    and      (QN, QN_buf, SDN_i);
  `endif
    reg flag;
    always @(CDN_i or SDN_i) begin
      if (!$test$plusargs("cdn_sdn_check_off")) begin
      if (flag == 1) begin 
         if (CDN_i!==1'b0) begin
         $display("%m > CDN is released at time %.2fns.", $realtime);
         end
         if (SDN_i!==1'b0) begin
         $display("%m > SDN is released at time %.2fns.", $realtime);
         end
      end
      flag = ((CDN_i===1'b0)&&(SDN_i ===1'b0));
      if (flag == 1) begin
         $display("%m > Both CDN and SDN are enabled at time %.2fns.", $realtime);
      end
    end 
    end



  // Timing logics defined for default constraint check
  and  (CP_check, CDN_i, SDN_i);
  and  (D_check, CDN_i, SDN_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (CP == 1'b1 && D == 1'b1 && SDN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0 && SDN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1 && SDN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0 && SDN == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    ifnone (negedge CDN => (Q+:1'b0)) = (0, 0);
    (posedge CP => (Q+:D)) = (0, 0);
    if (CDN == 1'b1 && CP == 1'b1 && D == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CDN == 1'b1 && CP == 1'b1 && D == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CDN == 1'b1 && CP == 1'b0 && D == 1'b1)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CDN == 1'b1 && CP == 1'b0 && D == 1'b0)
    (negedge SDN => (Q+:1'b1)) = (0, 0);
    ifnone (negedge SDN => (Q+:1'b1)) = (0, 0);
    if (CP == 1'b1 && D == 1'b1 && SDN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0 && SDN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1 && SDN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0 && SDN == 1'b1)
    (negedge CDN => (QN-:1'b0)) = (0, 0);
    ifnone (negedge CDN => (QN-:1'b0)) = (0, 0);
    (posedge CP => (QN-:D)) = (0, 0);
    if (CDN == 1'b1 && CP == 1'b1 && D == 1'b1)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    if (CDN == 1'b1 && CP == 1'b1 && D == 1'b0)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    if (CDN == 1'b1 && CP == 1'b0 && D == 1'b1)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    if (CDN == 1'b1 && CP == 1'b0 && D == 1'b0)
    (negedge SDN => (QN-:1'b1)) = (0, 0);
    ifnone (negedge SDN => (QN-:1'b1)) = (0, 0);
    $width (negedge CDN, 0, 0, notifier);
    $width (posedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge CP &&& CP_DEFCHK, 0, 0, notifier);
    $width (negedge SDN, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge SDN, posedge CDN, 0, 0, notifier,,, SDN_d, CDN_d);
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CDN, posedge SDN, 0, 0, notifier,,, CDN_d, SDN_d);
      $recrem (posedge CDN, posedge CP, 0,0, notifier, , , CDN_d, CP_d);
      $recrem (posedge SDN, posedge CP, 0,0, notifier, , , SDN_d, CP_d);
    `else
      $setuphold (posedge SDN, posedge CDN, 0, 0, notifier,,, SDN_d, CDN_d);
      $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CDN, posedge SDN, 0, 0, notifier,,, CDN_d, SDN_d);
      $recovery (posedge CDN, posedge CP, 0, notifier);
      $hold (posedge CP, posedge CDN, 0, notifier);
      $recovery (posedge SDN, posedge CP, 0, notifier);
      $hold (posedge CP, posedge SDN, 0, notifier);
    `endif
  `else
    $setuphold (posedge SDN, posedge CDN, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, posedge D, 0, 0, notifier);
    $setuphold (posedge CP &&& D_DEFCHK, negedge D, 0, 0, notifier);
    $setuphold (posedge CDN, posedge SDN, 0, 0, notifier);
    $recovery (posedge CDN, posedge CP, 0, notifier);
    $hold (posedge CP, posedge CDN, 0, notifier);
    $recovery (posedge SDN, posedge CP, 0, notifier);
    $hold (posedge CP, posedge SDN, 0, notifier);
  `endif
  endspecify
  `endif
endmodule

`endcelldefine
