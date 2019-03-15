module fa(output wire cout, sum, input wire a, b, cin);

  assign{cout,sum} = cin + a + b;
//sum =  ((~cin) & x &(~y)) | ((~cin) &(~x)&y ) | (cin &(~x) &(~y)) | (cin & x & y);
//cout = ((~cin) & x &y) | ((cin) &(~x)&y ) | (cin &(x) &(~y)) | (cin & x & y);

endmodule
