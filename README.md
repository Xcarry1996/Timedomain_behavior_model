# Timedomain_behavior_model 

KEYWORDS:  TDCIM  
TESTBENCH:  CNN  
DATASETS:   MNIST  
CELLTYPE:   SRAM  
UNIDEALELEMENT: CELLMISMATCH TDCMISMATCH  



**03.29 UPDATE**  
--
**DISCRIPTION**:  
* offline classification  
* pretrained weights in 9900model
* binarized convolution in second layer 
* hardware discription(tdc,adder,delay)

**FORWORD**:
* separate &discribe hardware(read,write,shiftadder)
* new TESTBENCH(MLP,CNN+,selfdefined network)
* new DATASETS(cifar10,fashionMNIST,etc.)
* backpropagation?(how to solve weight precisions)
* noise/mismatch distribution model(norm,others)
* circuit/transistor level(cap,res,delay,area,power)

