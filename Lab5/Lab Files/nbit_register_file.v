// nbit_register_file
//
// A generic register file which can be parameterized
// by the following:
//
// - number of register select lines REG_SELECT_WIDTH: 
//   number of registers in the file is 2 to the power 
//   of this number.
//
// - number of register bits DATA_WIDTH.
//
// Updates:
// 10/18: Reset fix.
// 10/21: Timing fix.
//
module nbit_register_file(write_data, 
                          read_data_1, read_data_2, 
                          read_sel_1, read_sel_2, 
                          write_address, RegWrite, clk);

    parameter data_width = 32;
    parameter select_width = 5; 

    input                             clk, RegWrite;
    input       [data_width-1:0]      write_data;
    input       [4:0]                 read_sel_1, read_sel_2, write_address;
    output      [data_width-1:0]      read_data_1, read_data_2;

    reg         [data_width-1:0]      register_file [0:data_width-1];

    // for loop initializes all registers to 10x the register number
    // no need to rst
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin 
            register_file[i] = i * 10;
        end     
    end


    assign read_data_1 = register_file[read_sel_1];
    assign read_data_2 = register_file[read_sel_2];


    always @ (posedge clk) begin
        if (RegWrite) 
            register_file[write_address] <= write_data;
    end

endmodule
