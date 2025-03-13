module ALU(input [2:0] ALUControl, input signed [31:0] A, B, output zero, output reg signed [31:0] out);
    parameter [2:0] ADD =3'b000, SUB= 3'b001, AND= 3'b010, OR= 3'b011, SLT= 3'b101, XOR= 3'b100;    
    
    always @(A , B , ALUControl) begin
        case (ALUControl)
            ADD   :  out= $signed(A) + $signed(B);
            SUB   :  out = $signed(A) - $signed(B);
            AND   :  out = A & B;
            OR    :  out = A | B;
            SLT   :  out = $signed(A) < $signed(B) ? 32'd1 : 32'd0;
            XOR   :  out = A ^ B;
            default:  out = {32{1'bz}};
        endcase
    end

    assign zero = (~|out);

endmodule