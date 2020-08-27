
function [p_goods, p_bad, seconds] = send_message_stop_and_wait(EBN0_dB, PACKET_LENGTH, MODULATION)

    text_file = fileread('sample_file_short.txt');
    message = uint8(text_file);
    result = zeros(1, ceil(length(message) / PACKET_LENGTH));
   	n = 1;
    count = 0;
    tic;
    
%	p_bar = waitbar(0, 'Loading...');
    while n <= length(message)
        packet_96 = create_packet(message, n, PACKET_LENGTH);
        crc = crc32_slow(packet_96);
        tx_packet = [packet_96, crc];
        
        % Without TimeOut(TO)
        res = send_packet_stop_and_wait(tx_packet, EBN0_dB, PACKET_LENGTH, MODULATION);
        
        % With TimeOut(TO)
        % f = parfeval(@send_packet_stop_and_wait, 1, tx_packet, EBN0_dB, PACKET_LENGTH, MODULATION);
        % res = stop_and_wait_TX(f);
        
        index = ceil(n / PACKET_LENGTH);
        if res == 6                       % ACK OK
            result(index) = 1;
            n = n + PACKET_LENGTH;
            count = 0;
        elseif res == 15                  % NACK - REPEAT
            result(index) = 0;
            count = count + 1;
        else                            % UNKNOW ARQ - REPEAT
            result(index) = 0;
            count = count + 1;
            % disp([num2str(index), '. Error in ACK --> ', num2str(a)]);
        end
        
        if count == 5
            result(index) = 0;
            n = n + PACKET_LENGTH;
            count = 0;
            % disp(['4 times, packet number ', num2str(index), ' is lost']);
        end
        
%       percent = n / length(message);
%       waitbar(percent, p_bar, ['Loading... ', num2str(round(percent * 100)), '%']);
    end
    
%	close(p_bar);

    seconds = toc;
    p_goods = size(strfind(result, 1), 2);
    p_bad = size(strfind(result, 0), 2);
end
