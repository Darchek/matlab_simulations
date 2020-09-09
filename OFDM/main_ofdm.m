
addpath('../crc32');
addpath('../modulations');
addpath('../arq_methods/no_method');
addpath('../arq_methods/stop_and_wait');

global N;
global PACKET_LENGTH;
global MODULATION;
global N_ifft;
global bps;

N = 10^5;
PACKET_LENGTH = 96;         % bytes
MODULATION = '16QAM';       % OOK, QPSK, 16QAM, 64QAM
N_ifft = 64;
bps = bits_per_symbol();

EbNodB = -20:1:40;

ber = zeros(1, length(EbNodB));
the = zeros(1, length(EbNodB));

for n = 1:length(EbNodB)
    
	ber(n) = send_message_OFDM(EbNodB(n));
    the(n) = (1/4)*3/2*erfc(sqrt(4*0.1*(10.^(EbNodB(n)/10))));     %16QAM

end

% close all;
figure;
semilogy(EbNodB, the, 'LineWidth', 1);
hold on;
semilogy(EbNodB, ber, 'LineWidth', 1);
grid on;
axis([0 40 10^-6 1]);
legend('Theoric', 'Simulation');
xlabel('Eb/No, dB');
ylabel('BER'); 
title(['BER - ', MODULATION]); 

