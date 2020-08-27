
function [p_goods, p_bad, seconds] = send_message_no_arq(EBN0_dB, PACKET_LENGTH, MODULATION)

    tic;

    text_file = fileread('sample_file_short.txt');
    message = uint8(text_file);
    result = zeros(1, ceil(length(message) / PACKET_LENGTH));
   	n = 1;
    
    while n <= length(message)
        packet_96 = create_packet(message, n, PACKET_LENGTH);
        crc = crc32_slow(packet_96);
        tx_packet = [packet_96, crc];
        
        a = send_packet_no_arq(tx_packet, EBN0_dB, PACKET_LENGTH, MODULATION);

        index = ceil(n / PACKET_LENGTH);
        result(index) = a;
        n = n + PACKET_LENGTH;
    end
    
    seconds = toc;
    p_goods = size(strfind(result, 1), 2);
    p_bad = size(strfind(result, 0), 2);
end
