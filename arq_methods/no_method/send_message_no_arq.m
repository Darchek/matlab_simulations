
function [p_goods, p_bad] = send_message_no_arq(EBN0_dB)

    global N;
    global PACKET_LENGTH;
    
    % text_file = fileread('sample_file_short.txt');
    byte_values = randsrc(1, N, (0:1:255));
    message = uint8(byte_values);
    result = zeros(1, ceil(length(message) / PACKET_LENGTH));
   	n = 1;
    
    while n <= length(message)
        packet_96 = create_packet(message, n);
        crc = get_crc32(packet_96);
        tx_packet = [packet_96, crc];
        
        a = send_packet_no_arq(tx_packet, EBN0_dB);

        index = ceil(n / PACKET_LENGTH);
        result(index) = a;
        n = n + PACKET_LENGTH;
    end
    
    p_goods = size(strfind(result, 1), 2);
    p_bad = size(strfind(result, 0), 2);
end
