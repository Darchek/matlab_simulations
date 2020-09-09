
message = 0b1101100111011010u32;
messageLength = 16;
divisor = 0b1111u32;
divisorDegree = 3;


divisor = bitshift(divisor,messageLength-divisorDegree-1);
divisor = bitshift(divisor,divisorDegree);
remainder = bitshift(message,divisorDegree);
for k = 1:messageLength
    if bitget(remainder,messageLength+divisorDegree)
        remainder = bitxor(remainder,divisor);
    end
    remainder = bitshift(remainder,1);
end
CRC_check_value = bitshift(remainder,-messageLength);
dec2bin(CRC_check_value)


remainder = bitshift(message, divisorDegree);
dec2bin(remainder)
remainder = bitor(remainder, CRC_check_value);
% remainder = bitset(remainder,6);

dec2bin(message)
dec2bin(remainder)


for k = 1:messageLength
    if bitget(remainder,messageLength+divisorDegree)
        remainder = bitxor(remainder,divisor);
    end
    remainder = bitshift(remainder,1);
end
% if remainder == 0
%     disp('Message is error free.')
% else
%     disp('Message contains errors.')
% end


