function output = conv_binary(image, W, b)

global ARRAY_ROW;
global TDC_BIT;

image_dim = size(image,1);
image_ch = size(image,3);
filter_dim = size(W,3);
filter_num = size(W,1);
feature_dim = image_dim - filter_dim + 1;


%number of filters we use in each convolution
step = floor(ARRAY_ROW/(filter_dim*filter_dim));   
rowcell = step*image_dim*image_dim;


output = zeros(feature_dim,feature_dim,filter_num);

for r = 1:feature_dim
    for c = 1:feature_dim
        for h = 1:step:image_ch
            %prepare input & weight into cell array
            x_temp = image(r:r+filter_dim-1,c:c+filter_dim-1,h:h+step-1); 
            w_temp = W(:,h:h+step-1,:,:);
            
            %odd delay time ->rise edge, even delay time ->fall edge
            [delay_odd,delay_even,absw] = delaytime_cim(x_temp,w_temp);
            
            y_temp_odd = absw.*dvc(delay_odd,TDC_BIT,rowcell);
            y_temp_even = absw.*dvc(delay_even,TDC_BIT,rowcell);
            y_temp = y_temp_odd + y_temp_even;
            %add value to new feature map
            for i = 1:filter_num
                output(r,c,i) = output(r,c,i)+y_temp(i);
            end    
            
        end
        for i = 1:filter_num
            output(r,c,i) = output(r,c,i)+b(i);
        end
    end
end

