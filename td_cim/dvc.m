function output = dvc(input,bit,rowcell)
%time to value converter
global K;
global MAXDELAY;
global MINDELAY;

global TdcMismatchEn;
global TdcMismatch;

%cell?number of cell in a column used for MAC
max_delay = MAXDELAY*rowcell*0.8;%this LUT gen from permutation.m
min_delay = MINDELAY*rowcell*1.4;

NumofInput = length(input);
Vector_out = zeros([NumofInput,bit]);%time to digital vector
addvalue = zeros([NumofInput,1]);%digital number of vector
output = zeros([NumofInput,1]);

min_value = -20*K; %number before gen from permutation.m
max_value = 20*K; 


%transfer time value to digital vector from top to bottom 
for i = 1:NumofInput
    Vector_out(i,:) = tdc(input(i),min_delay,max_delay,bit,TdcMismatchEn,TdcMismatch(:,i)); 
    %permutation shows the connection between delay and value is linear and symmetric, so we can use ths tdc in bineary cut method
end

%rescale value to min_value~max_value with precision of bit
for i = 1:NumofInput
    addvalue(i) = adder(Vector_out(i,:));
    output(i) = addvalue(i)/(pow2(bit)-1)*(max_value-min_value)+min_value;
end

end