
function bps = bits_per_symbol()

    global MODULATION;

    if contains(MODULATION, 'OOK')
        bps = 1;
    elseif contains(MODULATION, 'QPSK')
        bps = 2;
    elseif contains(MODULATION, '16QAM')
        bps = 4;
    elseif contains(MODULATION, '64QAM')
        bps = 6;
    end
    

end
