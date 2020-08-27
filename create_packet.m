function packet = create_packet(message, i, packet_length)
    if(i <= length(message) - packet_length)
        packet = message(i:i + packet_length - 1);
    else
        pckt = message(i:length(message));
        padding = uint8(zeros(1, packet_length - length(message) + i - 1));     % padding with 0 the rest of the message
        packet = [pckt, padding];
    end
end