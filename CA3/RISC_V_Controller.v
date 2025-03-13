module RISC_V_Controller(input clk, rst, func7, zero, input [6:0] op, input [2:0] func3, output PCWriteEn, AdrSrc, MemWrite, IRWrite, RegWrite,
                    output [1:0] ResultSrc, ALUSrcA, ALUSrcB, output [2:0] ALUControl, ImmSrc);

    wire [1:0] ALUOp;
    wire branch , Bres, PCWrite;

    MainController MC(.clk(clk), .rst(rst), .op(op), .PCWrite(PCWrite), .AdrSrc(AdrSrc), .MemWrite(MemWrite), .branch(branch),
                        .ResultSrc(ResultSrc), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .ImmSrc(ImmSrc), .RegWrite(RegWrite), .IRWrite(IRWrite), .ALUOp(ALUOp));
    
    ALU_Controller AC(.func3(func3), .func7(func7), .ALUOp(ALUOp), .ALUControl(ALUControl));    
    
    BranchController BRANCH(.func3(func3), .branch(branch), .zero(zero), .Bres(Bres)); 
       
    assign PCWriteEn = Bres|  PCWrite;                             

endmodule
