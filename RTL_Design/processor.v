module alu(
input [3:0] A,
input [3:0] B,
input [2:0] ALU_Sel,
output reg [3:0] Result,
output reg Zero,
output reg Carry
);

always @(*) begin
Carry = 0;
Result = 0;

case(ALU_Sel)
    3'b000: {Carry, Result} = {1'b0,A} + {1'b0,B};
    3'b001: Result = A - B;
    3'b010: Result = A & B;
    3'b011: Result = A | B;
    3'b100: Result = A ^ B;
    3'b101: Result = ~A;
    default: Result = 0;
endcase

Zero = (Result == 0);

end

endmodule

// ==========================================
// 2. REGISTER FILE MODULE
// ==========================================

module register_file(
input clk,
input reset,
input reg_write,
input [1:0] read_addr1,
input [1:0] read_addr2,
input [1:0] write_addr,
input [3:0] write_data,
output [3:0] read_data1,
output [3:0] read_data2
);

reg [3:0] registers [0:3];
integer i;

always @(posedge clk or posedge reset) begin
if (reset) begin
for (i=0; i<4; i=i+1)
registers[i] <= 0;
end
else if (reg_write) begin
registers[write_addr] <= write_data;
end
end

assign read_data1 = registers[read_addr1];
assign read_data2 = registers[read_addr2];

endmodule

// ==========================================
// 3. CONTROL UNIT MODULE
// ==========================================

module control_unit(
input [3:0] opcode,
output reg reg_write,
output reg mem_read,
output reg mem_write,
output reg alu_src,
output reg halt,
output reg [2:0] alu_sel
);

always @(*) begin

reg_write = 0;
mem_read = 0;
mem_write = 0;
alu_src = 0;
halt = 0;
alu_sel = 0;

case(opcode)

    4'b0000: begin
        reg_write = 1;
        alu_sel = 3'b000;
    end

    4'b0001: begin
        reg_write = 1;
        alu_sel = 3'b001;
    end

    4'b0010: begin
        reg_write = 1;
        alu_sel = 3'b010;
    end

    4'b0011: begin
        reg_write = 1;
        alu_sel = 3'b011;
    end

    4'b0100: begin
        reg_write = 1;
        alu_sel = 3'b100;
    end

    4'b0101: begin
        reg_write = 1;
        alu_sel = 3'b101;
    end

    4'b0110: begin
        reg_write = 1;
        mem_read = 1;
        alu_src = 1;
    end

    4'b0111: begin
        mem_write = 1;
        alu_src = 1;
    end

    4'b1000: begin
        reg_write = 1;
    end

    4'b1111: begin
        halt = 1;
    end

    default: begin
        reg_write = 0;
    end

endcase

end

endmodule

// ==========================================
// 4. INSTRUCTION MEMORY MODULE
// ==========================================

module instruction_memory(
input [3:0] address,
output reg [11:0] instruction
);

reg [11:0] memory [0:15];
integer i;

initial begin

for (i=0; i<16; i=i+1)
    memory[i] = 12'b000000000000;

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

// ==========================================
// 5. DATA MEMORY MODULE
// ==========================================

module data_memory(
input clk,
input reset,
input mem_read,
input mem_write,
input [3:0] address,
input [3:0] write_data,
output reg [3:0] read_data
);

reg [3:0] memory [0:15];
integer i;

always @(posedge clk or posedge reset) begin

if (reset) begin
    for (i=0; i<16; i=i+1)
        memory[i] <= 0;
end

else if (mem_write) begin
    memory[address] <= write_data;
end

end

always @(*) begin
if (mem_read)
read_data = memory[address];
else
read_data = 0;
end

endmodule

// ==========================================
// 6. PROGRAM COUNTER MODULE
// ==========================================

module program_counter(
input clk,
input reset,
input enable,
input halt,
output reg [3:0] pc
);

always @(posedge clk or posedge reset) begin

if (reset)
    pc <= 0;

else if (enable && !halt)
    pc <= pc + 1'b1;

end

endmodule

// ==========================================
// 7. MAIN PROCESSOR MODULE
// ==========================================

module processor(
input clk,
input reset,
output [3:0] pc_out,
output [11:0] instruction_out,
output halted
);

wire [3:0] pc;

program_counter PC(
.clk(clk),
.reset(reset),
.enable(1'b1),
.halt(halted),
.pc(pc)
);

assign pc_out = pc;

wire [11:0] instruction;

instruction_memory IM(
.address(pc),
.instruction(instruction)
);

assign instruction_out = instruction;

wire [3:0] opcode;
wire [1:0] rd;
wire [1:0] rs;
wire [3:0] immediate;

assign opcode = instruction[11:8];
assign rd = instruction[7:6];
assign rs = instruction[5:4];
assign immediate = instruction[3:0];

wire reg_write;
wire mem_read;
wire mem_write;
wire alu_src;
wire halt;
wire [2:0] alu_sel;

control_unit CU(
.opcode(opcode),
.reg_write(reg_write),
.mem_read(mem_read),
.mem_write(mem_write),
.alu_src(alu_src),
.halt(halt),
.alu_sel(alu_sel)
);

assign halted = halt;

wire [3:0] read_data1;
wire [3:0] read_data2;
wire [3:0] write_data;

register_file RF(
.clk(clk),
.reset(reset),
.reg_write(reg_write && !halt),
.read_addr1(rs),
.read_addr2(rs),
.write_addr(rd),
.write_data(write_data),
.read_data1(read_data1),
.read_data2(read_data2)
);

wire [3:0] alu_result;
wire zero;
wire carry;

alu ALU(
.A(read_data1),
.B(immediate),
.ALU_Sel(alu_sel),
.Result(alu_result),
.Zero(zero),
.Carry(carry)
);

wire [3:0] memory_data;

data_memory DM(
.clk(clk),
.reset(reset),
.mem_read(mem_read),
.mem_write(mem_write),
.address(immediate),
.write_data(read_data1),
.read_data(memory_data)
);

assign write_data =
(opcode == 4'b0110) ? memory_data :
(opcode == 4'b1000) ? read_data1 :
alu_result;

endmodule
