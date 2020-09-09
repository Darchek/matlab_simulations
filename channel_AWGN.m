function res = channel_AWGN(signal, EBN0_dB)

    global MODULATION;
    
    EbNo = 10^(EBN0_dB/10);
    total_symbols = length(signal);
    if contains(MODULATION, 'OOK')
        w = (1 / sqrt(2 * EbNo)) * randn(1, total_symbols);
    elseif contains(MODULATION, 'QPSK')
        w = (1 / sqrt(2 * EbNo)) * (randn(1, total_symbols) + 1i * randn(1, total_symbols));
    elseif contains(MODULATION, '16QAM')
        w = (1 / sqrt(2 * 4 * EbNo)) * (randn(1, total_symbols) + 1i * randn(1, total_symbols));
	elseif contains(MODULATION, '64QAM')
        w = (1 / sqrt(2 * 6 * EbNo)) * (randn(1, total_symbols) + 1i * randn(1, total_symbols));
    end
    res = signal + w;
end
