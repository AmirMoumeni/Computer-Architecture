`timescale 1ns/1ns
module mux4_test();
    wire [31:0] out;
    reg [31:0] Src1=32'd50;
    reg [31:0] Src2=32'd10;
    reg [31:0] Src3=32'd128;
    reg [31:0] Src4=32'd998;

    reg [1:0]select=2'd1;
    mux4 CUT(select, Src1, Src2, Src3, Src4, out);
    initial begin
        #100 select=2'd0;
        #100 select=2'd3;
        #100 select=2'd2;
        #100 $stop;
    end
endmodule