
EbNodB = 0:1:20;
EbNo = 10.^(EbNodB/10);
N = 2*10^1; % 2*10^7;
ook = [0 1];
qpsk = [-1 1];
qam16 = [-3 -1 1 3];
ber_ook = zeros(1, length(EbNodB));
ber_qpsk = zeros(1, length(EbNodB));
ber_qam16 = zeros(1, length(EbNodB));


for n = 1:length(EbNodB)
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
    ber_ook(n) = p;
end

disp('Simulation OOK Done.');

for n = 1:length(EbNodB)
    total_errors = 0;
    s_real = randsrc(1, N, qpsk);
    s_img  = randsrc(1, N, qpsk);
    s = s_real + 1i * s_img;
    w = (1 / sqrt(2 * EbNo(n))) * (randn(1, N) + 1i * randn(1, N));
    r = s + w;
    r_real = real(r);
    r_img = imag(r);

    sr = sign(s_real);
    si = sign(s_img);
    rr = sign(r_real);
    ri = sign(r_img);
    
    for i = 1:N       
        if sr(i) ~= rr(i) || si(i) ~= ri(i)
            total_errors = total_errors + 1;
        end
    end
    p = total_errors / N;
    % 2 bits per symbol
    ber_qpsk(n) = p / 2;
end

disp('Simulation QPSK Done.');

for n = 1:length(EbNodB)
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
    ber_qam16(n) = p / 4;
end

disp('Simulation 16QAM Done.');


% Simulation GRAPHs
% close all;
% figure;
% semilogy(EbNodB, ber_ook, 'LineWidth', 1);
% hold on;
% semilogy(EbNodB, ber_qpsk, 'LineWidth', 1);
% hold on;
% semilogy(EbNodB, ber_qam16, 'LineWidth', 1);
% axis([0 20 10^-6 1]);
% grid on;
% legend('BER OOK', 'BER QPSK', 'BER 16QAM');
% xlabel('Eb/No, dB');
% ylabel('Bit Error Rate');
% title('BER for all three modulations'); 


% Theoretical OOK
theorical_OOK = (1/2)*erfc(sqrt(EbNo/4));

% Theoretical QPSK
x_QPSK = sqrt(2*EbNo);
theorical_QPSK = (1/2)*erfc(x_QPSK/sqrt(2));

% Theoretical 16-QAM
x_16QAM = sqrt(3*4*EbNo/15);
theorical_16QAM = (3/4)*(1/2)*erfc(x_16QAM/sqrt(2));


% Theoretical GRAPHs
close all;
figure;
semilogy(EbNodB, theorical_OOK, 'LineWidth', 1);
hold on;
semilogy(EbNodB, theorical_QPSK, 'LineWidth', 1);
hold on;
semilogy(EbNodB, theorical_16QAM, 'LineWidth', 1);
axis([0 20 10^-6 1]);
grid on;
legend('BER OOK', 'BER QPSK', 'BER 16QAM');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for all three modulations'); 

