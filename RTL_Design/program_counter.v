module program_counter(
input clk,
input reset,
input enable,
input halt,
output reg [3:0] pc
);

always @(posedge clk or posedge reset) begin

if (reset)
    pc <= 4'b0000;

else if (enable && !halt)
    pc <= pc + 1'b1;

end

endmodule
