function the_ber = theorical_ber(EbNodB)

    global MODULATION;
    ebn0 = 10.^(EbNodB/10);

	if contains(MODULATION, 'QPSK')
        the_ber = (1/2)*erfc(sqrt(2*ebn0)/sqrt(2));
	elseif contains(MODULATION, '16QAM')
        the_ber = (3/8)*erfc(sqrt((2/5)*ebn0)); 
	elseif contains(MODULATION, '64QAM')
        the_ber = (2/3)*(7/8)*(1/2)*erfc(sqrt(3*6*ebn0/63)/sqrt(2));
	end
    
end