`timescale 1ns/1ps

module subtractor_4bit (
  input wire [3:0] a,
  input wire [3:0] b,
  output reg [3:0] result,
  output reg negative
);
  always @(*) begin
    
  if (a >= b) begin
    negative <= 1'b0; 
  	result <= a + (~b + 1);
  end
  
  else begin
    result <= 4'b0000;
    negative <= 1'b1;
  end
    
  end
  
endmodule