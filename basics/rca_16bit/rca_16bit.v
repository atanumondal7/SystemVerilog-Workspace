`timescale 1ns/1ps

module rca_16bit(
  input wire [15:0] a,
  input wire [15:0] b,
  input wire cin,
  output wire [15:0] q,
  output wire cout
);
  
  wire c1, c2, c3;
  
  rca4bit rc1 (
    .a(a[3:0]),
    .b(b[3:0]),
    .cin(cin),
    .q(q[3:0]),
    .cout(c1)
  );
  
  rca4bit rc2 (
    .a(a[7:4]),
    .b(b[7:4]),
    .cin(c1),
    .q(q[7:4]),
    .cout(c2)
  );
  
  rca4bit rc3 (
    .a(a[11:8]),
    .b(b[11:8]),
    .cin(c2),
    .q(q[11:8]),
    .cout(c3)
  );
  
  rca4bit rc4 (
    .a(a[15:12]),
    .b(b[15:12]),
    .cin(c3),
    .q(q[15:12]),
    .cout(cout)
  );
  
endmodule
  
module rca4bit (
  input wire [3:0] a,
  input wire [3:0] b,
  input wire cin,
  output wire [3:0] q,
  output wire cout
);
  
  wire c1, c2, c3;
  
  fulladder rc1 (
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .q(q[0]),
    .cout(c1)
  );
  
  fulladder rc2 (
    .a(a[1]),
    .b(b[1]),
    .cin(c1),
    .q(q[1]),
    .cout(c2)
  );
  
  fulladder rc3 (
    .a(a[2]),
    .b(b[2]),
    .cin(c2),
    .q(q[2]),
    .cout(c3)
  );
  
  fulladder rc4 (
    .a(a[3]),
    .b(b[3]),
    .cin(c3),
    .q(q[3]),
    .cout(cout)
  );
  
endmodule
  
module fulladder (
  input wire a,
  input wire b,
  input wire cin,
  output wire q,
  output wire cout
);
  
  wire s, c1, c2;
  
  halfadder sub1 (
    .a(a),
    .b(b),
    .q(s),
    .cout(c1)
  );
  
  halfadder sub2 (
    .a(s),
    .b(cin),
    .q(q),
    .cout(c2)
  );
  
  or u_or0(cout, c1, c2);
  
endmodule


module halfadder (
  input wire a,
  input wire b,
  output wire q,
  output wire cout
);
  
  assign {cout,q} = a + b;
  
endmodule