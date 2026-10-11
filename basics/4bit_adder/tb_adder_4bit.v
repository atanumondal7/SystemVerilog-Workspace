`timescale 1ns/1ps

module tb_adder_4bit;
  
  reg [3:0] test_a;
  reg [3:0] test_b;
  wire [3:0] test_sum;
  wire test_carry;
  
  adder_4bit uut (
    .a(test_a),
    .b(test_b),
    .sum(test_sum),
    .carry(test_carry)
  );
  
  task disp();
  $display("a=%0d, b=%0d, sum=%0d, carry=%0b", test_a, test_b, test_sum, test_carry);
  endtask
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_adder_4bit);
    
    test_a = 4'b1001; test_b = 4'b0101; #10;
	disp();
    test_a = 4'b0101; test_b = 4'b1001; #10;
	disp();
    test_a = 4'b0111; test_b = 4'b0011; #10;
	disp();
    test_a = 4'b1111; test_b = 4'b0001; #10;
	disp();
    test_a = 4'b1011; test_b = 4'b1101; #10;
	disp();
    
    $finish;
    
  end
  
endmodule