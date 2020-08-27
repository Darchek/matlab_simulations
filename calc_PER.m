function per = calc_PER(EBN0_dB, N, modulation)
    % N -> Number of bits
	EbNo = 10^(EBN0_dB/10);
    
    if contains(modulation, 'QPSK')
        x_QPSK = sqrt(2*EbNo);
        ber = (1/2)*erfc(x_QPSK/sqrt(2));
    elseif contains(modulation, '16QAM')
        x_16QAM = sqrt(3*4*EbNo/15);
        ber = (3/4)*(1/2)*erfc(x_16QAM/sqrt(2));
    elseif contains(modulation, 'OOK')
        ber = (1/2)*erfc(sqrt(EbNo/4));
    end
	per = 1 - (1 - ber)^N;
end