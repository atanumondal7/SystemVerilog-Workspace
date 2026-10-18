`timescale 1ns/1ps

module counter_4bit_cdv (
  input logic clk,
  input logic rst,
  input logic load,
  input logic [3:0] data_in,
  output logic [3:0] q
);
  
  always_ff @(posedge clk or posedge rst) begin
    
    if(rst) begin
      q <= 4'd0;
    end
    
    else if (load) begin
      q <= data_in;
    end
    
    else begin
      q <= q + 4'd1;
    end
  
  end
  
endmodule