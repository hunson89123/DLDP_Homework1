module decoder_2_4(E , In , Out);
input E;                            //宣告致能輸入E
input [1:0] In;                     //宣告兩輸入In[1]~In[0]
output [3:0]Out;                    //宣告四輸出Out[3]~Out[0]
wire [3:0] Out;                     //宣告四輸出Out為連接線
assign Out = E ? 1'b1 << In : 4'h0; //E為1時輸出1位元二進制左移In個位元，為0時輸出0
endmodule

module decode_3_8(E , In , Out);
input E;                                           //宣告致能輸入E		
input [2:0] In;                                    //宣告三輸入In[2]~In[0]
output [7:0] Out;                                  //宣告八輸出Out[7]~Out[0]
wire E1 , G1 , G2;                                 //宣告三對八解碼器之致能線E1(E1=E')
                                                   //　　二對四解碼器1之致能線G1
                                                   //　　二對四解碼器2之致能線G2
  not u1(E1 , In[2]);                              //E1=致能線E1與輸入In[2]透過NOT閘連接
  and a1(G1 , E , In[2]);                          //G1=致能線E與輸入In[2]透過AND閘連接
  and a2(G2 , E , E1);                             //G2=致能線E與輸入E1透過AND閘連接
  decoder_2_4 block1(G1 , In[1 : 0] , Out[7 : 4]); //Out[7:4]=G1及In[0:1]輸入decoder_2_4
  decoder_2_4 block2(G2 , In[1 : 0] , Out[3 : 0]); //Out[3:0]=G2及In[0:1]輸入decoder_2_4
endmodule