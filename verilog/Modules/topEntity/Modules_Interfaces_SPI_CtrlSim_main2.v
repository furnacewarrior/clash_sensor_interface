/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 0.99.3. DO NOT MODIFY.
*/
module Modules_Interfaces_SPI_CtrlSim_main2
    ( // Inputs
      input  clk // clock
    , input  rst // asynchronous reset: active high
    , input [17:0] \input  

      // Outputs
    , output wire [19:0] result 
    );
  wire  mosi;
  wire [15:0] counter;
  wire [15:0] counterDelay;
  wire  cs;
  wire [14:0] dataOut;
  wire  nextOutput;
  wire  clkOut;
  wire  busyOut;
  wire [1:0] stateL;
  wire [15:0] ds1;
  reg [68:0] s1;
  reg [68:0] result_0;
  reg [68:0] \#s1_case_alt ;
  reg [68:0] \#s1_case_alt_0 ;
  wire [68:0] \$j1 ;
  wire [68:0] \$j ;
  wire [15:0] \#$j1_app_arg ;
  reg [14:0] \#s1_app_arg ;
  wire [15:0] \#$smain_$sshiftBitInOutOut ;
  wire [14:0] buffer;
  reg [14:0] \#$smain_$sshiftBitInOutOut_app_arg ;
  wire  miso1;
  wire [14:0] ds1_0;
  wire [16:0] \input' ;
  wire  \#s1_case_alt_selection_res ;
  wire  \#s1_case_alt_0_selection_res ;

  assign result = {{clkOut,cs,mosi}
                  ,{dataOut,nextOutput,busyOut}};

  assign mosi = ds1[0:0];

  assign counter = s1[68:53];

  assign counterDelay = s1[52:37];

  assign cs = s1[20:20];

  assign dataOut = s1[19:5];

  assign nextOutput = s1[4:4];

  assign clkOut = s1[3:3];

  assign busyOut = s1[2:2];

  assign stateL = s1[1:0];

  assign ds1 = s1[36:21];

  // register begin
  always @(posedge clk or posedge rst) begin : Modules_Interfaces_SPI_CtrlSim_main2_register
    if (rst) begin
      s1 <= {16'd0,16'd0,{15'b000000000000000,1'b1},1'b0,15'b000000000000000,1'b0,1'b0,1'b0,2'd3};
    end else begin
      s1 <= result_0;
    end
  end
  // register end

  always @(*) begin
    case(stateL)
      2'b00 : result_0 = \$j ;
      2'b01 : result_0 = \#s1_case_alt ;
      2'b10 : result_0 = \$j1 ;
      default : result_0 = \#s1_case_alt_0 ;
    endcase
  end

  assign \#s1_case_alt_selection_res  = counter < 16'd14;

  always @(*) begin
    if(\#s1_case_alt_selection_res )
      \#s1_case_alt  = \$j ;
    else
      \#s1_case_alt  = {16'd0
                       ,16'd0
                       ,\#$smain_$sshiftBitInOutOut 
                       ,1'b0
                       ,\#s1_app_arg 
                       ,1'b1
                       ,1'b1
                       ,1'b1
                       ,2'd2};
  end

  assign \#s1_case_alt_0_selection_res  = counterDelay >= 16'd0;

  always @(*) begin
    if(\#s1_case_alt_0_selection_res )
      \#s1_case_alt_0  = {16'd0
                         ,16'd0
                         ,\#$smain_$sshiftBitInOutOut 
                         ,1'b0
                         ,dataOut
                         ,1'b0
                         ,1'b1
                         ,1'b1
                         ,2'd0};
    else
      \#s1_case_alt_0  = \$j1 ;
  end

  assign \$j1  = {16'd0
                 ,counterDelay + 16'd1
                 ,\#$j1_app_arg 
                 ,1'b1
                 ,dataOut
                 ,1'b0
                 ,1'b0
                 ,1'b0
                 ,2'd3};

  assign \$j  = {counter + 16'd1
                ,16'd0
                ,\#$j1_app_arg 
                ,1'b0
                ,dataOut
                ,1'b0
                ,1'b1
                ,1'b1
                ,2'd1};

  Modules_Interfaces_SPI_CtrlSim_main_sshiftBitInOut Modules_Interfaces_SPI_CtrlSim_main_sshiftBitInOut_j1_app_arg
    ( .result (\#$j1_app_arg )
    , .eta (buffer)
    , .eta1 (miso1) );

  // replaceBit start
  always @(*) begin
    \#s1_app_arg  = (buffer << (64'sd1));
    \#s1_app_arg [(64'sd0)] = miso1;
  end
  // replaceBit end

  Modules_Interfaces_SPI_CtrlSim_main_sshiftBitInOut Modules_Interfaces_SPI_CtrlSim_main_sshiftBitInOut_smain_sshiftBitInOutOut
    ( .result (\#$smain_$sshiftBitInOutOut )
    , .eta (\#$smain_$sshiftBitInOutOut_app_arg )
    , .eta1 (miso1) );

  assign buffer = ds1[15:1];

  always @(*) begin
    case(stateL)
      2'b01 : \#$smain_$sshiftBitInOutOut_app_arg  = buffer;
      default : \#$smain_$sshiftBitInOutOut_app_arg  = ds1_0;
    endcase
  end

  assign miso1 = \input [0:0];

  assign ds1_0 = \input' [16:2];

  assign \input'  = \input [17:1];
endmodule

