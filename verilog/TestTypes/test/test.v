/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 0.99.3. DO NOT MODIFY.
*/
module test
    ( // Inputs
      input  clk // clock
    , input  rst // asynchronous reset: active high
    , input [9:0] sigIn 

      // Outputs
    , output wire [7:0] sigOut 
    );
  reg [9:0] s1;
  wire [7:0] ds1;
  wire  ds2;
  wire  ds3;

  assign sigOut = s1[9:2];

  // register begin
  always @(posedge clk or posedge rst) begin : test_register
    if (rst) begin
      s1 <= {8'b00000000,1'b0,1'b0};
    end else begin
      s1 <= {ds1,ds2,ds3};
    end
  end
  // register end

  assign ds1 = sigIn[9:2];

  assign ds2 = s1[1:1];

  assign ds3 = s1[0:0];
endmodule

