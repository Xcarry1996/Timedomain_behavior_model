function output = conv3d_cim(image,filter)

global ROW_CELL;
global MAXDELAY;
global MIDDELAY;
global MINDELAY;
global CellMismatchEn;
global CellMismatch;

array_col = size(filter,1);
array_row = size(image,1)*size(image,2)*size(image,3);
step = size(image,3);

input = image(:);
inputsum = sum(input);

%array = zeros(array_row,array_col);
weight = zeros([size(filter,3)*size(filter,4),step]);
delay = zeros([array_row,array_col]);
absw = zeros([array_col,1]);



%mappaing weight to time domain delay array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
for c = 1:array_col
    
    for i = 1:step
        signedweight = sign(filter(c,i,:,:));%signed weight
        onezeroweight = (signedweight+1)/2;%rescale weight value [+1,-1] to [1,0]
        weight(:,i) = onezeroweight(:); %arrange weight in a temp array
    end

    weight_new = weight(:);    % turn temp array weight into vector
    absw(c) = filter(c,1,1,1)*sign(filter(c,1,1,1));%take abs weight value out for later resacle back to original value

    %WEIGHT TO TIME transformation
    for r = 1:array_row
        if input(r)==1&&weight_new(r)==1 
            delay(r,c) = MAXDELAY;%truth table result, i use average delay here
        elseif input(r)==-1&&weight_new(r)==1
            delay(r,c) = MINDELAY;
        else
            delay(r,c) = MIDDELAY;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%add cell delay mismatch 
delay_new = delay + CellMismatchEn*CellMismatch(1:array_row,1:array_col);


%Actually we need not to separate odd/even here, because the effect is
%obtain the delay sum, and mismatch set for each cell is different.
% %odd delay ->rise edge, even delay ->fall edge
% delay_odd  = delay_new(1:2:end,:);
% delay_even = delay_new(2:2:end,:);
% 
% delay_odd_sum  = sum(delay_odd);
% delay_even_sum = sum(delay_even);
% 
% %columndelay_value transform structure
% value_odd  = dvc(delay_odd_sum)*2-input_sum;%rescale sum'=weight'xinput to sum=weightxinput
% value_even = dvc(delay_even_sum)*2-input_sum;
% sum_odd  = absw.*value_odd;%rescale weight abs value to sum
% sum_even = absw.*value_even;
% output = sum_odd + sum_even;

delaysum = sum(delay_new);
valuesum = (delayquantize(delaysum)-ROW_CELL*MIDDELAY)/50;
valuesumrescale = valuesum*2-inputsum;%according to the equation:  delay = 150*row# + 50*sum(Xi*Wi), so me must choose delaymid = 0.5*(max-min)
output = absw.*valuesumrescale;

% delaysum = sum(delay_new);
% valuesum = (delaysum - ROW_CELL*MIDDELAY)/50*2-inputsum;
% output = absw.*valuesum';

%compare
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mulsum = zeros([array_col,1]);

for c = 1:array_col
    
    for i = 1:step
        temp = filter(c,i,:,:);%signed weight
        weight(:,i) = temp(:); %arrange weight in a temp array
    end
    weight1 = weight(:);
    mul = input.*weight1;
    mulsum(c) = sum(mul);
end

end