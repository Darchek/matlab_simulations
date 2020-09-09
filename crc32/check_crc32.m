function crc = check_crc32(data, crc_to_check)

crc_to_check = typecast(crc_to_check, 'uint32');
crc  = uint32(hex2dec('FFFFFFFF'));
poly = uint32(hex2dec('EDB88320'));     % hex EDB88320 CRC32 polynomial
data = uint8(data);

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
crc = bitcmp(crc);                  % crc as 1x1 uint 32
crc = bitxor(crc, crc_to_check); 


