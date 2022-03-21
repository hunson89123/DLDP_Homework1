module clkgen(clka, clkb, clka_out, clkb_out);
input clka, clkb;           //宣告輸入埠clka及clkb
output clka_out, clkb_out;  //宣告輸出埠clka_out及clkb_out
reg clka_out, clkb_out;     //將clka_out及clkb_out連接暫存器
always @(clka) begin        //當clka有變化時
    clka_out = clka;        //則clka_out為clka
end
always @(clkb) begin        //當clkb有變化時
    clkb_out = clkb;        //則clkb_out為clkb
end
endmodule

module decoder_3_8_tb;
reg E_tb;                   //宣告暫存器E_tb
reg clka, clkb;             //宣告暫存器clka及clkb
reg [2:0] In_tb;            //宣告暫存器In_tb[2]~In_tb[0]
wire [7:0] Out_tb;          //宣告連接線Out_tb[7]~Out_tb[0]
wire clka_out, clkb_out;    //宣告連接線clka_out及clkb_out
//宣告decoder_1為三對八解碼器並帶入致能、輸入及輸出之變數
decoder_3_8 decoder_1(.E(E_tb), .In(In_tb), .Out(Out_tb));
//宣告clkgen_1為時脈產生器並帶入時脈產生A及B的輸入和輸出
clkgen clkgen_1(.clka(clka), .clkb(clkb),
                .clka_out(clka_out), .clkb_out(clkb_out));
initial begin
    clka = 1'b0; clkb = 1'b0; //預設clka及clkb為1位元的0
end
always begin
    #10 clka = ~clka;         //延遲10秒後clka=NOT(clka)
end
always begin
    #20 clkb = ~clkb;         //延遲20秒後clkb=NOT(clkb)
end

initial begin
    #0  E_tb = 0; In_tb = 3'b000;   //預設致能為0，三輸入為000
    #10 E_tb = 1; In_tb = 3'b000;   //延遲十秒後預設致能為1，三輸入為000
    #10 E_tb = 1; In_tb = 3'b001;   //三輸入改為001，下面以此類推
    #10 E_tb = 1; In_tb = 3'b010;
    #10 E_tb = 1; In_tb = 3'b011;
    #10 E_tb = 1; In_tb = 3'b100;
    #10 E_tb = 1; In_tb = 3'b101;
    #10 E_tb = 1; In_tb = 3'b110;
    #10 E_tb = 1; In_tb = 3'b111;
    #10 $finish;
end
initial begin
    $dumpfile("decoder.vcd");   //將輸出訊號紀錄於decoder.vcd
    $dumpvars(0, decoder_1);    //紀錄decoder_1所產生的信號
    $dumpvars(0, clkgen_1);     //紀錄clkgen_1所產生的信號
end
endmodule
