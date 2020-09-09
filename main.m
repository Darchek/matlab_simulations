
addpath('crc32');
addpath('modulations');
addpath('sample_files');
addpath('arq_methods/no_method');
addpath('arq_methods/stop_and_wait');

EbNodB = 3:1:18;
PACKET_LENGTH = 96;         % bytes
MODULATION = 'QPSK';        % OOK, QPSK, 16QAM

% ARQ
%       send_message_no_arq
%       send_message_stop_and_wait

throughputs = zeros(1, length(EbNodB));

for i = 1:length(EbNodB)
    
    per_te = calc_PER(EbNodB(i), (PACKET_LENGTH + 4) * 8, MODULATION);
    
    if per_te ~= 1
        [p_correct, p_wrong, seconds] = send_message_no_arq(EbNodB(i), PACKET_LENGTH, MODULATION);
        per_ex = (p_wrong / (p_correct + p_wrong));

        tght = ((p_correct * PACKET_LENGTH * 8)/ seconds) / 1000;
        throughputs(i) = tght;

        disp(['EbNo(dB): ', num2str(EbNodB(i)), ' - Correct: ', num2str(p_correct), '/', num2str(p_correct + p_wrong), ...
             ' - Throughput: ', num2str(tght), ' Kbps']);
%      	disp(['EbNo(dB): ', num2str(EbNodB(i)), ' - Correct: ', num2str(p_correct), '/', num2str(p_correct + p_wrong), ...
%              ' - PER: ', num2str(per_ex), ' PER_Threorical: ', num2str(per_te)]);
    else
        throughputs(i) = 0;
        disp(['EbNo(dB): ', num2str(EbNodB(i)), ' - Throughput: 0 Kbps']);
    end
end

% close all;
hold on;
% figure;
plot(EbNodB, throughputs, 'LineWidth', 1);
axis([3 18 0 300]);
grid on;
legend('With TimeOut', 'No TimeOut');
xlabel('Eb/No, dB');
ylabel('Throughput, Kbps'); 
title('Throughput - STOP & WAIT - QPSK'); 

