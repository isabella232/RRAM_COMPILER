//-----------------------------------------------------
// Design Name 	: Controller
// File Name   	: controller_5V.v
// Function    	: Controller of the memory. It takes as arguments the addresses 
//                of a word and RW signal. It generates the necessary signals to
//                controll RRAM Array and its preipheral circuits. This the 5V circuit to be used 
//		  for the LATCH TYPE SENSE AMPLIFIER RRAM
// Coder       	: Dimitris Antoniadis
// Date		: 12/07/2021
//-----------------------------------------------------


`include "/ibe/users/da220/Cadence/WORK_TSMC180FORTE/DIGITAL/rtl/controller/controller.v"

// MODIFY NAME //
module controller_5V(
// END MODIFY NAME //
EN,
RW,
X_ADDRESS_IN,
Y_ADDRESS_IN,
P_EN,
P_NOT_EN,
N_EN,
N_NOT_EN,
SEL,
READ,
WRITE,
WRITE_2,
NOT_WRITE,
NOT_WRITE_2,
DVLP,
PRE,
EN_SA,
clk,
reset
);

// ASSUMING A M(ROWS) = 32 x 32 = N(COLUMNS) MEMORY ARRAY
// WITH WORD OF b = 4 BITS
// ----- X -----
// THEN THE NUMBER OF COLUMNS IS 32 / 4 = 8 = 2^(X_SIZE), X_SIZE = NUMBER OF BITS NEEDED TO REPRESENT ADDRESS OF COLUMNS IN BINARY.
// OR X_SIZE = LOG2(8) = LOG(N/b).
// THE ADDRESSES OF COLUMNS START FROM 0 TO 7
// SO A DECODER FROM [2:0]->[7:0] ([X_SIZE-1:0]->[(1<<X_SIZE)-1:0]) IS NEEDED 
// TO CHOSE THE CORRECT COLUMN ADDRESS.
// ----- Y ------
// THE NUMBER OF ROWS IS 32. EVERY TIME ONLY ONE ROW CAN BE SELECTED.
// A DECODER IS NEEDED FROM Y_SIZE = LOG2(M) = 5
// OR FROM [3:0]->[31:0] ([Y_SIZE-1:0]->[(1<<Y_SIZE)-1:0])


// SKILL CODE TO MODIFY HERE //
parameter B_SIZE = 4;	// WORD SIZE IN BITS 4*8 = 32
parameter X_SIZE = 3;	// BITS TO DESCRIBE ADDRESS OF WORDS COLUMN 2^3 = 8
parameter Y_SIZE = 5;	// BITS TO DESCRIBE ADDRESS OF SEL COLUMNS  2^5 = 32
// END OF SKILL MODIFICATION //


// Inputs
input 			EN;
input			RW;
input	[X_SIZE-1:0]	X_ADDRESS_IN;
input	[Y_SIZE-1:0]	Y_ADDRESS_IN;
input 			clk;
input			reset;

// Outputs
output 	[(1<<X_SIZE):0]		P_EN;
output	[(1<<X_SIZE):0]		P_NOT_EN;
output 	[((1<<X_SIZE)-1):0]	N_EN;
output	[((1<<X_SIZE)-1):0]	N_NOT_EN;
output 	[((1<<Y_SIZE)-1):0]	SEL;
output				READ;
output				WRITE;
output				NOT_WRITE;
output				DVLP;
output				PRE;
output				EN_SA;
output				WRITE_2;
output				NOT_WRITE_2;

// Power Supplies
//inout	VDD;
//inout	VSS;

// Wires
wire 			EN;
wire			RW;
wire	[X_SIZE-1:0]	X_ADDRESS_IN;
wire	[Y_SIZE-1:0]	Y_ADDRESS_IN;
wire 			clk;
wire			reset;
wire 	[(1<<X_SIZE):0]		P_EN;
wire	[(1<<X_SIZE):0]		P_NOT_EN;
wire 	[((1<<X_SIZE)-1):0]	N_EN;
wire	[((1<<X_SIZE)-1):0]	N_NOT_EN;
wire 	[((1<<Y_SIZE)-1):0]	SEL;
wire				READ;
wire				WRITE;
wire				NOT_WRITE;
wire				DVLP;
wire				PRE;
wire				EN_SA;
wire				WRITE_2;
wire				NOT_WRITE_2;

// INSTANTIATION OF CONTROLLER MODULE
controller #(B_SIZE, X_SIZE, Y_SIZE) controller1(
.EN			(EN),
.RW			(RW),
.X_ADDRESS_IN		(X_ADDRESS_IN),
.Y_ADDRESS_IN		(Y_ADDRESS_IN),
.P_DECODER_OUT		(P_EN[(1<<X_SIZE)-1:0]),
.NOT_P_DECODER_OUT	(P_NOT_EN[(1<<X_SIZE)-1:0]),
.N_DECODER_OUT		(N_EN[(1<<X_SIZE)-1:0]),
.NOT_N_DECODER_OUT	(N_NOT_EN[(1<<X_SIZE)-1:0]),
.Y_DECODER_OUT		(SEL),
.P_EN_REF		(P_EN[(1<<X_SIZE)]),
.NOT_P_EN_REF		(P_NOT_EN[(1<<X_SIZE)]),
.READ			(READ),
.WRITE			(WRITE),
.DVLP			(DVLP),
.PRE			(PRE),
.EN_SA			(EN_SA),
.clk			(clk),
.reset			(reset)
);

assign NOT_WRITE=~WRITE;
assign NOT_WRITE_2=NOT_WRITE;
assign WRITE_2=WRITE;

endmodule

