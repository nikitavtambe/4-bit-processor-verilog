module register_file_tb;

reg clk;
reg reset;
reg reg_write;

reg [1:0] read_addr1;
reg [1:0] read_addr2;
reg [1:0] write_addr;

reg [3:0] write_data;

wire [3:0] read_data1;
wire [3:0] read_data2;

register_file uut(
.clk(clk),
.reset(reset),
.reg_write(reg_write),
.read_addr1(read_addr1),
.read_addr2(read_addr2),
.write_addr(write_addr),
.write_data(write_data),
.read_data1(read_data1),
.read_data2(read_data2)
);

// Clock generation
always #5 clk = ~clk;

initial begin

$dumpfile("register_file.vcd");
$dumpvars(0, register_file_tb);

clk = 0;
reset = 1;
reg_write = 0;

#10;
reset = 0;

// Write 5 into R0
write_addr = 2'b00;
write_data = 4'b0101;
reg_write = 1;
#10;

// Write 10 into R1
write_addr = 2'b01;
write_data = 4'b1010;
#10;

// Write 3 into R2
write_addr = 2'b10;
write_data = 4'b0011;
#10;

// Write 12 into R3
write_addr = 2'b11;
write_data = 4'b1100;
#10;

reg_write = 0;

// Read R0 and R1
read_addr1 = 2'b00;
read_addr2 = 2'b01;
#10;

$display("R0 = %d", read_data1);
$display("R1 = %d", read_data2);

// Read R2 and R3
read_addr1 = 2'b10;
read_addr2 = 2'b11;
#10;

$display("R2 = %d", read_data1);
$display("R3 = %d", read_data2);

$display("REGISTER FILE TEST COMPLETED");

$finish;

end

endmodule
