`timescale 1ns/1ps

module counter_4bit (
  input wire clk,
  input wire rst,
  output reg [3:0] count
);
  
  always @(posedge clk or posedge rst) begin
    
    if(rst == 1'b1) begin
      	count <= 4'b0000;
    end
    
    else begin
      count <= count + 4'b0001;
    end
   
  end
  
endmodule