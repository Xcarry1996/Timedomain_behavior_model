function output = delayquantize(input)
%time to value converter
global MAXDELAY;
global MINDELAY;
global TDC_BIT;
global ROW_CELL;
global K;

global TdcMismatchEn;
global TdcMismatch;

differ = ROW_CELL*(MAXDELAY-MINDELAY)/2;
middle = ROW_CELL*(MAXDELAY+MINDELAY)/2;
%cell?number of cell in a column used for MAC
max_delay = middle + differ*K;
min_delay = middle - differ*K;


NumofInput = length(input);
Vector_out = zeros([NumofInput,TDC_BIT]);%time to digital vector
addvalue = zeros([NumofInput,1]);%digital number of vector
output = zeros([NumofInput,1]);


%quantize time value to digital vector from top to bottom 
for i = 1:NumofInput
    Vector_out(i,:) = tdc(input(i),min_delay,max_delay,TDC_BIT,TdcMismatchEn,TdcMismatch(:,i)); 
    %permutation shows the connection between delay and value is linear and symmetric, so we can use ths tdc in bineary cut method
end

%rescale quantized value to min_value~max_value with precision of bit
for i = 1:NumofInput
    addvalue(i) = adder(Vector_out(i,:));
    output(i) = addvalue(i)/(pow2(TDC_BIT)-1)*(max_delay-min_delay)+min_delay;
end

end