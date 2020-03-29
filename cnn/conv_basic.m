function convolvedFeatures= conv_basic(images, W, b)

numImages = size(images, 3);
imageDim = size(images, 1);
filterDim = size(W,3);
numFilters = size(W,1);

convDim = imageDim - filterDim + 1;
%initialization
convolvedFeatures = zeros(convDim, convDim, numFilters);
for filterNum = 1:numFilters
    convolvedImage = zeros(convDim, convDim);
    
    for imageNum = 1:numImages
        filter = W(filterNum,imageNum ,:, :);
        filter = squeeze(filter);
        % Obtain the image
        im = squeeze(images(:, :, imageNum));
        convolvedImage_temp = conv_2d(im,filter);
        convolvedImage=convolvedImage+convolvedImage_temp;
    end
    
    convolvedImage=convolvedImage+b(filterNum);
    convolvedFeatures(:, :, filterNum) = convolvedImage;
end

end