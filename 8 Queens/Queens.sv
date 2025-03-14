`timescale 1ns/1ns
 
module Reg(input clk, rst, len , shiften, input [7:0] pin, output reg [7:0] pout);
	wire [7:0] shifted = (pout == 8'b00000001 ) ? 8'b10000000 : (pout>> 1) ;
	always @(posedge clk, posedge rst) begin
		if (rst) pout <= 8'b0;
		else if (shiften) pout <=shifted;
		else if (len) pout <= pin;
		else pout <= pout;
	end
endmodule

module Mux(input [7:0] a, b, input sla, output [7:0] s);
	assign s = sla ? a : b;

endmodule

module Filler(input [7:0] pin, output [7:0] pout);
    wire [7:0] temp;
    wire sign;
    
    // Shift pin by 1 to the right
    assign temp = pin >> 1;
    
    // Determine if sign bit should be used (assuming temp > 0 means 1)
    assign sign = (temp > 0) ? 1 : 0;
    
    // Use the Mux to select between temp and 8-bit binary '10000000'
    Mux mx (temp, 8'b10000000, sign, pout);
endmodule

module horizentalSafe (input [7:0] reg1 , reg2 , reg3 , reg4 , reg5 , reg6 , reg7 , reg8 , output horizentalSafe);
	logic [2:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8;
    // Compute the sum of each bit across all reg inputs
    always_comb begin
        sum1 = reg1[0] + reg2[0] + reg3[0] + reg4[0] + reg5[0] + reg6[0] + reg7[0] + reg8[0];
        sum2 = reg1[1] + reg2[1] + reg3[1] + reg4[1] + reg5[1] + reg6[1] + reg7[1] + reg8[1];
        sum3 = reg1[2] + reg2[2] + reg3[2] + reg4[2] + reg5[2] + reg6[2] + reg7[2] + reg8[2];
        sum4 = reg1[3] + reg2[3] + reg3[3] + reg4[3] + reg5[3] + reg6[3] + reg7[3] + reg8[3];
        sum5 = reg1[4] + reg2[4] + reg3[4] + reg4[4] + reg5[4] + reg6[4] + reg7[4] + reg8[4];
        sum6 = reg1[5] + reg2[5] + reg3[5] + reg4[5] + reg5[5] + reg6[5] + reg7[5] + reg8[5];
        sum7 = reg1[6] + reg2[6] + reg3[6] + reg4[6] + reg5[6] + reg6[6] + reg7[6] + reg8[6];
        sum8 = reg1[7] + reg2[7] + reg3[7] + reg4[7] + reg5[7] + reg6[7] + reg7[7] + reg8[7];
    end

    // Check if any sum is greater than 2
    assign horizentalSafe = (sum1 > 1) || (sum2 > 1) || (sum3 > 1) || (sum4 > 1) ||
                    (sum5 > 1) || (sum6 > 1) || (sum7 > 1) || (sum8 > 1);

endmodule

module DiagonalSafe1 (input [7:0] reg1 , reg2 , reg3 , reg4 , reg5 , reg6 , reg7 , reg8 , output DiagonalSafe);
	logic [2:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10, sum11, sum12, sum13, sum14, sum15;
    // Compute the sum of each bit across all reg inputs
    always_comb begin
	sum14= reg7[0] + reg8[1];
	sum13= reg6[0] + reg7[1] + reg8[2];
	sum12= reg5[0] + reg6[1] + reg7[2] + reg8[3];
	sum11= reg4[0] + reg5[1] + reg6[2] + reg7[3] + reg8[4];
	sum10= reg3[0] + reg4[1] + reg5[2] + reg6[3] + reg7[4] + reg8[5];
        sum9 = reg2[0] + reg3[1] + reg4[2] + reg5[3] + reg6[4] + reg7[5] + reg8[6] ;
	sum1 = reg1[0] + reg2[1] + reg3[2] + reg4[3] + reg5[4] + reg6[5] + reg7[6] + reg8[7];
        sum2 = reg1[1] + reg2[2] + reg3[3] + reg4[4] + reg5[5] + reg6[6] + reg7[7] ;
        sum3 = reg1[2] + reg2[3] + reg3[4] + reg4[5] + reg5[6] + reg6[7];
        sum4 = reg1[3] + reg2[4] + reg3[5] + reg4[6] + reg5[7];
        sum5 = reg1[4] + reg2[5] + reg3[6] + reg4[7];
        sum6 = reg1[5] + reg2[6] + reg3[7];
        sum7 = reg1[6] + reg2[7];
    end

    // Check if any sum is greater than 1
    assign DiagonalSafe = (sum1 > 1) || (sum2 > 1) || (sum3 > 1) || (sum4 > 1) ||
                    (sum5 > 1) || (sum6 > 1) || (sum7 > 1)|| (sum9 > 1) || (sum10 > 1) || (sum11 > 1) ||
                    (sum12 > 1) || (sum13 > 1) || (sum14 > 1);

endmodule

module DiagonalSafe2 (input [7:0] reg1 , reg2 , reg3 , reg4 , reg5 , reg6 , reg7 , reg8 , output DiagonalSafe);
	logic [2:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10, sum11, sum12, sum13, sum14, sum15;
    // Compute the sum of each bit across all reg inputs
    always_comb begin
	sum14= reg7[7] + reg8[6] ;
	sum13= reg6[7] + reg7[6] + reg8[5] ;
	sum12= reg5[7] + reg6[6] + reg7[5] + reg8[4] ;
	sum11= reg4[7] + reg5[6] + reg6[5] + reg7[4] + reg8[3] ;
	sum10= reg3[7] + reg4[6] + reg5[5] + reg6[4] + reg7[3] + reg8[2] ;
        sum9 = reg2[7] + reg3[6] + reg4[5] + reg5[4] + reg6[3] + reg7[2] + reg8[1] ;
	sum1 = reg1[7] + reg2[6] + reg3[5] + reg4[4] + reg5[3] + reg6[2] + reg7[1] + reg8[0]; 
        sum2 = reg1[6] + reg2[5] + reg3[4] + reg4[3] + reg5[2] + reg6[1] + reg7[0] ;
        sum3 = reg1[5] + reg2[4] + reg3[3] + reg4[2] + reg5[1] + reg6[0] ;
        sum4 = reg1[4] + reg2[3] + reg3[2] + reg4[1] + reg5[0] ;
        sum5 = reg1[3] + reg2[2] + reg3[1] + reg4[0] ;
        sum6 = reg1[2] + reg2[1] + reg3[0] ;
        sum7 = reg1[1] + reg2[0] ;
    end

    // Check if any sum is greater than 1
    assign DiagonalSafe = (sum1 > 1) || (sum2 > 1) || (sum3 > 1) || (sum4 > 1) ||
                    (sum5 > 1) || (sum6 > 1) || (sum7 > 1) || (sum9 > 1) || (sum10 > 1) || (sum11 > 1) ||
                    (sum12 > 1) || (sum13 > 1) || (sum14 > 1);

endmodule

module isSafe (input [7:0] reg1 , reg2 , reg3 , reg4 , reg5 , reg6 , reg7 , reg8 , output isSafe);
wire horizentalSafe, DiagonalSafe1, DiagonalSafe2;
horizentalSafe hSafe (reg1 , reg2 , reg3 , reg4 , reg5 , reg6 , reg7 , reg8 , horizentalSafe);
DiagonalSafe1  DSafe1(reg1 , reg2 , reg3 , reg4 , reg5 , reg6 , reg7 , reg8 , DiagonalSafe1);
DiagonalSafe2  DSafe2(reg1 , reg2 , reg3 , reg4 , reg5 , reg6 , reg7 , reg8 , DiagonalSafe2);

assign isSafe = ~(horizentalSafe || DiagonalSafe1 || DiagonalSafe2);
endmodule


module counter(input clk, rst, cen, iz , output reg co);
	wire [2:0] ns;
	logic [2:0] ps = 3'b0; 
	assign ns = ps + 1'b1;
	always @(posedge clk, posedge rst) begin
		if(rst) ps <= 3'b0;
		else if (iz) ps <= 3'b0;
		else if (cen)begin
			if(ps == 3'b110) ps<=3'b0;
			else ps <= ns;
	end
	end
	assign co = (ps == 3'b110) ;
endmodule

module DataPath (
    input clk, rst, 
    input [7:0] reg1Bus, 
    input [2:0] row_pos, // ????? ???? ???? ????
    input counten, countiz, 
    input [8:1] ldreg, shen, initreg, 
    output reg isSafe, countCo,
    output reg [7:0] regout1, regout2, regout3, regout4, regout5, regout6, regout7, regout8
);

logic [7:0] regin2, regin3, regin4, regin5, regin6, regin7, regin8;
logic [1:0] countOut;

Reg reg1 (clk, (row_pos == 3'd0) & initreg[1], (row_pos == 3'd0) & ldreg[1], shen[1], reg1Bus, regout1);
Reg reg2 (clk, (row_pos == 3'd1) & initreg[2], (row_pos == 3'd1) & ldreg[2], shen[2], reg1Bus, regout2);
Reg reg3 (clk, (row_pos == 3'd2) & initreg[3], (row_pos == 3'd2) & ldreg[3], shen[3], reg1Bus, regout3);
Reg reg4 (clk, (row_pos == 3'd3) & initreg[4], (row_pos == 3'd3) & ldreg[4], shen[4], reg1Bus, regout4);
Reg reg5 (clk, (row_pos == 3'd4) & initreg[5], (row_pos == 3'd4) & ldreg[5], shen[5], reg1Bus, regout5);
Reg reg6 (clk, (row_pos == 3'd5) & initreg[6], (row_pos == 3'd5) & ldreg[6], shen[6], reg1Bus, regout6);
Reg reg7 (clk, (row_pos == 3'd6) & initreg[7], (row_pos == 3'd6) & ldreg[7], shen[7], reg1Bus, regout7);
Reg reg8 (clk, (row_pos == 3'd7) & initreg[8], (row_pos == 3'd7) & ldreg[8], shen[8], reg1Bus, regout8);

Filler filler2 (regout1, regin2);
Filler filler3 (regout2, regin3);
Filler filler4 (regout3, regin4);
Filler filler5 (regout4, regin5);
Filler filler6 (regout5, regin6);
Filler filler7 (regout6, regin7);
Filler filler8 (regout7, regin8);

isSafe safe(regout1, regout2, regout3, regout4, regout5, regout6, regout7, regout8, isSafe);
counter count (clk, rst, counten, countiz, countCo);

endmodule

module Controller (
    input clk, rst, START, isSafe, countCo, 
    input [2:0] row_pos, // ????? ???? ???? ????
    output reg counten, countiz,
    output reg [8:1] ldreg, shen, initreg,
    output reg READY
);

parameter Idle = 4'd0, Reset = 4'd1, Load1 = 4'd2, Fill2 = 4'd3, Fill3 = 4'd4, Fill4 = 4'd5, Fill5 = 4'd6, Fill6 = 4'd7, Fill7 = 4'd8, Fill8 = 4'd9;
logic [3:0] ps, ns = 4'd0;

always @(ps, START, countCo, isSafe) begin
    {counten, countiz, ldreg, shen, initreg, READY} = 27'b0;
    case (ps) 
        Idle: begin 
            ns = (START) ? Reset : Idle;
            READY = 1; 
        end
        Reset: begin 
            ns = (START) ? Reset : Load1;
            initreg[row_pos + 1] = 1; // ???? ???? ??? ???? ??? ?? ????? ????
        end
        Load1: begin 
            ns = Fill2;
            ldreg[row_pos + 1] = 1; // ??? ???? ???? ?? ???? ???? ???
        end
        Fill2: begin 
            ns = (isSafe) ? Fill3 : Fill2;
            counten = ~isSafe;
            countiz = isSafe;
            shen[2] = ~isSafe; 
            ldreg[3] = isSafe;
            initreg[8:3] = (isSafe) ? 6'b0 : 6'b111111; 
        end
        // ???? ????? ????? ?? ???? ???? ????? ????
        default: ns = 3'b0;
    endcase 
end

always @(posedge clk, posedge rst) begin
    if (rst) ps <= 3'b000;
    else ps <= ns;
end
endmodule

module Queen (
    input clk, rst, START,
    input [7:0] reg1Bus, 
    input [2:0] row_pos, // ????? ???? ???? ????
    output [7:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8,
    output READY
);	

logic counten, countiz;
logic [8:1] ldreg, shen, initreg;
logic isSafe, countCo;

DataPath D1 (
    .clk(clk), .rst(rst), .reg1Bus(reg1Bus), .row_pos(row_pos), 
    .counten(counten), .countiz(countiz), .ldreg(ldreg), .shen(shen), .initreg(initreg), 
    .isSafe(isSafe), .countCo(countCo), 
    .regout1(reg1), .regout2(reg2), .regout3(reg3), .regout4(reg4), 
    .regout5(reg5), .regout6(reg6), .regout7(reg7), .regout8(reg8)
);

Controller C1 (
    .clk(clk), .rst(rst), .START(START), .isSafe(isSafe), .countCo(countCo), 
    .row_pos(row_pos), .counten(counten), .countiz(countiz), 
    .ldreg(ldreg), .shen(shen), .initreg(initreg), .READY(READY)
);

endmodule

`timescale 1ns/1ps

