function packet = create_packet(message, i)

	global PACKET_LENGTH;
    
    if(i <= length(message) - PACKET_LENGTH)
        packet = message(i:i + PACKET_LENGTH - 1);
    else
        pckt = message(i:length(message));
        padding = uint8(zeros(1, PACKET_LENGTH - length(message) + i - 1));     % padding with 0 the rest of the message
        packet = [pckt, padding];
    end
end