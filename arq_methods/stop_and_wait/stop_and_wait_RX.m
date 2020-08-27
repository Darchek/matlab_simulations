function arq_packet = stop_and_wait_RX(res, EBN0_dB, MODULATION)

    % ARQ method - RX - STOP & WAIT - Send ACK to transmitter
    
    ack = uint8(6);     % res = 1 (Good)
    nack = uint8(15);   % res = 0 (Error)
    
    if(res == 1)                                                % send ACK
        toSend = ack;
    else                                                        % send NACK
        toSend = nack;
    end
    
    % Modulation Block
    if contains(MODULATION, 'QPSK')
        signal = modulation_QPSK(toSend);
    elseif contains(MODULATION, '16QAM')
        signal = modulation_16QAM(toSend);
    elseif contains(MODULATION, 'OOK')
        signal = modulation_OOK(toSend);
    end
    
	% Channel
    signal_plus_noise = channel_AWGN(signal, EBN0_dB, MODULATION);
    
    % Demodulation Block
    if contains(MODULATION, 'QPSK')
        arq_packet = demodulation_QPSK(signal_plus_noise);
    elseif contains(MODULATION, '16QAM')
        arq_packet = demodulation_16QAM(signal_plus_noise);
    elseif contains(MODULATION, 'OOK')
        arq_packet = demodulation_OOK(signal_plus_noise);
    end
    
end