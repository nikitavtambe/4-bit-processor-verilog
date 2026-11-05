module control_unit(
    input [3:0] opcode,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg halt,
    output reg [2:0] alu_sel
);

always @(*) begin

    // Default control signals
    reg_write = 0;
    mem_read = 0;
    mem_write = 0;
    alu_src = 0;
    halt = 0;
    alu_sel = 3'b000;

    case(opcode)

        // ADD
        4'b0000: begin
            reg_write = 1;
            alu_sel = 3'b000;
        end

        // SUB
        4'b0001: begin
            reg_write = 1;
            alu_sel = 3'b001;
        end

        // AND
        4'b0010: begin
            reg_write = 1;
            alu_sel = 3'b010;
        end

        // OR
        4'b0011: begin
            reg_write = 1;
            alu_sel = 3'b011;
        end

        // XOR
        4'b0100: begin
            reg_write = 1;
            alu_sel = 3'b100;
        end

        // NOT
        4'b0101: begin
            reg_write = 1;
            alu_sel = 3'b101;
        end

        // LOAD
        4'b0110: begin
            reg_write = 1;
            mem_read = 1;
            alu_src = 1;
        end

        // STORE
        4'b0111: begin
            mem_write = 1;
            alu_src = 1;
        end

        // MOV
        4'b1000: begin
            reg_write = 1;
        end

        // HALT
        4'b1111: begin
            halt = 1;
        end

        default: begin
            reg_write = 0;
        end

    endcase

end

endmodule
