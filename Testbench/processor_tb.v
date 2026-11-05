module processor_tb;

reg clk;
reg reset;

wire [3:0] pc_out;
wire [11:0] instruction_out;
wire halted;

// Processor connection
processor uut(
.clk(clk),
.reset(reset),
.pc_out(pc_out),
.instruction_out(instruction_out),
.halted(halted)
);

// Clock generation
always #5 clk = ~clk;

initial begin

$dumpfile("processor.vcd");
$dumpvars(0, processor_tb);

clk = 0;
reset = 1;

$display("4-BIT PROCESSOR SIMULATION");
$display("--------------------------");

#10;
reset = 0;

// Display processor execution
$monitor("Time=%0t | PC=%d | Instruction=%b | HALT=%b",
         $time, pc_out, instruction_out, halted);

// Wait until processor executes HALT
wait(halted == 1'b1);

#10;

$display("--------------------------");
$display("PROCESSOR HALTED SUCCESSFULLY");
$display("FINAL PC = %d", pc_out);
$display("PROCESSOR TEST COMPLETED");

$finish;

end

// Safety timeout
initial begin
#200;
$display("Simulation timeout");
$finish;
end

endmodule
