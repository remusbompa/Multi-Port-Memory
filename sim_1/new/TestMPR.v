`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2019 23:23:44
// Design Name: 
// Module Name: TestMPR
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


module TestMPR #(parameter bits = 32)(
        
    );
    
    reg clk,we_a, we_b;
    reg[2:0] addr_a, addr_b;
   reg [bits-1:0] d_in_a, d_in_b;
    wire [bits-1:0] q_out_a, q_out_b;
    
    integer i;
            
            
    MPR #(bits) test(clk, we_a, we_b, addr_a, addr_b, d_in_a, d_in_b,q_out_a, q_out_b);
    
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        we_a = 0;
        addr_a = 3'bx;
        d_in_a = {bits{1'bx}};
        
        
        we_b = 0;
        addr_b = 3'bx;
        d_in_b = {bits{1'bx}};
        
        $display("Test de scriere a\n");
        for(i = 0; i <4; i = i+1)
            begin
                @(negedge clk);
                #5 addr_a = i; we_a = 1; d_in_a = 15 - i;
                $display("scriem in memorie [%d] = [%d]", addr_a, d_in_a);
                
                
            end;
        
        
        $display("Test de scriere b\n");
        for(i = 4; i <8; i = i+1)
            begin
                 @(negedge clk);
                   #5 addr_b = i; we_b = 1; d_in_b = 15 - i;
                   $display("scriem in memorie [%d] = [%d]", addr_b, d_in_b);
            end;

        
        @(negedge clk);
        $display("test de citire a");
        for(i = 0; i <4; i = i+1)
                    begin
                        @(negedge clk);
                        #5;
                         addr_a = i;
                        we_a = 0;
                        $display("citim din memorie [%d] = [%d]", addr_a, q_out_a);
                        
                        
                    end;
        
        @(negedge clk);
        $display("test de citire b");
        for(i = 4; i <8; i = i+1)
                    begin
                         @(negedge clk);
                           #5;
                            addr_b = i;
                           we_b = 0;
                           $display("citim din memorie [%d] = [%d]", addr_b, q_out_b);
                    end        
                    
        @(negedge clk);
        $display("sciere si citire din aceeasi locatie de memorie la acelasi moment de timp");
        #5 addr_a = 5; we_a = 1; d_in_a = 99;
        
         @(negedge clk);
        $display("sciere si citire din aceeasi locatie de memorie la acelasi moment de timp");
        #5 addr_b = 5; we_b = 1; d_in_b = 99;
        
        @(negedge clk);
        #5 we_a = 1; addr_a = 3'bx; d_in_a = {bits{1'bx}};
        
         @(negedge clk);
         #5 we_b = 1; addr_b = 3'bx; d_in_b = {bits{1'bx}};
       
    @(negedge clk);
    $finish;

end
endmodule
