`timescale 1ns/1ps

module tb_accumulator_manual;
  
  reg [3:0] test_d;
  reg test_clk;
  reg test_rst;
  wire [3:0] test_q;
  wire test_carry;
  
  accumulator_manual uut (
    .d(test_d),
    .clk(test_clk),
    .rst(test_rst),
    .q(test_q),
    .carry(test_carry)
  );
  
  initial begin
    test_clk = 0;
  end
  
  always begin
    #10 test_clk = ~test_clk;
  end
  
  task disp();
  
  $display("d=%0d, rst=%0b, q=%0d, carry=%0b", test_d, test_rst, test_q, test_carry);
  
  endtask
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_accumulator_manual);
    
    test_rst = 1'b1; 
    test_d = 4'b0000; 
    @(negedge test_clk);
	disp();
    test_rst = 1'b0;
    
    
    test_d = 4'b0001; @(negedge test_clk);
	disp();
    test_d = 4'b0010; @(negedge test_clk);
	disp();
    test_d = 4'b0011; @(negedge test_clk);
	disp();
    test_d = 4'b0100; @(negedge test_clk);
	disp();
    test_d = 4'b0101; @(negedge test_clk);
	disp();
    test_d = 4'b0110; @(negedge test_clk);
	disp();
    test_d = 4'b0111; @(negedge test_clk);
	disp();
    test_d = 4'b1000; @(negedge test_clk);
	disp();
    test_d = 4'b1001; @(negedge test_clk);
	disp();
    test_d = 4'b1010; @(negedge test_clk);
	disp();
    test_d = 4'b1011; @(negedge test_clk);
	disp();
    test_d = 4'b1100; @(negedge test_clk);
	disp();
    test_d = 4'b1101; @(negedge test_clk);
	disp();
    test_d = 4'b1110; @(negedge test_clk);
	disp();
    test_d = 4'b1111; @(negedge test_clk);
    disp();
	
    $finish;
    
  end
  
endmodule