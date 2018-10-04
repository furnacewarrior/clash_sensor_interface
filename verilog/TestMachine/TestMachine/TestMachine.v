/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 0.99.3. DO NOT MODIFY.
*/
module TestMachine
    ( // Inputs
      input  clk // clock
    , input  rst // asynchronous reset: active high
    , input [7:0] dataIn 

      // Outputs
    , output wire [7:0] dataOut 
    );
  reg [2:0] \#testMachineOut_$jOut_app_arg ;
  wire [2:0] stateL;
  reg [10:0] result;
  reg [7:0] \#app_arg ;
  reg [10:0] result_0;
  reg [10:0] s1;
  wire [7:0] \#outputValue_rec ;
  wire  \#din ;

  always @(*) begin
    case(stateL)
      3'd0 : \#testMachineOut_$jOut_app_arg  = 3'd1;
      3'd1 : \#testMachineOut_$jOut_app_arg  = 3'd2;
      3'd2 : \#testMachineOut_$jOut_app_arg  = 3'd3;
      3'd3 : \#testMachineOut_$jOut_app_arg  = 3'd4;
      default : \#testMachineOut_$jOut_app_arg  = 3'd0;
    endcase
  end

  assign stateL = s1[2:0];

  always @(*) begin
    case(\#testMachineOut_$jOut_app_arg )
      3'd0 : result = {\#app_arg 
                      ,\#testMachineOut_$jOut_app_arg };
      3'd1 : result = {\#app_arg 
                      ,\#testMachineOut_$jOut_app_arg };
      3'd2 : result = {\#app_arg 
                      ,\#testMachineOut_$jOut_app_arg };
      3'd3 : result = {\#app_arg 
                      ,\#testMachineOut_$jOut_app_arg };
      3'd4 : result = {dataIn
                      ,\#testMachineOut_$jOut_app_arg };
      default : result = {11 {1'bx}};
    endcase
  end

  assign \#din  = (1'b0);

  // replaceBit start
  always @(*) begin
    \#app_arg  = (\#outputValue_rec  << (64'sd1));
    \#app_arg [(64'sd0)] = \#din ;
  end
  // replaceBit end

  always @(*) begin
    case(stateL)
      3'd0 : result_0 = result;
      3'd1 : result_0 = result;
      3'd2 : result_0 = result;
      3'd3 : result_0 = result;
      3'd4 : result_0 = result;
      default : result_0 = {11 {1'bx}};
    endcase
  end

  // register begin
  always @(posedge clk or posedge rst) begin : TestMachine_register
    if (rst) begin
      s1 <= {8'b00000000,3'd0};
    end else begin
      s1 <= result_0;
    end
  end
  // register end

  assign \#outputValue_rec  = s1[10:3];

  assign dataOut = \#outputValue_rec ;
endmodule

