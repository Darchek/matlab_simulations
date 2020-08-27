function res = receive_packet(packet, PACKET_LENGTH)
    message = packet(1:PACKET_LENGTH);
    crc = packet(PACKET_LENGTH + 1:PACKET_LENGTH + 4);
    crc_calc = crc32_slow(message);
    if size(strfind(crc == crc_calc, 1), 2) == 4
        res = 1;
    else
        res = 0;
    end
end