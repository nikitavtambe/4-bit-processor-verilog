module control_unit_tb;

reg [3:0] opcode;

wire reg_write;
wire mem_read;
wire mem_write;
wire alu_src;
wire halt;
wire [2:0] alu_sel;

control_unit uut(
.opcode(opcode),
.reg_write(reg_write),
.mem_read(mem_read),
.mem_write(mem_write),
.alu_src(alu_src),
.halt(halt),
.alu_sel(alu_sel)
);

initial begin

$dumpfile("control_unit.vcd");
$dumpvars(0, control_unit_tb);

$display("CONTROL UNIT TESTING");

// ADD
opcode = 4'b0000;
#10;
$display("ADD: reg_write=%b alu_sel=%b",
         reg_write, alu_sel);

// SUB
opcode = 4'b0001;
#10;
$display("SUB: reg_write=%b alu_sel=%b",
         reg_write, alu_sel);

// AND
opcode = 4'b0010;
#10;
$display("AND: reg_write=%b alu_sel=%b",
         reg_write, alu_sel);

// OR
opcode = 4'b0011;
#10;
$display("OR: reg_write=%b alu_sel=%b",
         reg_write, alu_sel);

// XOR
opcode = 4'b0100;
#10;
$display("XOR: reg_write=%b alu_sel=%b",
         reg_write, alu_sel);

// NOT
opcode = 4'b0101;
#10;
$display("NOT: reg_write=%b alu_sel=%b",
         reg_write, alu_sel);

// LOAD
opcode = 4'b0110;
#10;
$display("LOAD: mem_read=%b reg_write=%b",
         mem_read, reg_write);

// STORE
opcode = 4'b0111;
#10;
$display("STORE: mem_write=%b",
         mem_write);

// MOV
opcode = 4'b1000;
#10;
$display("MOV: reg_write=%b",
         reg_write);

// HALT
opcode = 4'b1111;
#10;
$display("HALT: halt=%b", halt);

$display("CONTROL UNIT TEST COMPLETED");

$finish;

end

endmodule
