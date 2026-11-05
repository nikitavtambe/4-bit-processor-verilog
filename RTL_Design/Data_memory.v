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

// Memory write and reset
always @(posedge clk or posedge reset) begin

if (reset) begin
    for (i = 0; i < 16; i = i + 1)
        memory[i] <= 4'b0000;
end

else if (mem_write) begin
    memory[address] <= write_data;
end

end

// Memory read
always @(*) begin

if (mem_read)
    read_data = memory[address];
else
    read_data = 4'b0000;

end

endmodule
