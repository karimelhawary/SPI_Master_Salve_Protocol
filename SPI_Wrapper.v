module SPI_Wrapper(
    input clk,
    input rst_n,
    input SS_n,
    input MOSI,
    output MISO

/************* if need to display it remove comments & take care about (,) (;)*****************/
    //output [2:0] spi_current_state, 
    //output [2:0] spi_next_state,     
    //output [3:0] spi_Counter,
    //output [3:0] spi_Counter_tm,  
    //output spi_Have_Addrress,
    //output [9:0] ram_din,
    //output [7:0] ram_dout,
    //output [7:0] ram_ADD_REG,
    //output ram_tx_valid,
    //output ram_rx_valid
);

    //parameter 
    parameter MEM_DEPTH=256;
    parameter ADDR_SIZE=8;

    wire [9:0] rxdata;
    wire rx_valid;
    wire [7:0] txdata;
    wire tx_valid;

    RAM #(MEM_DEPTH, ADDR_SIZE) RAM(
        .din(rxdata),
        .dout(txdata),
        .rx_valid(rx_valid),
        .tx_valid(tx_valid),
        .clk(clk),
        .rst_n(rst_n)

        ////signal need to display on tb
        //.ADD_REG(ram_ADD_REG) // Expose ADD_REG
    );

    SPI_SLAVE SPI(
        .MOSI(MOSI),
        .MISO(MISO),
        .SS_n(SS_n),
        .clk(clk),
        .rst_n(rst_n),
        .rx_data(rxdata),
        .rx_valid(rx_valid),
        .tx_data(txdata),
        .tx_valid(tx_valid)

        ////some signals need to display on tb
        //.current_state(spi_current_state), // Expose current_state
        //.next_state(spi_next_state), // Expose current_state
        //.Counter(spi_Counter), // Expose Counter
        //.Counter_tm(spi_Counter_tm), // Expose Counter
        //.Have_Addrress(spi_Have_Addrress) // Expose Have_Addrress
    );

    //assign ram_din = rxdata;
    //assign ram_dout = txdata; // Expose RAM dout
    //assign ram_tx_valid = tx_valid; // Expose RAM tx_valid
    //assign ram_rx_valid = rx_valid; 

endmodule
