module alu(
    input [3:0] A,
    input [3:0] B,
    input [2:0] ALU_Sel,
    output reg [3:0] Result,
    output reg Zero,
    output reg Carry
);

always @(*) begin

    Carry = 0;
    Result = 4'b0000;

    case(ALU_Sel)

        3'b000: begin
            {Carry, Result} = A + B;
        end

        3'b001: begin
            Result = A - B;
        end

        3'b010: begin
            Result = A & B;
        end

        3'b011: begin
            Result = A | B;
        end

        3'b100: begin
            Result = A ^ B;
        end

        3'b101: begin
            Result = ~A;
        end

        default: begin
            Result = 4'b0000;
        end

    endcase

    Zero = (Result == 4'b0000);

end

endmodule
