function signal = modulation_16QAM(packet)
    bits_per_symbol = 4;    
    sym_num = (8 / bits_per_symbol) * length(packet);
    tx_real = zeros(1, sym_num);
    tx_img = zeros(1, sym_num);
    
    for i = 1:bits_per_symbol:(8 * length(packet))
        index = floor(i / 8) + 1;
        index2 = floor(i / bits_per_symbol) + 1;
        
        byte = packet(index);
        num = rem(i, 8);
        sym = [bitget(byte, num), bitget(byte, num + 1), bitget(byte, num + 2), bitget(byte, num + 3)];

        if sym(3) == 0 && sym(4) == 0
            tx_real(index2) = 3;
        elseif sym(3) == 1 && sym(4) == 0
            tx_real(index2) = -3;
        elseif sym(3) == 0 && sym(4) == 1
            tx_real(index2) = 1;
        elseif sym(3) == 1 && sym(4) == 1
            tx_real(index2) = -1;
        end
        
        if sym(1) == 0 && sym(2) == 0
            tx_img(index2) = -3;
        elseif sym(1) == 1 && sym(2) == 0
            tx_img(index2) = 3;
        elseif sym(1) == 0 && sym(2) == 1
            tx_img(index2) = -1;
        elseif sym(1) == 1 && sym(2) == 1
            tx_img(index2) = 1;
        end

    end
    signal = (1 / sqrt(10)) * (tx_real + 1i * tx_img);
end