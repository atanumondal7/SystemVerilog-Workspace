`timescale 1ns/1ps

module mux_4bit (
  input wire i0,
  input wire i1,
  input wire i2,
  input wire i3,
  input wire [1:0] sel,
  output wire y
);
  
  wire w_top_to_final;
  wire w_bot_to_final;
  
  mux2to1 sub_mux_top (
    .a(i0),
    .b(i1),
    .sel(sel[0]),
    .y(w_top_to_final)
  );
  
  mux2to1 sub_mux_bottom (
    .a(i2),
    .b(i3),
    .sel(sel[0]),
    .y(w_bot_to_final)
  );
  
  mux2to1 sub_mux_final (
    .a(w_top_to_final),
    .b(w_bot_to_final),
    .sel(sel[1]),
    .y(y)
  );
  
endmodule

module mux2to1 (
  input wire a,
  input wire b,
  input wire sel,
  output wire y
);
  
  wire sel_bar;
  wire and0_out;
  wire and1_out;
  
  not u_not0(sel_bar, sel);
  
  and u_and0(and0_out, a, sel_bar);
  
  and u_and1(and1_out, b, sel);
  
  or u_or0(y, and0_out, and1_out);
 
endmodule