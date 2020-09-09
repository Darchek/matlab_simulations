function res = receive_packet(packet, PACKET_LENGTH)
    message = packet(1:PACKET_LENGTH);
    crc = packet(PACKET_LENGTH + 1:PACKET_LENGTH + 4);
    res = check_crc32(message, crc);
        
    if res == 0
        res = 1;
    else
        res = 0;
    end
end

