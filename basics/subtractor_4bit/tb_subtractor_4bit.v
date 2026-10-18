`timescale 1ns/1ps

module tb_subtractor_4bit;
  
  reg [3:0] test_a;
  reg [3:0] test_b;
  wire [3:0] test_result;
  wire test_negative;
  
  subtractor_4bit uut (
    .a(test_a),
    .b(test_b),
    .result(test_result),
    .negative(test_negative)
  );
  
  task disp();
  
  $display("a=%0d, b=%0d, result=%0d, negative=%s", test_a, test_b, test_result, (test_negative) ? "Yes" : "No");
  
  endtask
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_subtractor_4bit);
    
    test_a = 4'b0111; test_b = 4'b0011; #10;
	disp();
    test_a = 4'b1001; test_b = 4'b0101; #10;
	disp();
    test_a = 4'b0011; test_b = 4'b1011; #10;
	disp();
    
    $finish;
    
  end
  
 endmodule