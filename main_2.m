
addpath('crc32');
addpath('modulations');
addpath('sample_files');
addpath('arq_methods/no_method');
addpath('arq_methods/stop_and_wait');

N = 10^6;
EbNodB = 3:1:15;
PACKET_LENGTH = 96;         % bytes
MODULATION = 'QPSK';        % OOK, QPSK, 16QAM
COUNT = 15;

% ARQ
%       send_message_no_arq
%       send_message_stop_and_wait

bler_theoric = zeros(1, length(EbNodB));
bler_simulat = zeros(1, length(EbNodB));

for n = 1:length(EbNodB)
    
    bler_theoric(n) = calc_PER(EbNodB(n), (PACKET_LENGTH + 4) * 8, MODULATION, COUNT);
    %[p_correct, p_wrong] = send_message_no_arq(EbNodB(n), PACKET_LENGTH, MODULATION, N);
    [p_correct, p_wrong] = send_message_stop_and_wait(EbNodB(n), PACKET_LENGTH, MODULATION, N, COUNT);
    bler_simulat(n) = (p_wrong / (p_correct + p_wrong));

    disp(['EbNo(dB): ', num2str(EbNodB(n)), ' - Correct: ', num2str(p_correct), '/', num2str(p_correct + p_wrong), ...
         ' - BLER: ', num2str(bler_simulat(n)), ' BLER_Threorical: ', num2str(bler_theoric(n))]);

end

close all;
figure;
plot(EbNodB, bler_theoric, 'LineWidth', 1);
hold on;
plot(EbNodB, bler_simulat, 'LineWidth', 1);
% axis([3 18 0 300]);
grid on;
legend('Theoric', 'Simulation');
xlabel('Eb/No, dB');
ylabel('BLER'); 
title(['BLER - ', MODULATION]); 

