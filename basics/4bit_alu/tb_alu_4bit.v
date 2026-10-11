`timescale 1ns/1ps

module tb_alu_4bit;
  
  reg [3:0] test_a;
  reg [3:0] test_b;
  reg [1:0] test_opcode;
  wire [3:0] test_result;
  wire test_carry_out;
  wire test_neg_flag;
  wire test_zero_flag;
  
  alu_4bit uut (
    .a(test_a),
    .b(test_b),
    .opcode(test_opcode),
    .result(test_result),
    .carry_out(test_carry_out),
    .neg_flag(test_neg_flag),
    .zero_flag(test_zero_flag)
  );
  
   task disp();
  $display("a=%0d, b=%0d, opcode=%0d, result=%0d, carry_out=%0b, neg_flag=%0b, zero_flag=%0b", test_a, test_b, test_opcode, test_result, test_carry_out, test_neg_flag, test_zero_flag);
  endtask
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_alu_4bit);
    
    test_a = 4'b0111; test_b = 4'b0011; test_opcode = 2'b00; #10;
	disp();
    test_a = 4'b1011; test_b = 4'b1001; test_opcode = 2'b00; #10;
	disp();
    test_a = 4'b0111; test_b = 4'b0011; test_opcode = 2'b01; #10;
	disp();
    test_a = 4'b0111; test_b = 4'b0011; test_opcode = 2'b10; #10;
	disp();
    test_a = 4'b0111; test_b = 4'b0011; test_opcode = 2'b11; #10;
	disp();
    test_a = 4'b0011; test_b = 4'b0111; test_opcode = 2'b01; #10;
	disp();
    test_a = 4'b0011; test_b = 4'b0011; test_opcode = 2'b01; #10;
	disp();
    
    $finish;
    
  end
  
  endmodule