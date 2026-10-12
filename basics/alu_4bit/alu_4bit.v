`timescale 1ns/1ps

module alu_4bit (
  input wire [3:0] a,
  input wire [3:0] b,
  input wire [1:0] opcode,
  output reg [3:0] result,
  output reg carry_out,
  output reg neg_flag,
  output reg zero_flag
);
  
  always @(*) begin
    result = 4'b0000;
    carry_out = 1'b0;
    neg_flag = 1'b0;
    zero_flag = 1'b0;
    
    case (opcode)
      
      2'b00: begin
        {carry_out, result} = a + b;
        
        if (result == 4'b0000) begin
          zero_flag = 1'b1;
        end
        
        else begin
          zero_flag = 1'b0;
        end
        
      end
      
      2'b01: begin
        if (a >= b) begin
        	result = a - b;
          
          if (result == 4'b0000) begin
          zero_flag = 1'b1;
        end
          
          else begin
          zero_flag = 1'b0;
        end
          
        end
        
        else begin
          neg_flag = 1'b1;
          result = 4'b0000;
        end
      end
      
      2'b10: begin
        result = a & b;
        
        if (result == 4'b0000) begin
          zero_flag = 1'b1;
        end
        
        else begin
          zero_flag = 1'b0;
        end
        
      end
      
      2'b11: begin
        result = a | b;
        
        if (result == 4'b0000) begin
          zero_flag = 1'b1;
        end
        
        else begin
          zero_flag = 1'b0;
        end
        
      end
      
      default: result = 4'b0000;
      
    endcase
     
  end
      
 endmodule