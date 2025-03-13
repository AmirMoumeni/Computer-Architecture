module BranchController(input [2:0] func3, input branch, zero, output reg Bres);
    parameter  BEQ = 3'b000,BNE =3'b001;
    always @(func3, zero, branch) begin
        case(func3)
            BEQ   : Bres <= branch & zero;
            BNE   : Bres <= branch & ~zero;
            default: Bres <= 1'b0;
        endcase
    end

endmodule
