/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 0.99.3. DO NOT MODIFY.
*/
module Modules_Interfaces_SPI_CtrlSim_main_sshiftBitInOut
    ( // Inputs
      input [14:0] eta 
    , input  eta1 

      // Outputs
    , output wire [15:0] result 
    );
  reg [14:0] \#app_arg ;

  // replaceBit start
  always @(*) begin
    \#app_arg  = (eta << (64'sd1));
    \#app_arg [(64'sd0)] = eta1;
  end
  // replaceBit end

  assign result = {\#app_arg , eta[15-1] };
endmodule

