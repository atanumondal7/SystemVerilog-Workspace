`timescale 1ns/1ps

module traffic_light_simulator (
  input wire clk,
  input wire rst,
  output reg red,
  output reg yellow,
  output reg green,
  output reg [3:0] count
);
  
  always @(posedge clk or posedge rst) begin
    
    if(rst == 1'b1) begin
      	
      	count <= 4'b0000;
      	red <= 1'b1;
        yellow <= 1'b0;
        green <= 1'b0;
      
    end
    
    else begin
    
      count <= count + 4'b0001;

        if (count == 4'b0101) begin

          red <= 1'b0;
          green <= 1'b1;

      end

        if (count == 4'b1010) begin

          green <= 1'b0;
          yellow <= 1'b1;

      end

        if (count == 4'b1100) begin

          yellow <= 1'b0;
          red <= 1'b1;

      end
      
    end
  end
    
  
endmodule