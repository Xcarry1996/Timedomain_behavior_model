function bnedsFeature = BatchNorm(images, mean, var, W, b)

numImages = size(images, 3);
bnedsFeature = zeros(size(images));
sqrtvar = sqrt(var);
ivar = 1./sqrtvar;
for imagesNum = 1:numImages
    bnedsFeature(:,:,imagesNum)=(images(:,:,imagesNum)-mean(imagesNum))*ivar(imagesNum);
    bnedsFeature(:,:,imagesNum)=bnedsFeature(:,:,imagesNum)*W(imagesNum)+b(imagesNum);
end    

end