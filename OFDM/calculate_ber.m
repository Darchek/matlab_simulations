function errors = calculate_ber(input, output)

    errors = 0;
    in_real = real(input) * sqrt(10);
    in_imag = imag(input) * sqrt(10);
    out_real = int8(real(output) * sqrt(10));
    out_imag = int8(imag(output) * sqrt(10));

    
    for n = 1:length(output)
        
        isGood = 0;
        
        if (in_real(n) < -2) && (out_real(n) < -2)
            isGood = 1;
        elseif  (in_real(n) < 0) && (in_real(n) < 0)
            isGood = 1;
        elseif  (in_real(n) < 2) && (in_real(n) < 2)
            isGood = 1;
        elseif  (in_real(n) < 4) && (in_real(n) < 4)
            isGood = 1;
        end
        
        if (in_imag(n) < -2) && (out_imag(n) < -2)
            isGood = isGood + 1;
        elseif  (in_imag(n) < 0) && (out_imag(n) < 0)
            isGood = isGood + 1;
        elseif  (in_imag(n) < 2) && (out_imag(n) < 2)
            isGood = isGood + 1;
        elseif  (in_imag(n) < 4) && (out_imag(n) < 4)
            isGood = isGood + 1;
        end
        
        if isGood ~= 2
            errors = errors + 1;
        end
           
    end
    
end