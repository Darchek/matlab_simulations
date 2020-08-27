function packet = demodulation_OOK(signal_plus_noise)
    bits_per_symbol = 1;
    sym_num = length(signal_plus_noise);
    packet_bytes = (bits_per_symbol / 8) * sym_num;
    rx_real = signal_plus_noise;

    byte = uint8(0);
    packet = uint8(zeros(1, packet_bytes));
    
	for i = 1:bits_per_symbol:(sym_num * bits_per_symbol)
        index = rem(i, 8);
        if index == 0
            index = 8;
        end
        if rx_real(i) > 0.5
            byte = bitset(byte, index, 1);
        else
            byte = bitset(byte, index, 0);
        end
        
        if index == 8
            num = i / 8;
            packet(num) = byte;
        end
    end
   
end