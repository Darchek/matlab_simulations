
function ber = send_message_OFDM(EBN0_dB)

    global N;
    global N_ifft;
    global bps;
    global MODULATION;
    
    byte_values = randsrc(1, N, (0:1:255));
    message = uint8(byte_values);

    errors_1 = 0;
    errors_2 = 0;
    errors_3 = 0;
        
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
        % max_value = max(max(abs(signal)));
        % signal = signal ./ max_value;
        signal = signal ./ sqrt(N_ifft);
        
        xrms = rms(signal);
%         A = (10 ^ (9 / 20)) * xrms; 
%         signal_clipped = ((abs(signal) > A) * A).*exp(1i * angle(signal)) + (abs(signal) <= A).*signal;
        xclippedrms = rms(signal_clipped); 
        
        signal_plus_noise = channel_AWGN(signal_clipped / xclippedrms, EBN0_dB);
        % stem(1:N_ifft, real(signal_plus_noise));
        % stem(1:N_ifft, imag(signal_plus_noise));
        
        % output = fft(signal_plus_noise) * max_value;
        % output = fft(signal_plus_noise) / sqrt(N_ifft / 2);
        output = fft(signal_plus_noise) * sqrt(N_ifft) * xclippedrms;
        
        
        errors_1 = errors_1 + calculate_ber_option_1(mod_input, output);  % symbols
%       errors_2 = errors_2 + calculate_ber_option_2(mod_input, output);
%       errors_3 = errors_3 + calculate_ber_option_3(input, output);      % bytes

    
    end
    
    ser = errors_1 / (N * (8 / bps)); 
    ber = ser / bps;
    
end
