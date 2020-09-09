function packet = demodulation_64QAM(signal_plus_noise)
    bits_per_symbol = 6;
    sym_num = length(signal_plus_noise);
    packet_bytes = floor(bits_per_symbol / 8) * sym_num;
    
    rx_real = real(signal_plus_noise) * sqrt(42);
    rx_img = imag(signal_plus_noise) * sqrt(42);

    bytes32 = uint32(0);
    packet = uint8(zeros(1, packet_bytes));
    

	for n = 1:bits_per_symbol:(sym_num * bits_per_symbol)
        index = floor(n / bits_per_symbol) + 1;
        index2 = mod(n, 24) + 8;

        if rx_real(index) > 0
            bytes32 = bitset(bytes32, index2 + 2, 1);
        end
        
        if rx_img(index) > 0
            bytes32 = bitset(bytes32, index2 + 5, 1);
        end
        
        if abs(rx_real(index)) < 4
            bytes32 = bitset(bytes32, index2 + 1, 1);
        end
        
        if abs(rx_img(index)) < 4
            bytes32 = bitset(bytes32, index2 + 4, 1);
        end
        
        if abs(rx_real(index)) > 2 && abs(rx_real(index)) < 6
            bytes32 = bitset(bytes32, index2, 1);
        end
        
        if abs(rx_img(index)) > 2 && abs(rx_img(index)) < 6
            bytes32 = bitset(bytes32, index2 + 3, 1);
        end
        

        if index2 == 27
            num = floor(n / 8) + 1;
            bytes = typecast(bytes32, 'uint8');
            packet(num - 2) = bytes(2);
            packet(num - 1) = bytes(3);
            packet(num) = bytes(4);
            bytes32 = uint32(0);
        elseif index == length(signal_plus_noise)
            num = ceil(n / 8);
            bytes = typecast(bytes32, 'uint8');
            if index < 4 && num == 2
                packet(num - 1) = bytes(2);
                packet(num) = bytes(3);
            elseif index < 4 && num == 1
                packet(num) = bytes(2);
            elseif mod(num, 2) == 0
                packet(num) = bytes(2);
            elseif mod(num, 2) == 1
                packet(num - 1) = bytes(2);
                packet(num) = bytes(3);
            end
        end
    end
   
end