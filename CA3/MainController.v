module MainController(input clk, input rst, input [6:0] op, output reg AdrSrc, output reg RegWrite, 
                      output reg MemWrite, output reg PCWrite, output reg branch, output reg IRWrite,
                      output reg [1:0] ResultSrc, output reg [1:0] ALUSrcA, output reg [1:0] ALUSrcB, 
                      output reg [1:0] ALUOp, output reg [2:0] ImmSrc);

    parameter R_T = 7'b0110011, I_T = 7'b0010011, S_T = 7'b0100011, B_T = 7'b1100011, 
              U_T = 7'b0110111, J_T = 7'b1101111, LW_T = 7'b0000011, JALR_T = 7'b1100111;

    parameter IF = 4'b0000, ID = 4'b0001, state1_I = 4'b0010, state1_R = 4'b0011, 
              state1_B = 4'b0100, state1_J = 4'b0101, state2_J_JALR = 4'b0110, 
              state1_S = 4'b0111, state1_LW = 4'b1000, state2_LW = 4'b1001, 
              state3_LW = 4'b1010, state3_J_JALR_R_I = 4'b1011, state2_S = 4'b1100, 
              state1_U = 4'b1101, state1_JALR = 4'b1110;

    reg [3:0] ps; 
    reg [3:0] ns;

    always @(ps , op) begin
        ns = IF;
	ResultSrc = 2'b00;
        MemWrite = 1'b0;
        ALUOp = 2'b00;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b00;
        ImmSrc = 3'b000;
        RegWrite = 1'b0;
        PCWrite = 1'b0;
        branch = 1'b0;
        IRWrite = 1'b0;
	AdrSrc = 1'b0;

        case (ps)
            IF: begin
                ns = ID; IRWrite = 1'b1; ALUSrcA = 2'b00; ALUSrcB = 2'b10; ALUOp = 2'b00;
                ResultSrc = 2'b10; PCWrite = 1'b1; AdrSrc = 1'b0;
            end

            ID: begin
                ns = (op == R_T) ? state1_R :
                     (op == I_T) ? state1_I :
                     (op == S_T) ? state1_S :
                     (op == J_T) ? state1_J :
                     (op == B_T) ? state1_B :
                     (op == U_T) ? state1_U :
                     (op == LW_T) ? state1_LW :
                     (op == JALR_T) ? state1_JALR : IF;

                ALUSrcA = 2'b01; ALUSrcB = 2'b01; ALUOp = 2'b00; ImmSrc = 3'b010;  end

            state1_R: begin
                ns = state3_J_JALR_R_I;
		ALUSrcA = 2'b10; ALUSrcB = 2'b00; ALUOp = 2'b10;
            end

            state1_I: begin
                ns = state3_J_JALR_R_I;
		ALUSrcA = 2'b10; ALUSrcB = 2'b01; ImmSrc = 3'b000; ALUOp = 2'b11;
            end

            state1_B: begin
                ns = IF;
                ALUSrcA = 2'b10; ALUSrcB = 2'b00; ALUOp = 2'b01; branch = 1'b1;
            end

            state1_J: begin
                ns = state2_J_JALR;
        	ALUSrcA = 2'b01; ALUSrcB = 2'b01; ALUOp = 2'b00; ImmSrc = 3'b011; 
            end

            state2_J_JALR: begin
                ns = state3_J_JALR_R_I;
                ALUSrcA = 2'b01; ALUSrcB = 2'b10; ALUOp = 2'b00; ResultSrc = 2'b00; PCWrite = 1'b1;
            end

            state1_S: begin
                ns = state2_S;
                ALUSrcA = 2'b10; ALUSrcB = 2'b01; ALUOp = 2'b00; ImmSrc = 3'b001;
            end

            state2_S: begin
                ns = IF; 
		AdrSrc = 1'b1; MemWrite = 1'b1;
            end

            state1_LW: begin
                ns = state2_LW;
                ALUSrcA = 2'b10; ALUSrcB = 2'b01; ImmSrc = 3'b000; ALUOp = 2'b00;
            end

            state2_LW: begin
                ns = state3_LW;
                AdrSrc = 1'b1; ResultSrc = 2'b00; 
            end
           
            state3_LW: begin
                ns = IF;
                ResultSrc = 2'b01; RegWrite = 1'b1;
            end
            
            state3_J_JALR_R_I: begin
                ns = IF;
                ResultSrc = 2'b00; RegWrite = 1'b1;
            end

            state1_U: begin ns = IF;
                ResultSrc = 2'b11; ImmSrc = 3'b100; RegWrite = 1'b1;  
            end
           
            state1_JALR: begin
                ns = state2_J_JALR;
                ALUSrcA = 2'b10; ALUSrcB = 2'b01; ImmSrc = 3'b000; ALUOp = 2'b00;   
            end

            default: begin
                ns = IF; 
            end
        endcase
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            ps <= IF; 
        else
            ps <= ns; 
    end
endmodule