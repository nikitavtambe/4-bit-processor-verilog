module testbench;

reg [3:0] A, B;
reg [2:0] ALU_Sel;

wire [3:0] Result;
wire Zero, Carry;

alu uut(
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .Result(Result),
    .Zero(Zero),
    .Carry(Carry)
);

initial begin

    $dumpfile("waveform.vcd");
    $dumpvars(0, testbench);

    $display("4-BIT ALU TESTING");

    A = 4'b0011;
    B = 4'b0010;

    ALU_Sel = 3'b000;
    #10;
    $display("ADD Result = %d", Result);

    ALU_Sel = 3'b001;
    #10;
    $display("SUB Result = %d", Result);

    ALU_Sel = 3'b010;
    #10;
    $display("AND Result = %b", Result);

    ALU_Sel = 3'b011;
    #10;
    $display("OR Result = %b", Result);

    ALU_Sel = 3'b100;
    #10;
    $display("XOR Result = %b", Result);

    ALU_Sel = 3'b101;
    #10;
    $display("NOT Result = %b", Result);

    $finish;

end

endmodule
