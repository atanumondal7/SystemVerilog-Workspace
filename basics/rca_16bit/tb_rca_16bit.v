`timescale 1ns/1ps

module tb_rca_16bit;
  
  reg [15:0] test_a;
  reg [15:0] test_b;
  reg test_cin;
  wire [15:0] test_q;
  wire test_cout;
  
  integer error_count = 0;
  
  rca_16bit uut (
    .a(test_a),
    .b(test_b),
    .cin(test_cin),
    .q(test_q),
    .cout(test_cout)
  );
  
  reg [15:0] sum;
  reg carry;
  
  task check(input [15:0] ta, input [15:0] tb, input tcin, input [15:0] tq, input tca);
    begin
      
      $display("[TB_CHECK] Input: a=%0d, b=%0d, cin=%0d | Output: sum=%0d, carry=%0d", ta, tb, tcin, tq, tca);
      
      {carry, sum} = ta + tb + tcin;
      
      if(sum == tq && carry == tca) begin
        $display("[SUCCESS] Time: %0t | Matched expected: sum=%0d, carry=%0d", $time, sum, carry);
      end
      else begin
        $display("[ERROR] Time: %0t | Expected: sum=%0d, carry=%0d | Got: sum=%0d, carry=%0d", $time, sum, carry, tq, tca);
        error_count = error_count + 1;
      end
      
      end
  endtask
      
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_rca_16bit);
    
    repeat (10) begin
      
      test_a = {$random} % 65536; 
      test_b = {$random} % 65536;
      test_cin = {$random} % 2;
      #10;
      check(test_a, test_b, test_cin, test_q, test_cout);
      
    end
    
    if(error_count == 0) begin
      $display("All tests passed successfully!");
    end
    else begin
      $display("Simulation failed! Encountered %0d errors", error_count);
    end
    
    
    $finish;
    
  end
  
endmodule