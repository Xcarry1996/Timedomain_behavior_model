function output = tdc(input,min_delay,max_delay,bit,en,tdcmismatch)


mid_delay = (min_delay + max_delay)/2;
halfrange = (max_delay - min_delay)/2;

if bit == 1
    
    if input > mid_delay + en * halfrange * tdcmismatch
        output = 1;
    else 
        output = 0;
    end   
    
else
    for i = 1:bit
        if input > mid_delay + en * halfrange * tdcmismatch(bit)
            % if tdcmismatch = 1, excute tdcmismatch
            output = [1,tdc(input,mid_delay,max_delay,bit-1,en,tdcmismatch(1:(bit-1)))];
        else 
            output = [0,tdc(input,min_delay,mid_delay,bit-1,en,tdcmismatch(1:(bit-1)))];
        end
    end
end