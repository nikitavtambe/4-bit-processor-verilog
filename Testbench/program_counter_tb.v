module program_counter_tb;

reg clk;
reg reset;
reg enable;
reg halt;

wire [3:0] pc;

program_counter uut(
.clk(clk),
.reset(reset),
.enable(enable),
.halt(halt),
.pc(pc)
);

// Clock generation
always #5 clk = ~clk;

initial begin

$dumpfile("program_counter.vcd");
$dumpvars(0, program_counter_tb);

clk = 0;
reset = 1;
enable = 0;
halt = 0;

#10;
reset = 0;

enable = 1;

#10;
$display("PC = %d", pc);

#10;
$display("PC = %d", pc);

#10;
$display("PC = %d", pc);

// Test halt
halt = 1;

#10;
$display("PC after HALT = %d", pc);

$display("PROGRAM COUNTER TEST COMPLETED");

$finish;

end

endmodule
