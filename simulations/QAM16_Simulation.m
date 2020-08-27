
EbNodB = 0:1:20;
EbNo = 10.^(EbNodB/10);
N = 2*10^7;
qam16 = [-3 -1 1 3];
n = 1;
ber = zeros(1, length(EbNodB));

while n <= length(EbNodB)
    total_errors = 0;
    s_real = randsrc(1, N, qam16);
    s_img  = randsrc(1, N, qam16);
    s = s_real + 1i * s_img;
    % 4 bits per symbol
    w = (1 / sqrt(2 * 4 * EbNo(n))) * (randn(1, N) + 1i * randn(1, N));
    r = (1 / sqrt(10)) * s + w;
    r_real = real(r) * sqrt(10);
    r_img = imag(r) * sqrt(10);

    res1 = decisor(s_real, s_img);
    res2 = decisor(r_real, r_img);
    
    for i = 1:N       
        if res1(i) ~= res2(i)
            total_errors = total_errors + 1;
        end
    end
    p = total_errors / N;
    % 4 bits per symbol
    ber(n) = p / 4;
    n = n + 1;
end


% Theoretical 16-QAM
x_16QAM = sqrt(3*4*EbNo/15);
% theorical_16QAM = (3/4)*(1/2)*erfc(x_16QAM/sqrt(2));
theorical_16QAM = (3/8)*erfc(sqrt((6*EbNo)/15));

% close all;
figure;
semilogy(EbNodB, theorical_16QAM, '-*', EbNodB, ber,'-o');
axis([0 20 10^-6 1]);
grid on;
legend('Theoretical', 'Simulation');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for 16-QAM modulation'); 





% ylim([1E-6 1]);



