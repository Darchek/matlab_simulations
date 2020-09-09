
function result = send_packet_no_arq(tx_packet, EBN0_dB, PACKET_LENGTH)

    global MODULATION;
    
	% Modulation Block
    if contains(MODULATION, 'QPSK')
        signal = modulation_QPSK(tx_packet);
    elseif contains(MODULATION, '16QAM')
        signal = modulation_16QAM(tx_packet);
    elseif contains(MODULATION, 'OOK')
        signal = modulation_OOK(tx_packet);
    end

	% Channel
	signal_plus_noise = channel_AWGN(signal, EBN0_dB);

	% Demodulation Block
    if contains(MODULATION, 'QPSK')
        rx_packet = demodulation_QPSK(signal_plus_noise);
    elseif contains(MODULATION, '16QAM')
        rx_packet = demodulation_16QAM(signal_plus_noise);
    elseif contains(MODULATION, 'OOK')
        rx_packet = demodulation_OOK(signal_plus_noise);
    end
    
    % Check CRC
    result = receive_packet(rx_packet, PACKET_LENGTH);
end
