
function ber = send_message_OFDM(EBN0_dB)

    global N;
    global N_ifft;
    global bps;
    global MODULATION;
    
    byte_values = randsrc(1, N, (0:1:255));
    message = uint8(byte_values);

    errors = 0;
    for n = 1:(N_ifft * bps) / 8:length(message)
        if n - 1 + (N_ifft * bps) / 8 > N
            input = message(n:N);
        else
            input = message(n:n - 1 + (N_ifft * bps) / 8);
        end

        if contains(MODULATION, 'QPSK')
            mod_input = modulation_QPSK(input);
        elseif contains(MODULATION, '16QAM')
            mod_input = modulation_16QAM(input);
        elseif contains(MODULATION, '64QAM')
            mod_input = modulation_64QAM(input);
        end
        
        signal = ifft(mod_input);
        max_value = max(max(abs(signal)));
        signal = signal ./ max_value;
        
        signal_plus_noise = channel_AWGN(signal, EBN0_dB);
        % stem(1:N_ifft, real(signal_plus_noise));
        
        output = fft(signal_plus_noise) * max_value;
        
        
        % errors = errors + calculate_ber(mod_input, output);
        
        if contains(MODULATION, 'QPSK')
            demod_output = demodulation_QPSK(output);
        elseif contains(MODULATION, '16QAM')
            demod_output = demodulation_16QAM(output);
        elseif contains(MODULATION, '64QAM')
            demod_output = demodulation_64QAM(output);
        end
        
        errors = errors + sum((input == demod_output) == 0);
    end
    
    % ber = (errors / N) / bps;
    ber = (errors / N) / 8;
    disp(['EBN0: ', num2str(EBN0_dB), '   ->   BER: ', num2str(ber)]);
    
end
