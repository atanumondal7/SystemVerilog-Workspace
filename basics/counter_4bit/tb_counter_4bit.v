`timescale 1ns/1ps

module tb_counter_4bit;
  
  reg test_clk;
  reg test_rst;
  wire [3:0] test_count;
  
  counter_4bit uut (
    .clk(test_clk),
    .rst(test_rst),
    .count(test_count)
  );
  
  initial begin
    test_clk = 0;
  end
  
  always begin
    #10 test_clk = ~test_clk;
  end
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_counter_4bit);
    
	$monitor("Counter: %0d", test_count);
	
    test_rst = 1'b1; #5;
    test_rst = 1'b0; #5;
    
    #200;
    
    $finish;
    
  end
  
  endmodule