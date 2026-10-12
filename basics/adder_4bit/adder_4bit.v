`timescale 1ns/1ps

module adder_4bit (
  input wire [3:0] a,
  input wire [3:0] b,
  output wire [3:0] sum,
  output wire carry
);
  
  assign {carry, sum} = a + b;
  
endmodule