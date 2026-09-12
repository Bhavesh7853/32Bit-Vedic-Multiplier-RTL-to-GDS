`timescale 1ns / 1ps

module vedic32x32_Test;
    reg  [31:0] A, B;
    reg         ground;
    wire [63:0] Prod;
    wire        overflow;
    reg  [63:0] expected;
    integer     i;
    integer     errors;

    vedic32x32 DUT(
        .A(A),
        .B(B),
        .Prod(Prod),
        .ground(ground),
        .overflow(overflow)
    );

    task check_product;
        input [31:0] test_a;
        input [31:0] test_b;
        begin
            A = test_a;
            B = test_b;
            #1;
            expected = test_a * test_b;
            if (Prod !== expected) begin
                errors = errors + 1;
                if (errors <= 10)
                    $display("FAIL: A=%h B=%h product=%h expected=%h", A, B, Prod, expected);
            end
        end
    endtask

    initial begin
        $dumpfile("Vedic32x32.vcd");
        $dumpvars(0, vedic32x32_Test);

        ground = 1'b0;
        errors = 0;
        check_product(32'h00000000, 32'h00000000);
        check_product(32'h00000001, 32'hffffffff);
        check_product(32'hffffffff, 32'hffffffff);
        check_product(32'h12345678, 32'h9abcdef0);
        check_product(32'h0000ffff, 32'h0000ffff);
        check_product(32'hffff0001, 32'h0001ffff);
        check_product(32'h80000000, 32'h00000002);

        for (i = 0; i < 1000; i = i + 1)
            check_product($random, $random);

        if (errors == 0)
            $display("PASS: all 1007 multiplication tests passed");
        else begin
            $display("FAIL: %0d of 1007 multiplication tests failed", errors);
            $fatal(1);
        end
        $finish;
    end
endmodule
