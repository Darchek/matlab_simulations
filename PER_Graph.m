
EbNodB = 0:1:20;
PACKET_LENGTH = 96;         % bytes
MODULATION = 'OOK';         % QPSK, 16QAM, OOK

per = zeros(1, length(EbNodB));

for i = 1:length(EbNodB)
   per(i) = calc_PER(EbNodB(i), (PACKET_LENGTH + 4) * 8, MODULATION) * 100;
end

% close all;
hold on;
% figure;
semilogy(EbNodB, per, 'LineWidth', 1);
%axis([0 20 0 10^-6]);
grid on;
legend('OOK', 'QPSK', '16QAM');
xlabel('Eb/No, dB');
ylabel('Packet error ratio, %');
title('PER'); 

