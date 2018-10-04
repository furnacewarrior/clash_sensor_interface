/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 0.99.3. DO NOT MODIFY.
*/
module SPI_Ctrl
    ( // Inputs
      input  clk // clock
    , input  rst // asynchronous reset: active high
    , input [9:0] driverOut 
    , input  sensorOut 

      // Outputs
    , output wire [1:0] sensorIn 
    , output wire [9:0] driverIn 
    , output wire [1:0] clkOut // gated clock
    );
  wire [1:0] \#app_arg ;
  wire [9:0] x;
  wire  x_0;
  wire  x_1;
  wire [12:0] tup;
  wire  x_2;
  wire [2:0] x_3;
  wire [10:0] spiIn;
  wire [12:0] res;

  assign spiIn = {driverOut,sensorOut};

  assign res = {{x_0,x_1},x,\#app_arg };

  // clockGate begin 
  assign \#app_arg  = {clk,((x_2) == 1'b1)};
  // clockGate end

  assign x = tup[9:0];

  assign x_0 = x_3[1:1];

  assign x_1 = x_3[0:0];

  SPI_Ctrl_spiCtrl_sspiCtrl SPI_Ctrl_spiCtrl_sspiCtrl_tup
    ( .result (tup)
    , .clk (clk)
    , .rst (rst)
    , .\input  (spiIn) );

  assign x_2 = x_3[2:2];

  assign x_3 = tup[12:10];

  assign sensorIn = res[12:11];

  assign driverIn = res[10:1];

  assign clkOut = res[0:0];
endmodule

