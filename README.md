# Timedomain_behavior_model 

KEYWORDS: CIM TD BEHAVOIR_MODEL  
TESTBENCH: CNN  
DATASETS: MNIST  
CELLTYPE: SRAM  
UNIDEALELEMENT: CELLMISMATCH TDCMISMATCH  



03.29 UPDATE  
DISCRIPTION: 
* offline classification
* pretrained weights in 9900model
* binarized convolution in second layer 
* hardware discription(tdc,adder,delay)

FORWORD:
1. separate &discribe hardware(read,write,shiftadder)
2. new TESTBENCH(MLP,CNN+,selfdefined network)
3. new DATASETS(cifar10,fashionMNIST,etc.)
4. backpropagation?(how to solve weight precisions)
5. noise/mismatch distribution model(norm,others)
6. circuit/transistor level(cap,res,delay,area,power)

