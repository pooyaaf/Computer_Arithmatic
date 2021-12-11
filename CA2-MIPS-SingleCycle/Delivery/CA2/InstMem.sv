module InstMem (input [31:0] adr, output [31:0] out);
    logic [31:0] mem[0:65535];

    initial
    begin
        $readmemb("program.txt", mem);
    end
    
    assign out = mem[adr[31:2]];//{mem[adr[15:0]+3], mem[adr[15:0]+2], mem[adr[15:0]+1], mem[adr[15:0]]};
    
endmodule
