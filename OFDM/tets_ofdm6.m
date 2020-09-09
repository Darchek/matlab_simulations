
global MODULATION;

N = 10^5;
N_ifft = 64;
EbN0_db = -20;
MODULATION = '16QAM';       % OOK, QPSK, 16QAM, 64QAM
bps = bits_per_symbol();

byte_values = randsrc(1, N, (0:1:255));
message = uint8(byte_values);

errors = 0;
for n = 1:(N_ifft * bps) / 8:length(message)
    if n - 1 + (N_ifft * bps) / 8 > N
        input = message(n:N);
    else
        input = message(n:n - 1 + (N_ifft * bps) / 8);
    end

    % mod_input = modulation_QPSK(input);
    mod_input = modulation_16QAM(input);
    % mod_input = modulation_64QAM(input);

    signal = ifft(mod_input);
    max_value = max(max(abs(signal)));
    signal = signal ./ max_value;

    signal_plus_noise = channel_AWGN(signal, EbN0_db);
    stem(1:N_ifft, real(signal_plus_noise));

    output = fft(signal_plus_noise) * max_value;
    % demod_output = demodulation_QPSK(output);
    demod_output = demodulation_16QAM(output);
    % demod_output = demodulation_64QAM(output);

    errors = errors + sum((input == demod_output) == 0);
end



theoryBer_16QAM = (1/4)*3/2*erfc(sqrt(4*0.1*(10.^(EbN0_db/10))));

% ber = ((errors * 8) / bps) / N;
ber = (errors / N) / bps;
disp([num2str(EbN0_db), '  ->  ', num2str(ber)]);

theoryBer_16QAM

