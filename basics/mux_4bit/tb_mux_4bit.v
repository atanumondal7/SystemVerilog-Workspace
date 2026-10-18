`timescale 1ns/1ps

module tb_mux_4bit;
  
  reg test_i0;
  reg test_i1;
  reg test_i2;
  reg test_i3;
  reg [1:0] test_sel;
  wire test_y;
  
  mux_4bit uut (
    .i0(test_i0),
    .i1(test_i1),
    .i2(test_i2),
    .i3(test_i3),
    .sel(test_sel),
    .y(test_y)
  );
  
  task disp();
  
  $display("i0=%0b, i1=%0b, i2=%0b, i3=%0b, sel=%b, y=%0b", test_i0, test_i1, test_i2, test_i3, test_sel, test_y);
  
  endtask
  
  initial begin 
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_mux_4bit);
    
    test_i0 = 1; test_i1 = 0; test_i2 = 0; test_i3 = 0; 
    test_sel = 2'b00; #10;
	disp();
    
    test_i0 = 0; test_i1 = 1; test_i2 = 0; test_i3 = 0; 
    test_sel = 2'b00; #10;
	disp();
    
    test_i0 = 0; test_i1 = 0; test_i2 = 1; test_i3 = 0; 
    test_sel = 2'b00; #10;
	disp();
    
    test_i0 = 0; test_i1 = 0; test_i2 = 0; test_i3 = 1; 
    test_sel = 2'b00; #10;
    disp();
    
	
	
    test_i0 = 1; test_i1 = 0; test_i2 = 0; test_i3 = 0; 
    test_sel = 2'b01; #10;
    disp();
	
    test_i0 = 0; test_i1 = 1; test_i2 = 0; test_i3 = 0; 
    test_sel = 2'b01; #10;
    disp();
	
    test_i0 = 0; test_i1 = 0; test_i2 = 1; test_i3 = 0; 
    test_sel = 2'b01; #10;
    disp();
	
    test_i0 = 0; test_i1 = 0; test_i2 = 0; test_i3 = 1; 
    test_sel = 2'b01; #10;
    disp();
    
	
	
    test_i0 = 1; test_i1 = 0; test_i2 = 0; test_i3 = 0; 
    test_sel = 2'b10; #10;
    disp();
	
    test_i0 = 0; test_i1 = 1; test_i2 = 0; test_i3 = 0; 
    test_sel = 2'b10; #10;
    disp();
	
    test_i0 = 0; test_i1 = 0; test_i2 = 1; test_i3 = 0; 
    test_sel = 2'b10; #10;
    disp();
	
    test_i0 = 0; test_i1 = 0; test_i2 = 0; test_i3 = 1; 
    test_sel = 2'b10; #10;
    disp();
	
	
    
    test_i0 = 1; test_i1 = 0; test_i2 = 0; test_i3 = 0; 
    test_sel = 2'b11; #10;
    disp();
	
    test_i0 = 0; test_i1 = 1; test_i2 = 0; test_i3 = 0; 
    test_sel = 2'b11; #10;
    disp();
	
    test_i0 = 0; test_i1 = 0; test_i2 = 1; test_i3 = 0; 
    test_sel = 2'b11; #10;
    disp();
	
    test_i0 = 0; test_i1 = 0; test_i2 = 0; test_i3 = 1; 
    test_sel = 2'b11; #10;
    disp();
    
    $finish;
    
  end
  
endmodule