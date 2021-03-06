
% EbNodB = 0:1:20;
EbNodB = 1:1:15;
EbNo = 10.^(EbNodB/10);
N = 2*10^7;
qpsk = [-1 1];
n = 1;
ber = zeros(1, length(EbNodB));

tic;
while n <= length(EbNodB)
    total_errors = 0;
    s_real = randsrc(1, N, qpsk);
    s_img  = randsrc(1, N, qpsk);
    s = s_real + 1i * s_img;
    w = (1 / sqrt(2 * EbNo(n))) * (randn(1, N) + 1i * randn(1, N));
    r = s + w;
    
    %Rx
    r_real = real(r);
    r_img = imag(r);

    sr = sign(s_real);
    si = sign(s_img);
    
    rr = sign(r_real);
    ri = sign(r_img);
    
%     correct = (sr == rr) + (si == ri);
%     errors = N - sum(correct == 2);
    
    for k = 1:N       
        if sr(k) ~= rr(k) || si(k) ~= ri(k)
            total_errors = total_errors + 1;
        end
    end
    
    % 2 bits per symbol
    ber(n) = (total_errors / N) / 2;
    n = n + 1;
end
toc;

% Theoretical QPSK
x_QPSK = sqrt(2*EbNo);
theorical_QPSK = (1/2)*erfc(x_QPSK/sqrt(2));

% close all
figure;
semilogy(EbNodB, theorical_QPSK, '-*', EbNodB, ber2, '-o');
axis([0 20 10^-6 1]);
grid on;
legend('Theoretical', 'Simulation');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for QPSK modulation'); 


