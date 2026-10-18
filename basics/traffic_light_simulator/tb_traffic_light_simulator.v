`timescale 1ns/1ps

module tb_traffic_light_simulator;
  
  reg test_clk;
  reg test_rst;
  wire test_red;
  wire test_yellow;
  wire test_green;
  wire [3:0] test_count;
  
  traffic_light_simulator uut (
    .clk(test_clk),
    .rst(test_rst),
    .red(test_red),
    .yellow(test_yellow),
    .green(test_green),
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
    $dumpvars(0, tb_traffic_light_simulator);
	
	$monitor("rst=%0b, red=%0b, yellow=%0b, green=%0b, count=%0b", test_rst, test_rst, test_red, test_yellow, test_green, test_count);
    
    test_rst = 1'b1; #5; 
    test_rst = 1'b0; #5;
    
    #2400;
    
    $finish;
    
  end
  
endmodule