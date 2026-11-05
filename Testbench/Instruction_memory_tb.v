module instruction_memory_tb;

reg [3:0] address;
wire [11:0] instruction;

instruction_memory uut(
.address(address),
.instruction(instruction)
);

initial begin

$dumpfile("instruction_memory.vcd");
$dumpvars(0, instruction_memory_tb);

$display("INSTRUCTION MEMORY TESTING");

address = 4'd0;
#10;
$display("Address 0: %b", instruction);

address = 4'd1;
#10;
$display("Address 1: %b", instruction);

address = 4'd2;
#10;
$display("Address 2: %b", instruction);

address = 4'd3;
#10;
$display("Address 3: %b", instruction);

address = 4'd4;
#10;
$display("Address 4: %b", instruction);

$display("INSTRUCTION MEMORY TEST COMPLETED");

$finish;

end

endmodule
