%LAODING MNIST IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imageDim = 28;

inputImages = loadMNISTImages('image/t10k-images-idx3-ubyte');
testImages = reshape(inputImages,imageDim,imageDim,[]);
testLabels = loadMNISTLabels('image/t10k-labels-idx1-ubyte');

disp('load MNIST images successfully...')