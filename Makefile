VERILOG = iverilog          #宣告變數VERILOG為iverilog
TARGET = decoder_3_8.vcd    #宣告變數TARGET為decoder_3_8.vcd

$(TARGET) : decoder_3_8.vvp #透過vvp檔編譯TARGET也就是vcd檔
	vvp decoder_3_8.vvp		

decoder_3_8.vvp: decoder_3_8_tb.v decoder_3_8.v #透過電路及tb的v檔編譯vvp檔
	$(VERILOG) -o decoder_3_8.vvp decoder_3_8_tb.v decoder_3_8.v

clean:                      #刪除vcd檔
	del $(TARGET)