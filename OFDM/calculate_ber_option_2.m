function errors = calculate_ber_option_2(mod_input, output)

    siq_re = 2 * floor(abs(real(output)) / 2).*sign(real(output)) + sign(real(output)); % received real 
    siq_im = 2 * floor(abs(imag(output)) / 2).*sign(imag(output)) + sign(imag(output)); % imag part 

    demoduerr_re = find(abs(siq_re) > 3); % correction 
    siq_re(demoduerr_re) = sign(siq_re(demoduerr_re)) * 3; 
    demoduerr_im = find(abs(siq_im) > 3); 
    siq_im(demoduerr_im) = sign(siq_im(demoduerr_im)) * 3; 

    EBR = find(real(mod_input) ~= siq_re); % counting real part error 
    err_re = 0; 
    err_im = 0; 

    for y = 1: length(EBR) % counting real bit error 
        err_re = err_re + abs(sign(real(mod_input(EBR(y)))) - sign(siq_re(EBR(y)))) * abs(abs(real(mod_input(EBR(y)))) - abs(siq_re(EBR(y)))) / 2 / 2 + 1; 
    end

    EBI = find(imag(mod_input) ~= siq_im); % imag error 

    for y = 1: length(EBI) % imag bit error 
        err_im = err_im + abs(sign(imag(mod_input(EBI(y)))) - sign(siq_im(EBI(y)))) / 2 * abs(abs(imag(mod_input(EBI(y)))) - abs(siq_im(EBI(y)))) / 2 + 1; 
    end
        
    errors = err_re + err_im; 
    
end