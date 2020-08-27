function packet = demodulation_16QAM(signal_plus_noise)
    bits_per_symbol = 4;
    sym_num = length(signal_plus_noise);
    packet_bytes = (bits_per_symbol / 8) * sym_num;
    
    rx_real = real(signal_plus_noise) * sqrt(10);
    rx_img = imag(signal_plus_noise) * sqrt(10);

    byte = uint8(0);
    packet = uint8(zeros(1, packet_bytes));
    
	for i = 1:bits_per_symbol:(sym_num * bits_per_symbol)
        index = floor(i / bits_per_symbol) + 1;
        index2 = rem(i, 8);
        
        if rx_real(index) > 0
            byte = bitset(byte, index2 + 2, 0);
        else
            byte = bitset(byte, index2 + 2, 1);
        end
        
        if abs(rx_real(index)) < 2
            byte = bitset(byte, index2 + 3, 1);
        else
            byte = bitset(byte, index2 + 3, 0);
        end
        
        if rx_img(index) > 0
            byte = bitset(byte, index2, 1);
        else
            byte = bitset(byte, index2, 0);
        end
        
        if abs(rx_img(index)) < 2
            byte = bitset(byte, index2 + 1, 1);
        else
            byte = bitset(byte, index2 + 1, 0);
        end
        
               
        if index2 == 5
            num = floor(i / 8) + 1;
            packet(num) = byte;
        end
    end
   
end