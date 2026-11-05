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

// Reset and write operation
always @(posedge clk or posedge reset) begin

    if (reset) begin
        for (i = 0; i < 4; i = i + 1)
            registers[i] <= 4'b0000;
    end

    else if (reg_write) begin
        registers[write_addr] <= write_data;
    end

end

// Read operation
assign read_data1 = registers[read_addr1];
assign read_data2 = registers[read_addr2];

endmodule
