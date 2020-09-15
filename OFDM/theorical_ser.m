function the_ser = theorical_ser(EbNodB)

    global MODULATION;
    ebn0 = 10.^(EbNodB/10);

	if contains(MODULATION, 'QPSK')
        the_ser = 0;
	elseif contains(MODULATION, '16QAM')
        the_ser = (3/8)*erfc(sqrt((2/5)*ebn0)); 
	elseif contains(MODULATION, '64QAM')
        the_ser = 0;
	end
    
end