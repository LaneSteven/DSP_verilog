`timescale 1ns / 1ps


module testbench;

reg clk;
reg signed [7:0] a;
reg signed [7:0] d;
reg signed [7:0] b;

initial 
begin
    clk = 1;
    a = 8'b1000_0000;
    d = 8'b1111_1111;
    b = 8'b0000_0001;
end

always #10 clk = ~clk;

wire [15:0] ab;
wire [15:0] db;
dsp_for_2int8 u_dsp_for_2int8
(
    .clk(clk),
    .din_a(a),
    .din_d(d),
    .din_b(b),
    .dout_ab(ab),
    .dout_db(db)
);
endmodule
