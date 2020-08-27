function crc = crc32_slow(data)

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
crc = typecast(crc, 'uint8');         % crc as 1x4 uint 8

