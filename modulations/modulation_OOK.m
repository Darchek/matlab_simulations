function signal = modulation_OOK(packet)
    bits_per_symbol = 1;    
    sym_num = (8 / bits_per_symbol) * length(packet);
    tx_real = zeros(1, sym_num);
    
    for i = 1:bits_per_symbol:(8 * length(packet))
        index = ceil(i / 8);
        num = rem(i, 8);
        if num == 0
            num = 8;
        end
        byte = packet(index);
        tx_real(i) = bitget(byte, num);
    end
    signal = tx_real;
end