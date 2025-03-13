module Mux2to1(input slc, input [31:0] a, b, output [31:0] w);
    
    assign w = ~slc ? a : b;

endmodule
