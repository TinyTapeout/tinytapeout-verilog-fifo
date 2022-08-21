`default_nettype none

module sevenseg_top (
  input TINY_CLK,
  input [7:0] io_in, //using io_in[0] as clk, io_in[1] as reset
  output [7:0] io_out
);

// XXX: All I really want is this: assign io_in[0] = TINY_CLK;
// But yosys errors out:
//   Net 'TINY_CLK' is multiply driven by cell port TINY_CLK.O and top level input 'io_in[0]'.
// hence the extra wire and explicit assignments. There must be a better way?
wire [7:0] io_in_x;
assign io_in_x[0] = TINY_CLK;
assign io_in_x[1] = io_in[1];
assign io_in_x[2] = io_in[2];
assign io_in_x[3] = io_in[3];
assign io_in_x[4] = io_in[4];
assign io_in_x[5] = io_in[5];
assign io_in_x[6] = io_in[6];
assign io_in_x[7] = io_in[7];

clock clock_top (
    .i_clk(io_in_x[0]),
    .i_rst(io_in_x[1]),
    .i_set_h(io_in_x[2]),
    .i_set_m(io_in_x[3]),
    .o_clk(io_out[0]),
    .o_latch(io_out[1]),
    .o_bit(io_out[2])
);

endmodule
