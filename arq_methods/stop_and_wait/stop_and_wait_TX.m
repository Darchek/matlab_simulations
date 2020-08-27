
function res = stop_and_wait_TX(f)

    % ARQ method - TX - STOP & WAIT - Wait for receiver to send ACK

    % RoundTripTime (RTT) = 0.1  -> TO = 2 * RTT = 0.2
    RTT = 0.2;
    period = RTT / 2000;
    time = 0;
    
    while time < RTT && contains(f.State, 'running')
        pause(period);
        time = time + period;
    end

    if(time == RTT)
        res = 0;
        disp('Time out!');
    else
        res = fetchOutputs(f);   
    end
    
end
