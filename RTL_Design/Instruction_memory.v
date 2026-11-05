module instruction_memory(
input [3:0] address,
output reg [11:0] instruction
);

reg [11:0] memory [0:15];

integer i;

initial begin

// Initialize memory
for (i = 0; i < 16; i = i + 1)
    memory[i] = 12'b000000000000;

// Sample program instructions
memory[0] = 12'b000000010010;
memory[1] = 12'b000100110100;
memory[2] = 12'b001001010110;
memory[3] = 12'b001101110000;
memory[4] = 12'b111100000000;

end

always @(*) begin
instruction = memory[address];
end

endmodule
