function output = dvc(input)
%time to value converter
global K;
global MAXDELAY;
global MINDELAY;
global TDC_BIT;
global ROW_CELL;

global TdcMismatchEn;
global TdcMismatch;

%cell?number of cell in a column used for MAC
max_delay = MAXDELAY*ROW_CELL*0.76;%19000/25000
min_delay = MINDELAY*ROW_CELL*1.20;%15000/12500


NumofInput = length(input);
Vector_out = zeros([NumofInput,TDC_BIT]);%time to digital vector
addvalue = zeros([NumofInput,1]);%digital number of vector
output = zeros([NumofInput,1]);

min_value = -30*K; %number before gen from permutation.m
max_value =  30*K; 


%transfer time value to digital vector from top to bottom 
for i = 1:NumofInput
    Vector_out(i,:) = tdc(input(i),min_delay,max_delay,TDC_BIT,TdcMismatchEn,TdcMismatch(:,i)); 
    %permutation shows the connection between delay and value is linear and symmetric, so we can use ths tdc in bineary cut method
end

%rescale value to min_value~max_value with precision of bit
for i = 1:NumofInput
    addvalue(i) = adder(Vector_out(i,:));
    output(i) = addvalue(i)/(pow2(TDC_BIT)-1)*(max_value-min_value)+min_value;
end

end