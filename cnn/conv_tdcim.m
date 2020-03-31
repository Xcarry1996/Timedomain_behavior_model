% conv_tdcim aims for mapping from conv to hardware. 
% conv for one single feature for all filters num
% for example, 50 filters and 5x5 filter*image,
% we calculate for all filters and most image channel for once

function feature = conv_tdcim(image, W, b)

global ARRAY_ROW;
global ROW_CELL;

image_dim = size(image,1);
image_ch  = size(image,3);
filter_dim = size(W,3);
filter_num = size(W,1);
feature_dim = image_dim - filter_dim + 1;


%number of filters we use in each convolution
step = floor(ARRAY_ROW/(filter_dim*filter_dim));   
ROW_CELL = step*filter_dim*filter_dim;


feature = zeros(feature_dim,feature_dim,filter_num);

for r = 1:feature_dim
    for c = 1:feature_dim
        for h = 1:step:image_ch
            
            %prepare input & weight into cell array
            partimage = image(r:r+filter_dim-1,c:c+filter_dim-1,h:h+step-1); 
            partweight = W(:,h:h+step-1,:,:);
            prodsum = conv3d_cim(partimage,partweight);

            for i = 1:filter_num
                feature(r,c,i) = feature(r,c,i)+prodsum(i);
            end    
            
        end
        for i = 1:filter_num
            feature(r,c,i) = feature(r,c,i)+b(i);
        end
    end
end

