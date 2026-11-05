module data_memory_tb;

reg clk;
reg reset;
reg mem_read;
reg mem_write;

reg [3:0] address;
reg [3:0] write_data;

wire [3:0] read_data;

data_memory uut(
.clk(clk),
.reset(reset),
.mem_read(mem_read),
.mem_write(mem_write),
.address(address),
.write_data(write_data),
.read_data(read_data)
);

// Clock generation
always #5 clk = ~clk;

initial begin

$dumpfile("data_memory.vcd");
$dumpvars(0, data_memory_tb);

clk = 0;
reset = 1;
mem_read = 0;
mem_write = 0;

#10;
reset = 0;

// Write data 5 into memory address 0
address = 4'd0;
write_data = 4'd5;
mem_write = 1;
#10;

// Write data 10 into memory address 1
address = 4'd1;
write_data = 4'd10;
#10;

mem_write = 0;

// Read address 0
address = 4'd0;
mem_read = 1;
#10;
$display("Memory[0] = %d", read_data);

// Read address 1
address = 4'd1;
#10;
$display("Memory[1] = %d", read_data);

$display("DATA MEMORY TEST COMPLETED");

$finish;

end

endmodule
