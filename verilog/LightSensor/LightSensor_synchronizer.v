/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 0.99.1. DO NOT MODIFY.
*/
module LightSensor_synchronizer
    ( // Inputs
      input  clkA // clock
    , input  rstA // asynchronous reset: active high
    , input  clkB // clock
    , input  rstB // asynchronous reset: active high
    , input [19:0] ds1 

      // Outputs
    , output wire [19:0] result 
    );
  wire [9:0] domAOut;
  wire [9:0] domBOut;
  wire [19:0] result_0;
  wire [7:0] dataOutA;
  wire  syncOutA;
  wire  busyOutA;
  wire [7:0] dataOutB;
  wire  syncOutB;
  wire  busyOutB;
  wire [9:0] ds2;
  wire [9:0] ds1_0;
  wire [7:0] ds1_1;
  wire  ds2_0;
  wire  ds3;
  wire [7:0] ds1_2;
  wire  ds2_1;
  wire  ds3_0;
  wire [9:0] domAIn;
  wire [9:0] domBIn;
  wire [9:0] ds2_fun_arg;
  wire [9:0] ds1_0_fun_arg;

  assign result = {domAOut,domBOut};

  assign domAOut = result_0[19:10];

  assign domBOut = result_0[9:0];

  assign result_0 = {{dataOutA,syncOutA,busyOutA}
                    ,{dataOutB,syncOutB,busyOutB}};

  assign dataOutA = ds1_0[9:2];

  assign syncOutA = ds1_0[1:1];

  assign busyOutA = ds2[0:0];

  assign dataOutB = ds2[9:2];

  assign syncOutB = ds2[1:1];

  assign busyOutB = ds1_0[0:0];

  assign ds2_fun_arg = {ds1_1,ds2_0,ds3};

  SyncSafe_syncSafe_ssync_safe SyncSafe_syncSafe_ssync_safe_ds2
    ( .result (ds2)
    , .clkA (clkA)
    , .rstA (rstA)
    , .clkB (clkB)
    , .rstB (rstB)
    , .ds (ds2_fun_arg) );

  assign ds1_0_fun_arg = {ds1_2,ds2_1,ds3_0};

  SyncSafe_syncSafe_ssync_safe_0 SyncSafe_syncSafe_ssync_safe_0_ds1_0
    ( .result (ds1_0)
    , .clkA (clkB)
    , .rstA (rstB)
    , .clkB (clkA)
    , .rstB (rstA)
    , .ds (ds1_0_fun_arg) );

  assign ds1_1 = domAIn[9:2];

  assign ds2_0 = domAIn[1:1];

  assign ds3 = domBIn[0:0];

  assign ds1_2 = domBIn[9:2];

  assign ds2_1 = domBIn[1:1];

  assign ds3_0 = domAIn[0:0];

  assign domAIn = ds1[19:10];

  assign domBIn = ds1[9:0];
endmodule

