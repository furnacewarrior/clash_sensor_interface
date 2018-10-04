/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 0.99.3. DO NOT MODIFY.
*/
module SPI_Ctrl_spiCtrl_sspiCtrl
    ( // Inputs
      input  clk // clock
    , input  rst // asynchronous reset: active high
    , input [10:0] \input  

      // Outputs
    , output wire [12:0] result 
    );
  wire  mosi;
  wire [2:0] counter;
  wire  cs;
  wire [7:0] dataOut;
  wire  nextOutput;
  wire  clkOut;
  wire  busyOut;
  wire [2:0] stateL;
  wire [8:0] ds1;
  reg [26:0] s1;
  reg [26:0] result_0;
  reg [26:0] \#s1_case_alt ;
  reg [26:0] result_1;
  reg [7:0] \#app_arg ;
  wire [8:0] \#$sshiftBitInOutOut ;
  reg [7:0] \#$sshiftBitInOutOut_app_arg ;
  wire [7:0] ds1_0;
  wire  miso1;
  reg [26:0] \#s1_case_alt_0 ;
  wire  \#s1_case_scrut ;
  reg [2:0] \#spiCtrlOut_$jOut_app_arg ;
  wire [7:0] buffer;
  reg [26:0] \#s1_case_alt_1 ;
  wire  ds3;
  wire  ds2;
  reg [2:0] \#spiCtrlOut_$jOut_case_alt ;
  reg [2:0] \#spiCtrlOut_$jOut_case_alt_0 ;
  reg [2:0] \#spiCtrlOut_$jOut_case_alt_1 ;
  wire [9:0] \input'1 ;
  wire  \#spiCtrlOut_$jOut_case_scrut ;
  reg [2:0] \#spiCtrlOut_$jOut_case_alt_2 ;
  wire  \#spiCtrlOut_$jOut_case_scrut_0 ;

  assign result = {{clkOut,cs,mosi}
                  ,{dataOut,nextOutput,busyOut}};

  assign mosi = ds1[0:0];

  assign counter = s1[26:24];

  assign cs = s1[14:14];

  assign dataOut = s1[13:6];

  assign nextOutput = s1[5:5];

  assign clkOut = s1[4:4];

  assign busyOut = s1[3:3];

  assign stateL = s1[2:0];

  assign ds1 = s1[23:15];

  // register begin
  always @(posedge clk or posedge rst) begin : SPI_Ctrl_spiCtrl_sspiCtrl_register
    if (rst) begin
      s1 <= {3'd7,{8'b00000000,1'b1},1'b0,8'b00000000,1'b0,1'b0,1'b0,3'd4};
    end else begin
      s1 <= result_0;
    end
  end
  // register end

  always @(*) begin
    case(stateL)
      3'd0 : result_0 = \#s1_case_alt ;
      3'd1 : result_0 = result_1;
      3'd2 : result_0 = result_1;
      3'd3 : result_0 = \#s1_case_alt_0 ;
      3'd4 : result_0 = \#s1_case_alt_1 ;
      default : result_0 = result_1;
    endcase
  end

  always @(*) begin
    if(\#s1_case_scrut )
      \#s1_case_alt  = result_1;
    else
      \#s1_case_alt  = \#s1_case_alt_0 ;
  end

  always @(*) begin
    case(\#spiCtrlOut_$jOut_app_arg )
      3'd0 : result_1 = {counter + 3'd1
                        ,\#$sshiftBitInOutOut 
                        ,1'b0
                        ,dataOut
                        ,1'b0
                        ,1'b1
                        ,1'b1
                        ,\#spiCtrlOut_$jOut_app_arg };
      3'd1 : result_1 = {3'd0
                        ,\#$sshiftBitInOutOut 
                        ,1'b0
                        ,\#app_arg 
                        ,1'b1
                        ,1'b1
                        ,1'b1
                        ,\#spiCtrlOut_$jOut_app_arg };
      3'd2 : result_1 = {3'd7
                        ,ds1
                        ,1'b1
                        ,\#app_arg 
                        ,1'b1
                        ,1'b0
                        ,1'b0
                        ,\#spiCtrlOut_$jOut_app_arg };
      3'd3 : result_1 = {3'd7
                        ,ds1
                        ,1'b0
                        ,dataOut
                        ,1'b0
                        ,1'b0
                        ,1'b1
                        ,\#spiCtrlOut_$jOut_app_arg };
      3'd4 : result_1 = {3'd7
                        ,ds1
                        ,1'b1
                        ,dataOut
                        ,1'b0
                        ,1'b0
                        ,1'b0
                        ,\#spiCtrlOut_$jOut_app_arg };
      default : result_1 = s1;
    endcase
  end

  // replaceBit start
  always @(*) begin
    \#app_arg  = (buffer << (64'sd1));
    \#app_arg [(64'sd0)] = miso1;
  end
  // replaceBit end

  SPI_Ctrl_shiftBitInOut SPI_Ctrl_shiftBitInOut_sshiftBitInOutOut
    ( .result (\#$sshiftBitInOutOut )
    , .eta (\#$sshiftBitInOutOut_app_arg )
    , .eta1 (miso1) );

  always @(*) begin
    case(\#spiCtrlOut_$jOut_app_arg )
      3'd0 : \#$sshiftBitInOutOut_app_arg  = buffer;
      default : \#$sshiftBitInOutOut_app_arg  = ds1_0;
    endcase
  end

  assign ds1_0 = \input'1 [9:2];

  assign miso1 = \input [0:0];

  always @(*) begin
    if(\#spiCtrlOut_$jOut_case_scrut )
      \#s1_case_alt_0  = \#s1_case_alt_1 ;
    else
      \#s1_case_alt_0  = result_1;
  end

  assign \#s1_case_scrut  = counter < 3'd7;

  always @(*) begin
    case(stateL)
      3'd0 : \#spiCtrlOut_$jOut_app_arg  = \#spiCtrlOut_$jOut_case_alt_0 ;
      3'd1 : \#spiCtrlOut_$jOut_app_arg  = 3'd0;
      3'd2 : \#spiCtrlOut_$jOut_app_arg  = 3'd4;
      3'd3 : \#spiCtrlOut_$jOut_app_arg  = \#spiCtrlOut_$jOut_case_alt_1 ;
      3'd4 : \#spiCtrlOut_$jOut_app_arg  = \#spiCtrlOut_$jOut_case_alt ;
      default : \#spiCtrlOut_$jOut_app_arg  = 3'd0;
    endcase
  end

  assign buffer = ds1[8:1];

  always @(*) begin
    if(\#spiCtrlOut_$jOut_case_scrut_0 )
      \#s1_case_alt_1  = result_1;
    else
      \#s1_case_alt_1  = result_1;
  end

  assign ds3 = \input'1 [0:0];

  assign ds2 = \input'1 [1:1];

  always @(*) begin
    if(\#spiCtrlOut_$jOut_case_scrut_0 )
      \#spiCtrlOut_$jOut_case_alt  = 3'd1;
    else
      \#spiCtrlOut_$jOut_case_alt  = 3'd4;
  end

  always @(*) begin
    if(\#s1_case_scrut )
      \#spiCtrlOut_$jOut_case_alt_0  = 3'd0;
    else
      \#spiCtrlOut_$jOut_case_alt_0  = \#spiCtrlOut_$jOut_case_alt_1 ;
  end

  always @(*) begin
    if(\#spiCtrlOut_$jOut_case_scrut )
      \#spiCtrlOut_$jOut_case_alt_1  = \#spiCtrlOut_$jOut_case_alt_2 ;
    else
      \#spiCtrlOut_$jOut_case_alt_1  = 3'd3;
  end

  assign \input'1  = \input [10:1];

  assign \#spiCtrlOut_$jOut_case_scrut  = ds3 == (1'b0);

  always @(*) begin
    if(\#spiCtrlOut_$jOut_case_scrut_0 )
      \#spiCtrlOut_$jOut_case_alt_2  = 3'd1;
    else
      \#spiCtrlOut_$jOut_case_alt_2  = 3'd2;
  end

  assign \#spiCtrlOut_$jOut_case_scrut_0  = ds2 == (1'b0);
endmodule

