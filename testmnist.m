%%%%%%%%%%%%%%%%%%%%%%
% MNIST TESTING FUNCTION
% CNN MODEL:
%     convLayer1 = conv_basic(Image,conv1_w, conv1_b);
%     BNLayer1   = BatchNorm(convLayer1,bn_conv1_mean,bn_conv1_var,ones([1,20]), zeros([1,20]));
%     reluLayer1 = relu(BNLayer1);
%     poolLayer1 = Maxpool(reluLayer1);
% 
%     BNLayer2 = BatchNorm(poolLayer1,bin_conv2_mean,bin_conv2_var,bin_conv2_bn_w,bin_conv2_bn_b);
%     signLayer2 = sign(BNLayer2);
%     convLayer2 = conv_binary(signLayer2,bin_conv2_w,bin_conv2_b);
%     reluLayer2 = relu(convLayer2);
%     poolLayer2 = Maxpool(reluLayer2);
% 
%     fcLayer1 = linearize_binary(poolLayer2,bin_ip1_w,bin_ip1_b,bin_ip1_mean,bin_ip1_var,bin_ip1_bn_w,bin_ip1_bn_b);
%     fcLayer2 = fcLayer1*ip2_w'+ip2_b;

%%%%%%%%%%%%%%%%%%%
% clc;
% clear;
% close all;
%%%%%%%%%%%%%%%%%%%
addpath image;
addpath function;
addpath cnn;
addpath td_cim;

param; %specify parameter of hardware and algorithm
loadimg;%load images


%TESTING SETTING
%%%%%%%%%%%%%%%%%%%
Batchsize = 100;




%TESTING VARIABLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
correctNum = 0;
acc = zeros([Batchsize,1]);
p = randperm(length(testLabels),Batchsize);



%TIMER & WAITBAR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%t0 = clock; %starting time
%h = waitbar(0,'TESTING');



%Start Offline Classification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
for i = 1:Batchsize
    pred = cnn_model1(testImages(:,:,p(i))); 
    if pred == testLabels(p(i))
        correctNum = correctNum+1;
    end         
    acc(i) = correctNum/i;
    %h = waitbar(i/Batchsize,h,['TIME DOMAIN COMPUTING IN MEMORY--MNIST TESTING :   ',num2str(i/Batchsize*100),'%']);
end
fprintf('CELLMISMATCH: %d, TDCMISMATCH: %d\n',CellMismatchEn,TdcMismatchEn);
fprintf('MNIST image batchsize: %d\n',Batchsize);
fprintf('Offline classification accuracy is %.2f%%\n',100*acc(Batchsize));
%fprintf('Runing time: %.2fs\n',etime(clock,t0)); %ending time
%close(h);
toc



%ENDING SOUND
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load chirp
sound(y,Fs)
