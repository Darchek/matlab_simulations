function res = decisor(s_real, s_img)

    res = zeros(1, length(s_real));
    
    %    th = s_real > 0;
    %    r(th) = 0;
    
    th = s_real < 0;
    res(th) = 1000;
    th = abs(s_real) > 2;
    res(th) = res(th) + 100;
    
    th = find(s_img < 0);
    res(th) = res(th) + 10;
    th = find(abs(s_img) > 2);
    res(th) = res(th) + 1;
end