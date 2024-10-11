module decoder_7seg(bin, HEX);
    input [3:0] bin;
    output reg [0:6] HEX;

always @(*)
	begin
		HEX = (bin == 4'b0000) ? 7'b0000001 : // 0
				(bin == 4'b0001) ? 7'b1001111 : // 1
				(bin == 4'b0010) ? 7'b0010010 : // 2
				(bin == 4'b0011) ? 7'b0000110 : // 3
				(bin == 4'b0100) ? 7'b1001100 : // 4
				(bin == 4'b0101) ? 7'b0100100 : // 5
				(bin == 4'b0110) ? 7'b0100000 : // 6
				(bin == 4'b0111) ? 7'b0001111 : // 7
				(bin == 4'b1000) ? 7'b0000000 : // 8
				(bin == 4'b1001) ? 7'b0000100 : // 9
				7'b1111111;
	end

endmodule