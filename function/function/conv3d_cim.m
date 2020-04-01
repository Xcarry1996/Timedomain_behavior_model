function output = conv3d_cim(image,filter)

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
%if weight = +1,-1
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

%%%%%%%%%%%%%%%%%%% add cell delay mismatch %%%%%%%%%%%%%%%%%%
delay_w = delay/(MAXDELAY + MIDDELAY + MINDELAY);%mismatch value has ratio relation with delaytime
delay_new = delay + CellMismatchEn*(delay_w.*CellMismatch(1:array_row,1:array_col));


%%%%%%%%%%%%%%%% odd/even sperate quantization mapping%%%%%%%%%%%%%%%%%%%%%%%%
%odd delay ->rise edge, even delay ->fall edge, detection for rise/fall
%edges are in sequence, so we must do it seperately
delay_odd  = delay_new(1:2:end,:);
delay_even = delay_new(2:2:end,:);

odd_row = size(delay_odd,1);
even_row = size(delay_even,1);

delay_oddsum  = sum(delay_odd);
delay_evensum = sum(delay_even);

%columndelay_value transform structure
value_odd  = (delayquantize(delay_oddsum,odd_row)-odd_row*MIDDELAY)/50;%rescale sum'=weight'xinput to sum=weightxinput
value_even = (delayquantize(delay_evensum,even_row)-even_row*MIDDELAY)/50;

valuesum = value_odd + value_even;%adder, then multiply
valuerescale = valuesum*2-inputsum;

output = absw.*valuerescale;

%%%%%%%%%%%%%%%%% delay quantization mapping %%%%%%%%%%%%%%%%%%%%
% delaysum = sum(delay_new);
% valuesum = (delayquantize(delaysum)-ROW_CELL*MIDDELAY)/50;%according to the equation:  delay = 150*row# + 50*sum(Xi*Wi)
% valuesumrescale = valuesum*2-inputsum;%rescale back w' to w on valuesum
% output = absw.*valuesumrescale;

%%%%%%%%%%%%%%%% delay non-quantization mapping %%%%%%%%%%%%%%%%%%
% delaysum = sum(delay_new);
% valuesum = (delaysum - ROW_CELL*MIDDELAY)/50*2-inputsum;
% output = absw.*valuesum';


%%%%%%%%% without weight-to-delay mapping %%%%%%%%%%%%%%%% 
% mulsum = zeros([array_col,1]);
% 
% for c = 1:array_col
%     
%     for i = 1:step
%         temp = filter(c,i,:,:);%signed weight
%         weight(:,i) = temp(:); %arrange weight in a temp array
%     end
%     weight1 = weight(:);
%     mul = input.*weight1;
%     mulsum(c) = sum(mul);
% end

end