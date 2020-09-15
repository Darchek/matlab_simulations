
clear all; 
close all; 
N = 1024; 
CR = 0; 
EbNodB = [0, 1: 2: 13];
EbNo = 10 .^ (EbNodB / 10); 
alpha16qam = [-3 -1 1 3]; 
error = 0; 
n = 1; 
total = 0;

% for z = 0:2 
    CR = CR + 3; 
    CR = 9;
    while n <= length(EbNodB) 
        s = randsrc(1, N, alpha16qam) + j * randsrc(1, N, alpha16qam); 
        x = ifft(s) * sqrt(N / 2); 
        xrms = rms(x); % mean power / root mean square 
        A = (10 ^ (CR / 20)) * xrms; 
        xclipped = ((abs(x) > A) * A).*exp(j * angle(x)) + (abs(x) <= A).*x; % clip 
        xclippedrms = rms(xclipped); 
        w = (1 / sqrt(2 * 4 * EbNo(n))) * (randn(1, N) + j * randn(1, N)); % add noise 
        xnoise = xclipped / xclippedrms + w;
        stem(1:N, real(xnoise));
        X = fft(xnoise) / sqrt(N / 2); 
        r = X; % Received signal 
        
        si_ = real(r) * xclippedrms; 
        sq_ = imag(r) * xclippedrms; % Quadrature demodulation 
        siq_re = 2 * floor(abs(si_) / 2).*sign(si_) + sign(si_); % received real 
        siq_im = 2 * floor(abs(sq_) / 2).*sign(sq_) + sign(sq_); % imag part 
        demoduerr_re = find(abs(siq_re) > 3); % correction 
        siq_re(demoduerr_re) = sign(siq_re(demoduerr_re)) * 3; 
        demoduerr_im = find(abs(siq_im) > 3); 
        siq_im(demoduerr_im) = sign(siq_im(demoduerr_im)) * 3; 
        EBR = find(real(s) ~= siq_re); % counting real part error 
        err_re(n) = 0; 
        err_im(n) = 0; 
        
        for y = 1: length(EBR) % counting real bit error 
            err_re(n) = err_re(n) + abs(sign(real(s(EBR(y)))) - sign(siq_re(EBR(y)))) * abs(abs(real(s(EBR(y)))) - abs(siq_re(EBR(y)))) / 2 / 2 + 1; 
        end
        
        EBI = find(imag(s) ~= siq_im); % imag error 
        
        for y = 1: length(EBI) % imag bit error 
            err_im(n) = err_im(n) + abs(sign(imag(s(EBI(y)))) - sign(siq_im(EBI(y)))) / 2 * abs(abs(imag(s(EBI(y)))) - abs(siq_im(EBI(y)))) / 2 + 1; 
        end
        
        error = error + err_re(n) + err_im(n); 
        total = total + N; 
        
        if error > 200 % update BER 
            ber(n) = error / total / 4; % bit error rate 
            error = 0; 
            total = 0; 
            n = n + 1; 
        end
        
        if n < length(EbNodB) 
            x = 0; 
            X = 0; 
        end 
    end 
    n = 1; 
    semilogy(EbNodB, ber, 'o-') 
    hold on; 
    % pause; 
% end 
QAM16theoryBer = 3 / 8 * erfc(sqrt(2 / 5 * EbNo));

semilogy(EbNodB, QAM16theoryBer); 
% hold on; 
% 
% N = 1024; 
% CR = 0; 
% x = 0; 
% X = 0; 
% EbNodB = 0:2:10; 
% EbNo = 10 .^ (EbNodB / 10); 
% alpha4qam = [-1 1]; 
% error = 0; 
% n = 1; 
% total = 0; 
% ber = 0; 
% for y = 0: 2 
% CR = CR + 3; 
% while n <= length(EbNodB) 
% s = randsrc(1, N, alpha4qam) + j * randsrc(1, N, alpha4qam); % random 4 QAM 
% x = ifft(s) * sqrt(N / 2); % IFFT 
% xrms = rms(x); % mean power / root mean square 
% A = (10 ^ (CR / 20)) * xrms; 
% xclipped = ((abs(x) > A) * A).*exp(j * angle(x)) + (abs(x) <= A).*x; % clip 
% xclippedrms = rms(xclipped); 
% w = (1 / sqrt(2 * 2 * EbNo(n))) * (randn(1, N) + j * randn(1, N)); % add noise 
% xnoise = xclipped / xclippedrms + w; 
% X = fft(xnoise) / sqrt(N / 2); 
% r = X; 
% si_ = real(r) * xclippedrms; % for BER 
% sq_ = imag(r) * xclippedrms; % Quadrature demodulation 
% siq_re = 2 * floor(abs(si_) / 2).*sign(si_) + sign(si_); 
% siq_im = 2 * floor(abs(sq_) / 2).*sign(sq_) + sign(sq_); 
% demoduerr_re = find(abs(siq_re) > 1); 
% siq_re(demoduerr_re) = sign(siq_re(demoduerr_re)); 
% demoduerr_im = find(abs(siq_im) > 1); 
% siq_im(demoduerr_im) = sign(siq_im(demoduerr_im)); 
% EBR = find(real(s) ~= siq_re); 
% err_re(n) = 0; 
% err_im(n) = 0; 
% for y = 1: length(EBR) 
% err_re(n) = err_re(n) + abs(sign(real(s(EBR(y)))) - sign(siq_re(EBR(y)))) * abs(abs(real(s(EBR(y)))) - abs(siq_re(EBR(y)))) / 2 / 2 + 1; 
% end 
% EBI = find(imag(s) ~= siq_im); 
% for y = 1: length(EBI) 
% err_im(n) = err_im(n) + abs(sign(imag(s(EBI(y)))) - sign(siq_im(EBI(y)))) / 2 * abs(abs(imag(s(EBI(y)))) - abs(siq_im(EBI(y)))) / 2 + 1; 
% end 
% error = error + err_re(n) + err_im(n); 
% total = total + N; 
% if error > 50 % update BER 
% ber(n) = error / total / 2; % bit error rate 
% error = 0; 
% total = 0; 
% n = n + 1; 
% end 
% if n < length(EbNodB) x = 0; 
% X = 0; 
% end 
% end 
% n = 1; 
% semilogy(EbNodB, ber, 'o-') 
% hold on; 
% % pause; 
% end 
% QAM4theoryBer = qfunc(sqrt(2 * EbNo)); 
% semilogy(EbNodB, QAM4theoryBer);

hold on; 
% legend('16QAM, CR=3', '16QAM, CR=6', '16QAM, CR=9', '16QAM Theoretical', '4QAM, CR=3', '4QAM, CR=6', '4QAM, CR=9', '4QAM Theoretical'); 
% title('16QAM BER and 4QAM BER vs EbNo with different CR'); 
xlabel('EbNo(dB)') 
ylabel('BER') 
grid on;