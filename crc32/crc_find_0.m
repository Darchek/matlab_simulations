

for k = 1:intmax('uint32')

    crc = uint32(k);
    poly = uint32(hex2dec('EDB88320'));     % hex EDB88320 CRC32 polynomial
    data = uint8([ uint8(198), uint8(199) ]);

    for i = 1:length(data)
        crc = bitxor(crc, uint32(data(i)));
        for j = 1:8
            mask = bitcmp(bitand(crc, uint32(1)));
            if mask == intmax('uint32')
                mask = 0;               % All '0'
            else
                mask = mask + 1;        % All '1'
            end
            crc = bitxor(bitshift(crc, -1), bitand(poly, mask));
        end
    end
    crc = bitcmp(crc);
    
	if crc == 0
        disp('Message is error free.');
        k
	else
%     disp('Message contains errors.')
	end

end

disp('Done.');