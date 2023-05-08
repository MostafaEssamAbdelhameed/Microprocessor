module mcu #(parameter op_sz = 32 , parameter mem_sz=10)
 (
	input wire clk,reset,
	input wire [mem_sz-1 : 0] op0,
	input wire [op_sz-1 : 0] op1,
	input wire [mem_sz-1 : 0] op2,
	input wire [3:0] op,
	output wire [op_sz-1 : 0] out,
	output wire op_err
);
	reg [op_sz-1 : 0] mem [0 : (2**mem_sz)-1];
	
	always @(posedge clk) begin
		if (reset == 0) begin
			case(op)
				0: mem[op2]=mem[op0]+mem[op1];
				1: mem[op2]=mem[op0]-mem[op1];
				2: mem[op2]=mem[op0]*mem[op1];
				3: mem[op2]=mem[op0]/mem[op1];
				4: mem[op2]=mem[op0]&mem[op1];
				5: mem[op2]=mem[op0]|mem[op1];
				6: mem[op2]=mem[op0]^mem[op1];
				8: mem[op0]=op1;
				default: mem[op2] = mem[op2];
			endcase
		end
		else begin
			//mem = {{(2**mem_sz)*op_sz{1'b0}}};  [(2**mem_sz)-1)*op_sz]=no of bits in memory //
			mem[op0] = 0;
			mem[op1] = 0;
		end
	end
	
	assign op_err = (op>8)? 1 : 0 ;
    assign out = (op==7) ? mem[op0] : mem[op2] ;
endmodule
