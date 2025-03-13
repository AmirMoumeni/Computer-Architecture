`define BITS(x) $rtoi($ceil($clog2(x)))

module RegisterFile(clk, RegWrite, readRegister1, readRegister2,
                    writeRegister, WriteData, ReadData1, ReadData2);
                    
    parameter WordLen = 32;
    parameter WordCount = 32;

    input RegWrite, clk;
    input [`BITS(WordCount)-1:0] readRegister1, readRegister2, writeRegister;
    input [WordLen-1:0] WriteData;
    output [WordLen-1:0] ReadData1, ReadData2;

    reg [WordLen-1:0] registerFile [0:WordCount-1];

    initial 
        registerFile[0] = 32'd0;

    always @(posedge clk) begin
        if (RegWrite & (|writeRegister))
            registerFile[writeRegister] <= WriteData;
    end

    assign ReadData1 = registerFile[readRegister1];
    assign ReadData2 = registerFile[readRegister2];

endmodule