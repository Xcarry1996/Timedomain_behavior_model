function pred = cnn_model1(Image)
    load('matmodel/model9900.mat');

    convLayer1 = conv_basic(Image,conv1_w, conv1_b);
    BNLayer1   = BatchNorm(convLayer1,bn_conv1_mean,bn_conv1_var,ones([1,20]), zeros([1,20]));
    reluLayer1 = relu(BNLayer1);
    poolLayer1 = Maxpool(reluLayer1);

    BNLayer2   = BatchNorm(poolLayer1,bin_conv2_mean,bin_conv2_var,bin_conv2_bn_w,bin_conv2_bn_b);
    signLayer2 = sign(BNLayer2);
    relu_scale = relu(signLayer2);
    convLayer2 = conv_binary(relu_scale,bin_conv2_w,bin_conv2_b);
    reluLayer2 = relu(convLayer2);
    poolLayer2 = Maxpool(reluLayer2);

    fcLayer1 = linearize_binary(poolLayer2,bin_ip1_w,bin_ip1_b,bin_ip1_mean,bin_ip1_var,bin_ip1_bn_w,bin_ip1_bn_b);
    fcLayer2 = fcLayer1*ip2_w'+ip2_b;
    
    %Prediction = order of Maximum output value
    [~,pred]=max(fcLayer2);
    pred = pred-1;

end