module Queen_tb();

    // ????????? ??? ???
    reg clk, rst, START;
    reg [7:0] reg1Bus; // ?????? ???? ??? ?? ??? ???? ???
    reg [2:0] row_pos; // ????? ???? ???? ???

    // ????????? ??? ???
    wire [7:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8;
    wire READY;

    // ?????????? ?? ????? Queen
    Queen queen_inst (
        .clk(clk), 
        .rst(rst), 
        .START(START), 
        .reg1Bus(reg1Bus), 
        .row_pos(row_pos), 
        .reg1(reg1), 
        .reg2(reg2), 
        .reg3(reg3), 
        .reg4(reg4), 
        .reg5(reg5), 
        .reg6(reg6), 
        .reg7(reg7), 
        .reg8(reg8), 
        .READY(READY)
    );

    // ????? ?????? ????
    always #5 clk = ~clk;

    // ?????? ???
    initial begin
        // ???????? ????? ?????????
        clk = 0;
        rst = 1;
        START = 0;
        reg1Bus = 8'b00000000; // ?????? ????? ???? ?? ???? ???? ???
        row_pos = 3'd0; // ??????? ???? ??? ?? ???? ???

        // ???? ?????
        #10 rst = 0;
        
        // ???? ??? ?? ????? ???? ???? ??? ?? ???????? ?????
        repeat (8) begin
            // ????? ?????? ???? ???? ???
            reg1Bus = 8'b00000001 << row_pos;
            
            // ????? ????? ???? ???? ???
            row_pos = row_pos + 1;

            // ???? ??????
            #10 START = 1;
            #10 START = 0;

            // ?????? ???? ????? ?? ?????
            wait (READY == 1);

            // ????? ?????
            $display("Row Position: %d, reg1: %b, reg2: %b, reg3: %b, reg4: %b, reg5: %b, reg6: %b, reg7: %b, reg8: %b", 
                      row_pos, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8);

            // ???? ???? ???? ????? ??? ?? ???? ????
            #10 rst = 1;
            #10 rst = 0;
        end

        $finish;
    end

endmodule




