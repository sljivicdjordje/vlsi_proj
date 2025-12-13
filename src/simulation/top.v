module top;
    
    // ALU start
    // 4 + 4 + 3 = 11, 2 na 11 je 2048
    reg [3:0]a;
    reg [3:0]b;
    reg [2:0]oc;

    wire [3:0]out_alu;
    
    integer j;
    
    alu alu_inst(oc, a, b, out_alu);

    // ALU kraj, reg start

    reg clk;
    reg rst_n;
    reg cl;
    reg ld;
    reg [3:0] in;
    reg inc;
    reg dec;
    reg sr;
    reg ir;
    reg sl;
    reg il;
    wire [3:0] out_reg;

    register reg_inst(clk, rst_n, cl, ld, in, inc, dec, sr, ir, sl, il, out_reg);
    // reg kraj

    // init svega
    initial begin
        clk = 1'b0;
        rst_n = 1'b0; // stoji na nuli dok ne dodje vreme na registar
        cl = 1'b0;
        ld = 1'b0;
        in = 4'h0;
        inc = 1'b0;
        dec = 1'b0;
        sr = 1'b0;
        ir = 1'b0;
        sl = 1'b0;
        il = 1'b0;
        
        oc = 3'b000;
        a = 4'h0;
        b = 4'h0;
    end

    // main
    initial begin
        // alu petlja
        for (j = 0; j < 2048; j = j + 1) begin
            {oc, a, b} = j;
            #5;
        end
        
        $stop;
        
        #5 rst_n = 1'b1; // upaljen reg
        #5;
        repeat (1000) begin
            {cl, ld, inc, dec, sr, ir, sl, il} = $urandom_range(2**8);
            in = $urandom_range(2**4);
            #10;
        end
        #5 $finish;
    end

    // clk za reg
    always begin
    #5 clk = ~clk;
    end

    // ispis ALU
    always @(out_alu) begin
        $display(
            "Vreme: %d, a = %d, b = %d, oc = %d, out_alu = %d",
            $time, a, b, oc, out_alu
        );
    end

    // ispis reg
    always @(out_reg) begin
        $display(
            "Vreme: %d, cl = %d, ld = %d, in = %d, inc = %d, dec = %d, sr = %d, ir = %d, sl = %d, il = %d, out_reg = %d",
            $time, cl, ld, in, inc, dec, sr, ir, sl, il, out_reg
        );
    end


endmodule