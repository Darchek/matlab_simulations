function signal = modulation_QPSK(packet)
    bits_per_symbol = 2;    
    sym_num = (8 / bits_per_symbol) * length(packet);
    tx_real = zeros(1, sym_num);
    tx_img = zeros(1, sym_num);
    
    for i = 1:bits_per_symbol:(8* length(packet))
        index = floor(i / 8) + 1;
        byte = packet(index);
        num = rem(i, 8);
        sym = [bitget(byte, num), bitget(byte, num + 1)];
        index2 = floor(i / 2) + 1;
        if(sym(1) == 0)
           tx_real(index2) = 1;
        else
           tx_real(index2) = -1;
        end
        if(sym(2) == 0)
           tx_img(index2) = 1;
        else
           tx_img(index2) = -1;
        end
    end
    signal = tx_real + 1i * tx_img;
end