function [delay_odd, delay_even,absw]=delaytime_cim(image,w)

global CellMismatchEn;
global CellMismatch;
array_col = size(w,1);
array_row = size(image,1)*size(image,2)*size(image,3);
step = size(image,3);

input = image(:);
%array = zeros(array_row,array_col);
weight = zeros([size(w,3)*size(w,4),step]);
delay = zeros([array_row,array_col]);
absw = zeros([array_col,1]);



for c = 1:array_col
    
    absw(c) = w(c,1,1,1)*sign(w(c,1,1,1));%take abs weight value out
    
    %put weight into a column
    for i = 1:step
        temp = sign(w(c,i,:,:));
        weight(:,i) =temp(:); 
    end
    
    weight_new =weight(:);    % create signed weight vector
    %array(:,c) = image_new.*weight_new;
    %WEIGHT TO TIME transformation
    for r = 1:array_row
        if input(r)==1&&weight_new(r)==1 
            delay(r) = 200;%truth table result, i use average delay here
        elseif input(r)==1&&weight_new(r)==-1
            delay(r) = 150;
        elseif input(r)==0&&weight_new(r)==1
            delay(r) = 100;
        else
            delay(r) = 150;
        end
    end
end


delay_new = delay + CellMismatchEn*CellMismatch(1:array_row,1:array_col);


array_odd = delay_new(1:2:end,:);
array_even = delay_new(2:2:end,:);
delay_odd = sum(array_odd);
delay_even = sum(array_even);

end