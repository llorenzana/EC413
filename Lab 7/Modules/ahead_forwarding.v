`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2022 12:32:04 PM
// Design Name: 
// Module Name: ahead_forwarding
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ahead_forwarding(
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,
    input EXMEM_RegWrite, 
    input MEMWB_RegWrite,
    input [4:0] EX_MEM_RegisterRd,
    input [4:0] MEM_WB_RegisterRd,
    input [4:0] EX_rs,
    input [4:0] EX_rt
    );
    
    always @(EX_MEM_RegisterRd, MEM_WB_RegisterRd, EX_rs, EX_rt) 
        begin
            assign ForwardA = 2'b0; 
            assign ForwardB = 2'b0;
        
        if ((EXMEM_RegWrite && EX_MEM_RegisterRd != 0) && (EX_MEM_RegisterRd == EX_rs))
           begin 
                assign ForwardA = 2'b10;
           end
       
       if ((EXMEM_RegWrite && EX_MEM_RegisterRd != 0) && (EX_MEM_RegisterRd == EX_rt))
           begin 
                assign ForwardB = 2'b10;
           end
        
        if ((MEMWB_RegWrite && MEM_WB_RegisterRd != 0) && 
            (EX_MEM_RegisterRd != EX_rs) &&
            (MEM_WB_RegisterRd == EX_rs))
            begin 
                assign ForwardA = 2'b01; 
            end 
        if ((MEMWB_RegWrite  && MEM_WB_RegisterRd != 0) && 
            (EX_MEM_RegisterRd != EX_rt) &&
            (MEM_WB_RegisterRd == EX_rt))
            begin 
                assign ForwardB = 2'b01; 
            end 
    end   
endmodule
