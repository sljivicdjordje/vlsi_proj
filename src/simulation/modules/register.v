module register (
    input clk,
    input rst_n,
    input cl,
    input ld,
    input [3:0] in,
    input inc,
    input dec,
    input sr,
    input ir,
    input sl,
    input il,
    output [3:0] out
);

    reg [3:0] out_reg;
    reg [3:0] out_next;
    
    assign out = out_reg;

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            out_reg <= 4'h0;
        end else begin
            out_reg <= out_next;
        end
    end

    always @(*) begin
        casex ({cl, ld, inc, dec, sr, sl})
            6'b1xxxxx:begin // clear
                out_next = 4'h0;
            end
            6'b01xxxx:begin // load
                out_next = in;
            end  
            6'b001xxx:begin // inc
                out_next = out_next + 4'h1;
            end
            6'b0001xx:begin // dec
                out_next = out_next - 4'h1;
            end
            6'b00001x:begin // sr
                out_next = {ir, out_reg[3:1]};
            end
            6'b000001:begin // sl
                out_next = {out_reg[2:0], il};
            end
            6'b000000:begin // do nothing
                out_next = out_reg;
            end
        endcase
    end

endmodule