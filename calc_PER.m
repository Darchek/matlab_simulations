function per = calc_PER(EBN0_dB)

    global MODULATION;
    global PACKET_LENGTH;
    global MAX_COUNT;
    
    L = (PACKET_LENGTH + 4) * 8;

    % N -> Number of bits
	EbNo = 10^(EBN0_dB/10);
    
    if contains(MODULATION, 'QPSK')
        x_QPSK = sqrt(2*EbNo);
        ber = (1/2)*erfc(x_QPSK/sqrt(2));
    elseif contains(MODULATION, '16QAM')
        x_16QAM = sqrt(3*4*EbNo/15);
        ber = (3/4)*(1/2)*erfc(x_16QAM/sqrt(2));
    elseif contains(MODULATION, 'OOK')
        ber = (1/2)*erfc(sqrt(EbNo/4));
    end
	per = 1 - (1 - ber) ^ L;
    per = per ^ MAX_COUNT;
end