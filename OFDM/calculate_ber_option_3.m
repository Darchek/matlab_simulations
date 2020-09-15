function errors = calculate_ber_option_3(input, output)

    global MODULATION;

    if contains(MODULATION, 'QPSK')
        demod_output = demodulation_QPSK(output);
    elseif contains(MODULATION, '16QAM')
        demod_output = demodulation_16QAM(output);
    elseif contains(MODULATION, '64QAM')
        demod_output = demodulation_64QAM(output);
    end

    errors = sum((input == demod_output) == 0);

end