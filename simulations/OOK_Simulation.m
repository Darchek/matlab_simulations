
EbNodB = 0:1:20;
EbNo = 10.^(EbNodB/10);
N = 2*10^7;
ook = [0 1];
n = 1;
ber = zeros(1, length(EbNodB));

while n <= length(EbNodB)
    total_errors = 0;
    s = randsrc(1, N, ook);
    w = (1 / sqrt(2 * EbNo(n))) * randn(1, N);
    r = s + w;
   
    sr = sign(s - 0.5);
    rr = sign(r - 0.5);
    
    
    for i = 1:N       
        if sr(i) ~= rr(i)
            total_errors = total_errors + 1;
        end
    end
    
    p = total_errors / N;
    ber(n) = p;

    n = n + 1;
end

% Theoretical QPSK
theorical_OOK = (1/2)*erfc(sqrt(EbNo/4));

close all;
figure;
% semilogy(EbNodB, theorical_OOK, 'g.-', 'LineWidth', 2);
semilogy(EbNodB, theorical_OOK, '-*', EbNodB, ber,'-o');
hold on;
% semilogy(EbNodB, ber, 'b-', 'Linewidth', 2);
axis([0 20 10^-6 1]);
grid on;
legend('Theoretical', 'Simulation');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for OOK modulation'); 


