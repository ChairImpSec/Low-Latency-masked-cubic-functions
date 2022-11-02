`timescale 1ns / 1ps
/*
* -----------------------------------------------------------------
* AUTHOR  : Aein Rezaei Shahmirzadi (aein.rezaeishahmirzadi@rub.de)
* DOCUMENT: "Low-Latency and Low-Randomness Second-Order Masked Cubic Functions", TCHES 2023, Issue 1.
* -----------------------------------------------------------------
*
* Copyright (c) 2021, Aein Rezaei Shahmirzadi
*
* All rights reserved.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTERS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
* Please see LICENSE and README for license and further instructions.
*/

module Cipher_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [63:0] input_s1;
	reg [63:0] input_s2;
	reg [63:0] input_s3;
	reg [127:0] Rand;
	reg [69:0] r;
	reg [215:0] Static_r;
	reg [31:0] Dynamic_r;
	reg [127:0] Key;
	reg [127:0] Key1;
	reg [127:0] Key2;
	reg [127:0] Key3;
	reg enc_dec;

	// Outputs
	wire [63:0] output_s1;
	wire [63:0] output_s2;
	wire [63:0] output_s3;
	wire [63:0] out;
	wire done;
	integer i;

	// Instantiate the Unit Under Test (UUT)
	Cipher uut (
		.clk(clk), 
		.reset(reset), 
		.input_s1(input_s1), 
		.input_s2(input_s2), 
		.input_s3(input_s3), 
		.output_s1(output_s1), 
		.output_s2(output_s2), 
		.output_s3(output_s3), 
		//.r(r), 
		.Dynamic_r(Dynamic_r), 
		.Static_r(Static_r), 
		.Key1(Key1), 
		.Key2(Key2), 
		.Key3(Key3), 
		.enc_dec(enc_dec), 
		.done(done)
	);
assign out = output_s1 ^ output_s2 ^ output_s3;
	initial begin
		// Initialize Inputs
		Dynamic_r = 0;
		Static_r = 0;
		clk = 0;
		reset = 0;
		input_s1 = 64'h0123456789ABCDEF;
		input_s2 = 0;
		input_s3 = 0;
		Rand = {$random,$random,$random,$random} & 0;
		Key = 128'hFEDCBA9876543210FEDCBA9876543210;
		Key1 = Key ^ Rand;
		Key2 = Rand;
		Key3 = 0;
		enc_dec = 0;
		
		#10;
		reset = 1;
		#21;

        reset = 0;
		// Add stimulus here
		 
		 #1000
		 
		reset = 1;
		input_s1 = 64'hD9830DF8619840CC;
		input_s2 = 0;
		input_s3 = 0;
		enc_dec = 1;
		
		#21;
		
		reset = 0;
		
		
	end
      always #5 clk = ~clk;
endmodule

