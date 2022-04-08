`timescale 1ns / 1ps

module dsp_for_2int8
(
    input               clk,
    input      [7 : 0]  din_a,
    input      [7 : 0]  din_b,
    input      [7 : 0]  din_d,
    output     [15 : 0] dout_ab,
    output     [15 : 0] dout_db
);

reg         [1 : 0]  dly     = 1'd0;
reg  signed [32 : 0] p;
reg  signed [32 : 0] p_m;
reg  signed [32 : 0] p_n;
wire signed [15 : 0] p_ab;
wire signed [15 : 0] p_db;

wire signed[24:0]A;
wire signed[24:0]D;
assign A = {din_a, 17'd0};

assign D = {{17{din_d[7]}}, din_d};

wire signed [25:0] M;
wire signed [25:0] N;
assign M = $signed(A+D);
assign N = $signed(A)+$signed(D);
always@(posedge clk )begin
    p <= $signed(A+D) * $signed(din_b);
    p_m <= $signed(M) * $signed(din_b) ;
    p_n <= $signed(N) * $signed(din_b) ;
end

assign p_ab = p[32:17];
assign p_db = p[15: 0];

assign dout_ab = ((din_a==8'b1000_0000) & din_d[7])? -(p_ab + p_db[15]):(p_ab + p_db[15]);   //p_ab;
assign dout_db = p_db;

endmodule

