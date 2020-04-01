function pooledFeatures = Maxpool(convolvedFeatures)
global MAXPOOL_DIM;
%cnnPool Pools the given convolved features
%
% Parameters:
%  poolDim - dimension of pooling region, is a 1 * 2 vector(poolDimRow poolDimCol);
%  convolvedFeatures - convolved features to pool (as given by cnnConvolve)
%                      convolvedFeatures(imageRow, imageCol, featureNum, imageNum)
%
% Returns:
%  pooledFeatures - matrix of pooled features in the form
%                   pooledFeatures(poolRow, poolCol, featureNum, imageNum)
%  weights        - how much the input contributes to the output

numImages = size(convolvedFeatures, 3);
% numFilters = size(convolvedFeatures, 3);
convolvedDimRow = size(convolvedFeatures, 1);
convolvedDimCol = size(convolvedFeatures, 2);
feature_Row = floor(convolvedDimRow / MAXPOOL_DIM(1));
feature_Col = floor(convolvedDimCol / MAXPOOL_DIM(2));

weights = zeros(size(convolvedFeatures));
featuresTrim = convolvedFeatures(1:feature_Row*MAXPOOL_DIM(1),1:feature_Col*MAXPOOL_DIM(2),:);



pooledFeatures = zeros(feature_Row, feature_Col, numImages);


for imageNum = 1:numImages
	features = featuresTrim(:,:,imageNum);
%   case 'maxpool'
        temp = im2col(features, MAXPOOL_DIM, 'distinct');
        [m, i] = max(temp);
        temp = zeros(size(temp));
        temp(sub2ind(size(temp),i,1:size(i,2))) = 1;
        weights(1:feature_Row*MAXPOOL_DIM(1),1:feature_Col*MAXPOOL_DIM(2),imageNum) = col2im(temp, MAXPOOL_DIM,[feature_Row*MAXPOOL_DIM(1) feature_Col*MAXPOOL_DIM(2)], 'distinct');
        pooledFeatures(:,:,imageNum) = reshape(m, size(pooledFeatures,1), size(pooledFeatures,2));         
end
end
 