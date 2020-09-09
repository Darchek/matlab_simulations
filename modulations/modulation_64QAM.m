function signal = modulation_64QAM(packet)
    bits_per_symbol = 6;    
    sym_num = floor(8 / bits_per_symbol) * length(packet);
    tx_real = zeros(1, sym_num);
    tx_img = zeros(1, sym_num);

    
    for n = 1:bits_per_symbol:(8 * length(packet))
        index = floor(n / 24) * 3 + 1;
        index2 = mod(n, 24) + 8;
        index3 = floor(n / bits_per_symbol) + 1;
        
        if index2 == 9
            if length(packet) == index
                bytes24 = [ uint8(0), packet(index), uint8(0), uint8(0) ];
            elseif length(packet) == index + 1
                bytes24 = [ uint8(0), packet(index), packet(index + 1), uint8(0) ];
            else
                bytes24 = [ uint8(0), packet(index), packet(index + 1), packet(index + 2) ];
            end
            bytes32 = typecast(bytes24, 'uint32');
        end

        sym = bitget(bytes32, index2 + 5:-1:index2);
        
        if sym(5) == 0 && sym(6) == 0
            tx_real(index3) = 7;
        elseif sym(5) == 0 && sym(6) == 1
            tx_real(index3) = 5;
        elseif sym(5) == 1 && sym(6) == 0
            tx_real(index3) = 1;
        elseif sym(5) == 1 && sym(6) == 1
            tx_real(index3) = 3;
        end
        
        if sym(2) == 0 && sym(3) == 0
            tx_img(index3) = 7;
        elseif sym(2) == 0 && sym(3) == 1
            tx_img(index3) = 5;
        elseif sym(2) == 1 && sym(3) == 0
            tx_img(index3) = 1;
        elseif sym(2) == 1 && sym(3) == 1
            tx_img(index3) = 3;
        end

        if sym(1) == 0
            tx_img(index3) = -1 * tx_img(index3);
        end
        
        if sym(4) == 0
            tx_real(index3) = -1 * tx_real(index3);
        end

    end
    signal = (1 / sqrt(42)) * (tx_real + 1i * tx_img);
end