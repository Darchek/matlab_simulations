function packet = demodulation_QPSK(signal_plus_noise)
    bits_per_symbol = 2;
    sym_num = length(signal_plus_noise);
    packet_bytes = (bits_per_symbol / 8) * sym_num;
    
    rx_real = real(signal_plus_noise);
    rx_img = imag(signal_plus_noise);
    s_real = sign(rx_real);
    s_img = sign(rx_img);
    
    byte = uint8(0);
    packet = uint8(zeros(1, packet_bytes));
    
	for i = 1:bits_per_symbol:(sym_num * bits_per_symbol)
        index = floor(i / 2) + 1;
        index2 = rem(i, 8);
        if(s_real(index) == 1)
            byte = bitset(byte, index2, 0);
        else
            byte = bitset(byte, index2, 1);
        end
        if(s_img(index) == 1)
        	byte = bitset(byte, index2 + 1, 0);
        else
        	byte = bitset(byte, index2 + 1, 1);
        end
        
        if index2 == 7
            num = floor(i / 8) + 1;
            packet(num) = byte;
        end
    end
   
end