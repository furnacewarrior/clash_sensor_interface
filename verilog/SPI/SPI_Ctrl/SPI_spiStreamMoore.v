/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 0.99.3. DO NOT MODIFY.
*/
module SPI_spiStreamMoore
    ( // Inputs
      input  eta // clock
    , input  eta_0 // asynchronous reset: active high
    , input [10:0] eta_1 

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
  wire [1:0] stateL;
  wire [8:0] ds1;
  reg [25:0] s1;
  reg [25:0] result_0;
  reg [25:0] \#s1_case_alt ;
  wire [25:0] \$j ;
  wire [8:0] \#$j_app_arg ;
  wire [8:0] \#s1_app_arg ;
  reg [7:0] \#s1_app_arg_0 ;
  wire [7:0] buffer;
  wire [7:0] ds1_0;
  wire  miso1;
  wire [9:0] \input' ;
  wire  \#s1_case_alt_selection_res ;

  assign result = {{clkOut,cs,mosi}
                  ,{dataOut,nextOutput,busyOut}};

  assign mosi = ds1[0:0];

  assign counter = s1[25:23];

  assign cs = s1[13:13];

  assign dataOut = s1[12:5];

  assign nextOutput = s1[4:4];

  assign clkOut = s1[3:3];

  assign busyOut = s1[2:2];

  assign stateL = s1[1:0];

  assign ds1 = s1[22:14];

  // register begin
  always @(posedge eta or posedge eta_0) begin : SPI_spiStreamMoore_register
    if (eta_0) begin
      s1 <= {3'd7,{8'b00000000,1'b1},1'b0,8'b00000000,1'b0,1'b0,1'b0,2'd0};
    end else begin
      s1 <= result_0;
    end
  end
  // register end

  always @(*) begin
    case(stateL)
      2'b01 : result_0 = \#s1_case_alt ;
      default : result_0 = \$j ;
    endcase
  end

  assign \#s1_case_alt_selection_res  = counter < 3'd7;

  always @(*) begin
    if(\#s1_case_alt_selection_res )
      \#s1_case_alt  = \$j ;
    else
      \#s1_case_alt  = {3'd0
                       ,\#s1_app_arg 
                       ,1'b0
                       ,\#s1_app_arg_0 
                       ,1'b1
                       ,1'b1
                       ,1'b0
                       ,2'd2};
  end

  assign \$j  = {counter + 3'd1
                ,\#$j_app_arg 
                ,1'b0
                ,dataOut
                ,1'b0
                ,1'b1
                ,1'b1
                ,2'd1};

  SPI_shiftBitInOut SPI_shiftBitInOut_j_app_arg
    ( .result (\#$j_app_arg )
    , .eta (buffer)
    , .eta1 (miso1) );

  SPI_shiftBitInOut SPI_shiftBitInOut_s1_app_arg
    ( .result (\#s1_app_arg )
    , .eta (ds1_0)
    , .eta1 (miso1) );

  // replaceBit start
  always @(*) begin
    \#s1_app_arg_0  = (buffer << (64'sd1));
    \#s1_app_arg_0 [(64'sd0)] = miso1;
  end
  // replaceBit end

  assign buffer = ds1[8:1];

  assign ds1_0 = \input' [9:2];

  assign miso1 = eta_1[0:0];

  assign \input'  = eta_1[10:1];
endmodule

