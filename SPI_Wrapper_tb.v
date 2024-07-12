module SPI_Wrapper_TB();
//parameter
parameter MEM_DEPTH=256;
parameter ADDR_SIZE=8;
//states
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_ADD=3'b011;
parameter READ_DATA=3'b100;
reg SS_n; 
reg MOSI,clk,rst_n;
wire MISO;

/************* if need to display it remove comments && take care about (,) (;)*****************/
//wire [2:0] spi_current_state;
//wire [2:0] spi_next_state;
//wire [3:0] spi_Counter;
//wire [3:0] spi_Counter_tm;
//wire spi_Have_Addrress;
//wire [9:0] ram_din;
//wire [7:0] ram_dout;
//wire [7:0] ram_ADD_REG;
//wire ram_tx_valid;
//wire ram_rx_valid;

SPI_Wrapper #(MEM_DEPTH,ADDR_SIZE) DUT(
    .clk(clk),
    .rst_n(rst_n),
    .SS_n(SS_n),
    .MOSI(MOSI),
    .MISO(MISO)

    //.spi_current_state(spi_current_state), 
    //.spi_next_state(spi_next_state), 
    //.spi_Counter(spi_Counter),
    //.spi_Counter_tm(spi_Counter_tm), 
    //.spi_Have_Addrress(spi_Have_Addrress),
    //.ram_din(ram_din),
    //.ram_dout(ram_dout),
    //.ram_ADD_REG(ram_ADD_REG),
    //.ram_tx_valid(ram_tx_valid),
    //.ram_rx_valid(ram_rx_valid)
    );

// Clock generation
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 100MHz clock
    end

// Test sequence
    initial begin
        // Reset generation
        rst_n = 0;
        SS_n = 1;
        MOSI = 0;
        repeat(15) @(negedge clk);
        rst_n=1;
        repeat(15) @(negedge clk);

//60ns
        // Start SPI transaction
        SS_n = 0;@(negedge clk);
    
        // Send command (WRITE ADDRESS)
        MOSI = 0;@(negedge clk);          
        MOSI = 0;@(negedge clk);   
        MOSI = 0;@(negedge clk);     
        //ADDRESS
        MOSI = 1;@(negedge clk);    
        MOSI = 1;@(negedge clk);          
        MOSI = 0;@(negedge clk);  
        MOSI = 1;@(negedge clk);  
        MOSI = 0;@(negedge clk);  
        MOSI = 1;@(negedge clk);      
        MOSI = 1;@(negedge clk);
        MOSI = 1;@(negedge clk);      
        
        // End SPI transaction
        SS_n = 1;
        repeat(15) @(negedge clk);

//114ns
        // Start SPI transaction
        SS_n = 0;@(negedge clk);
    
        // Send command (WRITE DATA)
        MOSI = 0;@(negedge clk);          
        MOSI = 0;@(negedge clk);   
        MOSI = 1;@(negedge clk); 

        //DATA
        MOSI = 1;@(negedge clk);
        MOSI = 1;@(negedge clk);    
        MOSI = 0;@(negedge clk);          
        MOSI = 1;@(negedge clk);  
        MOSI = 0;@(negedge clk);  
        MOSI = 0;@(negedge clk);  
        MOSI = 1;@(negedge clk);         
        MOSI = 1;@(negedge clk);
        // End SPI transaction
        SS_n = 1;
        repeat(15) @(negedge clk);


//Reset to clear address
//168ns
rst_n=0;
repeat(15) @(negedge clk);
rst_n=1;
repeat(15) @(negedge clk);


//228ns
        // Start SPI transaction
        SS_n = 0;@(negedge clk);
    
        // Send command (READ ADDRESS)
        MOSI = 1;@(negedge clk);          
        MOSI = 1;@(negedge clk);   
        MOSI = 0;@(negedge clk);     
        //ADDRESS
        MOSI = 1;@(negedge clk);    
        MOSI = 1;@(negedge clk);          
        MOSI = 0;@(negedge clk);  
        MOSI = 1;@(negedge clk);  
        MOSI = 0;@(negedge clk);  
        MOSI = 1;@(negedge clk);      
        MOSI = 1;@(negedge clk);
        MOSI = 1;@(negedge clk);      
        
        // End SPI transaction
        SS_n = 1;
        repeat(15) @(negedge clk);

//282ns
        // Start SPI transaction
        SS_n = 0;@(negedge clk);

        // Send command (READ DATA)
        MOSI = 1;@(negedge clk);          
        MOSI = 1;@(negedge clk);   
        MOSI = 1;@(negedge clk);

        //ignored following data just for protocol
        MOSI = 1;@(negedge clk);    
        MOSI = 1;@(negedge clk);          
        MOSI = 0;@(negedge clk);  
        MOSI = 1;@(negedge clk);  
        MOSI = 0;@(negedge clk);  
        MOSI = 1;@(negedge clk);      
        MOSI = 0;@(negedge clk);
        MOSI = 1;@(negedge clk);  

        repeat(9) @(negedge clk);
        SS_n=1;
        repeat(15) @(negedge clk);
            
        #10
        // Finish simulation
        $stop;
    end

    //// Monitor MISO line
    //initial begin
    //    $monitor("At time %t: spi_current_state = %b, spi_next_state = %b,, spi_Counter = %b, spi_Have_Addrress = %b, ram_din = %h, ram_dout = %h, ram_ADD_REG = %h, ram_tx_valid = %b",
    //            $time, DUT.SPI.current_state, DUT.SPI.next_state, DUT.SPI.Counter, DUT.SPI.Have_Addrress, DUT.RAM.din, DUT.RAM.dout, DUT.RAM.ADD_REG, DUT.RAM.tx_valid);
    //end

    

endmodule