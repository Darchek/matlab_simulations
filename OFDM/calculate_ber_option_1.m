function errors = calculate_ber_option_1(input, output)

    global MODULATION;
    errors = 0;
    
    % Normalize modulation here or in IFFT ?
    
%     in_real = real(input) * sqrt(10);
%     in_imag = imag(input) * sqrt(10);
%     out_real = int8(real(output) * sqrt(10));
%     out_imag = int8(imag(output) * sqrt(10));
    
    in_real = real(input);
    in_imag = imag(input);
    out_real = real(output);
    out_imag = imag(output);

    
    for n = 1:length(output)
        
        isGood = 0;
        
        if contains(MODULATION, 'QPSK')
            if (in_real(n) < 0) && (out_real(n) < 0)
                isGood = 1;
            elseif  (in_real(n) > 0) && (out_real(n) > 0)
                isGood = 1;
            end

            if  (in_imag(n) < 0) && (out_imag(n) < 0)
                isGood = isGood + 1;
            elseif  (in_imag(n) > 0) && (out_imag(n) > 0)
                isGood = isGood + 1;
            end
        end
                       
        if contains(MODULATION, '16QAM')
            if (in_real(n) < -2) && (out_real(n) < -2)
                isGood = 1;
            elseif  (in_real(n) < 0) && (out_real(n) < 0) && (in_real(n) > -2) && (out_real(n) > -2)
                isGood = 1;
            elseif  (in_real(n) < 2) && (out_real(n) < 2) && (in_real(n) > 0) && (out_real(n) > 0)
                isGood = 1;
            elseif  (in_real(n) > 2) && (out_real(n) > 2)
                isGood = 1;
            end

            if (in_imag(n) < -2) && (out_imag(n) < -2)
                isGood = isGood + 1;
            elseif  (in_imag(n) < 0) && (out_imag(n) < 0) && (in_imag(n) > -2) && (out_imag(n) > -2)
                isGood = isGood + 1;
            elseif  (in_imag(n) < 2) && (out_imag(n) < 2) && (in_imag(n) > 0) && (out_imag(n) > 0)
                isGood = isGood + 1;
            elseif  (in_imag(n) > 2) && (out_imag(n) > 2) 
                isGood = isGood + 1;
            end
        end
        
        if contains(MODULATION, '64QAM')
            if (in_real(n) < -6) && (out_real(n) < -6)
                isGood = 1;      
            elseif (in_real(n) < -4) && (out_real(n) < -4) && (in_real(n) > -6) && (out_real(n) > -6)
                isGood = 1;          
            elseif (in_real(n) < -2) && (out_real(n) < -2) && (in_real(n) > -4) && (out_real(n) > -4)
                isGood = 1;
            elseif  (in_real(n) < 0) && (out_real(n) < 0) && (in_real(n) > -2) && (out_real(n) > -2)
                isGood = 1;
            elseif  (in_real(n) < 2) && (out_real(n) < 2) && (in_real(n) > 0) && (out_real(n) > 0)
                isGood = 1;
            elseif  (in_real(n) < 4) && (out_real(n) < 4) && (in_real(n) > 2) && (out_real(n) > 2)
                isGood = 1;
            elseif  (in_real(n) < 6) && (out_real(n) < 6) && (in_real(n) > 4) && (out_real(n) > 4)
                isGood = 1;
            elseif  (in_real(n) > 6) && (out_real(n) > 6)
                isGood = 1; 
            end

            if (in_imag(n) < -6) && (out_imag(n) < -6)
                isGood = isGood + 1;      
            elseif (in_imag(n) < -4) && (out_imag(n) < -4) && (in_imag(n) > -6) && (out_imag(n) > -6)
                isGood = isGood + 1;        
            elseif (in_imag(n) < -2) && (out_imag(n) < -2) && (in_imag(n) > -4) && (out_imag(n) > -4)
                isGood = isGood + 1;
            elseif  (in_imag(n) < 0) && (out_imag(n) < 0) && (in_imag(n) > -2) && (out_imag(n) > -2)
                isGood = isGood + 1;
            elseif  (in_imag(n) < 2) && (out_imag(n) < 2) && (in_imag(n) > 0) && (out_imag(n) > 0)
                isGood = isGood + 1;
            elseif  (in_imag(n) < 4) && (out_imag(n) < 4) && (in_imag(n) > 2) && (out_imag(n) > 2)
                isGood = isGood + 1;
            elseif  (in_imag(n) < 6) && (out_imag(n) < 6) && (in_imag(n) > 4) && (out_imag(n) > 4)
                isGood = isGood + 1;
            elseif  (in_imag(n) > 6) && (out_imag(n) > 6)
                isGood = isGood + 1; 
            end
        end
        
        if isGood ~= 2
            errors = errors + 1;
        end
           
    end
    
end