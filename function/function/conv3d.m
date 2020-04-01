function feature = conv3d(image,filter)
%output feature: 1x1, filter_num->output: [1,filter_num]

filter_num = size(filter,1);
filter_ch =size(filter,2);
feature = zeros([1,filter_num]);

for num = 1:filter_num
    for ch = 1:filter_ch
        image_temp = squeeze(image(ch,:,:));
        filter_temp = squeeze(filter(num,ch,:,:));
        feature_temp = conv2d(image_temp,filter_temp);
        feature(num) = feature(num) + feature_temp;
    end
end