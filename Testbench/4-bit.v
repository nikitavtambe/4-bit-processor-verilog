module processor_tb;

reg clk;
reg reset;

wire [3:0] pc_out;
wire halted;

processor uut (
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out),
    .halted(halted)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("processor_execution.vcd");
    $dumpvars(0, processor_tb);

    clk = 0;
    reset = 1;

    $display("4-BIT PROCESSOR EXECUTION TEST");
    $display("--------------------------------");

    #10;
    reset = 0;

    wait (halted == 1);

    #5;

    $display("R0 = %d", uut.registers[0]);
    $display("R1 = %d", uut.registers[1]);
    $display("R2 = %d", uut.registers[2]);
    $display("R3 = %d", uut.registers[3]);

    $display("--------------------------------");
    $display("PROCESSOR EXECUTION COMPLETED");

    $finish;

end

initial begin
    #200;
    $display("SIMULATION TIMEOUT");
    $finish;
end

endmodule
