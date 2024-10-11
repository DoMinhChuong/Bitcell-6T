module Timer(
    input CLOCK_50,           // 50 MHz clock input
    input [1:0] KEY,          // Input keys for reset and start/pause
    output [0:6] HEX0,        // Output for 7-segment display HEX0 (seconds unit)
    output [0:6] HEX1,        // Output for 7-segment display HEX1 (seconds tens)
    output [0:6] HEX2,        // Output for 7-segment display HEX2 (minutes unit)
    output [0:6] HEX3         // Output for 7-segment display HEX3 (minutes tens)
);

reg [25:0] counter, FREQUENCY;   // Registers for counter and frequency settings
reg [1:0] second = 0, minute = 0; // Registers for tracking seconds and minutes
reg start = 1'b1;                // Register to control start/pause behavior

// Initialize FREQUENCY to 10 (adjust for simulation or timing purposes)
initial FREQUENCY = 26'd10;

always @(posedge CLOCK_50)
begin        
    // Reset condition when KEY[0] is pressed (active low)
    if (~KEY[0])
    begin
        second = 0; 
        minute = 0; 
    end
    
    // Start/pause toggle when KEY[1] is pressed (active low)
    if (~KEY[1])
    begin
        start = ~start; 
    end
    
    // Check if counter has reached the frequency value
    if (counter >= FREQUENCY)
    begin
        counter <= 26'b0; // Reset counter after reaching frequency

        // If start signal is high
        if (start) begin
            // Increment minute if seconds reach 59
            if(second == 59) begin
                second <= 0;
                if(minute == 59) begin
                    minute <= 0; // Reset both seconds and minutes at 59:59
                end
                else
                    minute <= minute + 1'b1; 
            end
            else
                second <= second + 1'b1; 
        end
    end
    
    // If counter hasn't reached the frequency, keep incrementing
    else
        counter <= counter + 1'b1;
end    

// Instantiate 7-segment decoder modules for seconds and minutes display
decoder_7seg sec0(.bin(second % 10), .HEX(HEX0)); // Seconds unit
decoder_7seg sec1(.bin(second / 10), .HEX(HEX1)); // Seconds tens
decoder_7seg min0(.bin(minute % 10), .HEX(HEX2)); // Minutes unit
decoder_7seg min1(.bin(minute / 10), .HEX(HEX3)); // Minutes tens

endmodule
