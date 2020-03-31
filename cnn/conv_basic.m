function feature = conv_basic(images, W, b)

image_ch = size(images, 3);
image_dim = size(images, 1);
filter_dim = size(W,3);
filter_num = size(W,1);

feature_dim = image_dim - filter_dim + 1;
%initialization
feature = zeros(feature_dim, feature_dim, filter_num);
%handle one pic and one filter a time
for filterNum = 1:filter_num
    convolvedImage = zeros(feature_dim, feature_dim);
    
    for ch = 1:image_ch
        filter = squeeze(W(filterNum,ch ,:, :));%take 1 filter
        img = squeeze(images(:, :, ch));%take 1 image
        conv_temp = conv2d(img,filter);%generate 1 feature
        convolvedImage = convolvedImage+conv_temp;
    end
    
    convolvedImage = convolvedImage + b(filterNum);
    feature(:, :, filterNum) = convolvedImage;%load 1 feature
end

end