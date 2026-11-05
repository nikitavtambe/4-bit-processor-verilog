module processor(
    input clk,
    input reset,
    output reg [3:0] pc_out,
    output reg halted
);

reg [3:0] registers [0:3];
reg [3:0] data_memory [0:15];
reg [11:0] instruction_memory [0:15];

wire [11:0] instruction;
wire [3:0] opcode;
wire [1:0] rd, rs;
wire [3:0] immediate;

assign instruction = instruction_memory[pc_out];
assign opcode = instruction[11:8];
assign rd = instruction[7:6];
assign rs = instruction[5:4];
assign immediate = instruction[3:0];

integer i;

initial begin
    instruction_memory[0] = 12'b011000000000;
    instruction_memory[1] = 12'b011001000001;
    instruction_memory[2] = 12'b100010000000;
    instruction_memory[3] = 12'b000010010000;
    instruction_memory[4] = 12'b100011100000;
    instruction_memory[5] = 12'b111100000000;

    data_memory[0] = 4'd5;
    data_memory[1] = 4'd3;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        pc_out <= 0;
        halted <= 0;

        for (i = 0; i < 4; i = i + 1)
            registers[i] <= 0;
    end
    else if (!halted) begin
        case (opcode)

            4'b0110: registers[rd] <= data_memory[immediate];

            4'b1000: registers[rd] <= registers[rs];

            4'b0000: registers[rd] <= registers[rd] + registers[rs];

            4'b0001: registers[rd] <= registers[rd] - registers[rs];

            4'b0010: registers[rd] <= registers[rd] & registers[rs];

            4'b0011: registers[rd] <= registers[rd] | registers[rs];

            4'b0100: registers[rd] <= registers[rd] ^ registers[rs];

            4'b0101: registers[rd] <= ~registers[rs];

            4'b1111: halted <= 1;

            default: begin end

        endcase

        if (opcode != 4'b1111)
            pc_out <= pc_out + 1;
    end
end

endmodule
