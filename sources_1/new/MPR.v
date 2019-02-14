`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2019 23:23:01
// Design Name: 
// Module Name: MPR
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


module MPR #(parameter bits = 32)(
    input clk, we_a, we_b,
    input [2:0] addr_a, addr_b,
    input [bits-1:0] d_in_a, d_in_b,
    output [bits-1:0] d_out_a, d_out_b
    
    );
    
    reg [bits-1:0] mem_vec[7:0];
    reg[2:0] read_addr_a, read_addr_b;
    
    always @(posedge clk)
    begin
        if(we_a)
            mem_vec[addr_a] <= d_in_a;
       read_addr_a <= mem_vec[addr_a];
    end
    
    assign d_out_a = mem_vec[addr_a];
    
    always @(posedge clk)
        begin
            if(we_b)
                mem_vec[addr_b] <= d_in_b;
           read_addr_b <= mem_vec[addr_b];
        end
        
        assign d_out_b = mem_vec[addr_b];
endmodule