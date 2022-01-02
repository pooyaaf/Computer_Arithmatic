`timescale 1ns/1ns

module MIPSCPUTB ();

    reg clk = 1'b0;
    MIPSCPU UUT(clk);

    always #4 clk = ~clk;

    initial begin
        // $readmemb("./testCode2.txt", UUT.dataPath.instMem.file);
        // $readmemb("./MemoryBlock.mem", UUT.dataPath.RAM.file, 250);
        //
        $readmemb("./progTest.txt", UUT.dataPath.instMem.file);
        $readmemb("./InstMemory.txt", UUT.dataPath.RAM.file, 250);
    end
endmodule