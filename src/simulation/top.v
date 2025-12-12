module top;
    
    // 4 + 4 + 3 = 11, 2 na 11 je 2048
    reg [3:0]a;
    reg [3:0]b;
    reg [2:0]oc;
    wire [3:0]out;

    integer j;

    alu alu_inst(oc, a, b, out);

    initial begin
        for (j = 0; j < 2048; j = j + 1) begin
            {oc, a, b} = j;
            #5;
        end
        #13000 $finish;
    end

    initial begin
        $monitor("Vreme: %2d, izlaz: %d", $time, out);
    end


endmodule