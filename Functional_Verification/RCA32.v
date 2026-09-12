`timescale 1ns / 1ps

module RCA32(a, b, cin, sum, cout);
    input  [31:0] a, b;
    input         cin;
    output [31:0] sum;
    output        cout;

    wire c1;

    RCA16 A1(.a(a[15:0]),  .b(b[15:0]),  .cin(cin), .sum(sum[15:0]),  .cout(c1));
    RCA16 A2(.a(a[31:16]), .b(b[31:16]), .cin(c1),  .sum(sum[31:16]), .cout(cout));
endmodule
