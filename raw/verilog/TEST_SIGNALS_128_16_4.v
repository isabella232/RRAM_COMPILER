//-----------------------------------------------//
// THIS CODE HAS BEEN GENERATED BY RRAM COMPILER //
//-----------------------------------------------//


// MODIFY NAME //
module TEST_SIGNALS_128_16_4 (
// END MODIFY NAME //
EN,
RW,
X_ADDRESS_IN,
Y_ADDRESS_IN,
clk,
reset,
Z_WR
);

// SKILL MODIFICATIONS //
parameter B_SIZE = 4;
parameter X_SIZE = 5;
parameter Y_SIZE = 4;
// END MODIFY PARAMETERS //


//localparam IDLE = 3'b000;
//localparam RPH1 = 3'b001;
//localparam RPH2 = 3'b010;
//localparam RPH3 = 3'b011;
//localparam WPH1 = 3'b100;

// Outputs
output			EN;
output			RW;
output	[X_SIZE-1:0]	X_ADDRESS_IN;
output	[Y_SIZE-1:0]	Y_ADDRESS_IN;
output			reset;
output	[B_SIZE-1:0]	Z_WR;

// Inputs
input			clk;

// Registers
reg			EN;
reg			RW;
reg	[X_SIZE-1:0]	X_ADDRESS_IN;
reg	[Y_SIZE-1:0]	Y_ADDRESS_IN;
reg			reset;
reg	[B_SIZE-1:0]	Z_WR;

// Wire
wire			clk;

// CLOCK
//parameter CLOCK_PULSE_DURATION = 20;
//always #(CLOCK_PULSE_DURATION/2) clk = ~clk;



// TESTBENCH
initial begin
	reset = 0;
	//clk = 0;
	EN = 0;
	RW = 0;
	X_ADDRESS_IN = 0;
	Y_ADDRESS_IN = 0;


	repeat (8)
      @(negedge clk) #1;
	  
	@ (posedge clk) begin
		 reset <= 1;
	end
	repeat (2)
      @(negedge clk) #1;
	  
	@ (posedge clk) begin
		 reset <= 0;
	end
	#1
	write_memory((1<<X_SIZE)-1-1, (1<<Y_SIZE)-1, {B_SIZE/2{2'b10}});
	write_memory((1<<X_SIZE)-1-1, (1<<Y_SIZE)-1, {B_SIZE/2{2'b01}});

	repeat (10)
      @(negedge clk) #1;
	//read_memory(2, 4);
	read_memory((1<<X_SIZE)-1, (1<<Y_SIZE)-1);
	repeat (10)
      @(negedge clk) #1;
	read_memory((1<<X_SIZE)-1, (1<<Y_SIZE)-1);
	//read_memory((1<<X_SIZE)-1-1, (1<<Y_SIZE)-1);
	repeat (10)
      @(negedge clk) #1;
	

$display("SUCCESS");
$finish;	
end


task write_memory;
input [X_SIZE-1:0]	X_ADDRESS_IN;
input [Y_SIZE-1:0]	Y_ADDRESS_IN;
input [B_SIZE-1:0]	VALUE;
begin: WRITE_TASK
	//reg [(1<<X_SIZE):0] temp_p_en;
	//reg [((1<<Y_SIZE)-1):0]	temp_sel;
	//temp_p_en[(1<<X_SIZE)-1:0] =  1<<X_ADDRESS_IN;
	//temp_p_en[1<<X_SIZE] = 0;
	//temp_sel = 1 << Y_ADDRESS_IN;
	@ (posedge clk) begin
		TEST_SIGNALS_128_16_4.X_ADDRESS_IN <= X_ADDRESS_IN;
		TEST_SIGNALS_128_16_4.Y_ADDRESS_IN <= Y_ADDRESS_IN;
		TEST_SIGNALS_128_16_4.EN <= 1;
		TEST_SIGNALS_128_16_4.RW <= 0;
		TEST_SIGNALS_128_16_4.Z_WR <= VALUE;
	end
	@ (posedge clk) begin
		TEST_SIGNALS_128_16_4.EN <= 0;		
	end	
	@ (negedge clk) begin
		TEST_SIGNALS_128_16_4.Z_WR <= {B_SIZE{1'bz}};
	end
end
endtask

task read_memory;
input [X_SIZE-1:0]	X_ADDRESS_IN;
input [Y_SIZE-1:0]	Y_ADDRESS_IN;
begin: READ_TASK
	//reg [(1<<X_SIZE):0] temp_p_en;
	//reg [((1<<Y_SIZE)-1):0]	temp_sel;
	//temp_p_en[(1<<X_SIZE)-1:0] =  1<<X_ADDRESS_IN;
	//temp_p_en[1<<X_SIZE] = 1;
	//temp_sel = 1 << Y_ADDRESS_IN;
	@ (posedge clk) begin
		TEST_SIGNALS_128_16_4.X_ADDRESS_IN <= X_ADDRESS_IN;
		TEST_SIGNALS_128_16_4.Y_ADDRESS_IN <= Y_ADDRESS_IN;
		TEST_SIGNALS_128_16_4.EN <= 1;
		TEST_SIGNALS_128_16_4.RW <= 1;
	
	end
	@ (posedge clk) begin
		TEST_SIGNALS_128_16_4.EN <= 0;		
	end	
	@ (negedge clk) #1;
	@ (negedge clk) #1; //begin #1;
		//if (controller1.controller1.state != RPH2) begin
		//	$display("%0ds \t ERROR on STATE on RPH2\n", $time);
		//	$finish;
		//end
	//end
	@ (negedge clk) #1;
		//if (controller1.controller1.state != RPH3) begin
		//	$display("%0ds \t ERROR on STATE on RPH3\n", $time);
		//	$finish;
		//end
end
endtask
endmodule
