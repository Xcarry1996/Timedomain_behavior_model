function linearedFeatures= linearize_binary(images,W,b,mean,var,gama,beta)

reshapeFeatures=zeros(size(images));
numImages = size(images, 3);

bnedsFeatures= BatchNorm(images,mean, var, gama, beta);
signFeatures=sign(bnedsFeatures);
for i=1:numImages
     reshapeFeatures(:,:,i)=signFeatures(:,:,i)';
end
activationsPooled = reshape(reshapeFeatures,[],1);
linearedFeatures=relu(activationsPooled'*W'+b);
end
