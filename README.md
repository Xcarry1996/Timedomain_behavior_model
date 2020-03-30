# Timedomain_behavior_model 

:four_leaf_clover::four_leaf_clover:
:hamster::cow::tiger::rabbit::dragon::snake::horse::sheep::monkey::chicken::dog::pig:

```
KEYWORDS        TDCIM  
TESTBENCH       CNN  
DATASETS        MNIST  
CELLTYPE        SRAM  
UNIDEALELEMENT  CELLMISMATCH/TDCMISMATCH  
```


**03.29 UPDATE**  
--
>**DISCRIPTION**  
- [x] offline classification  
- [x] pretrained weights in 9900model
- [x] binarized convolution in second layer 
- [x] hardware discription(tdc,adder,delay)

>**FORWORD**
- [ ] separate &discribe hardware(read,write,shiftadder)
- [ ] TESTBENCH(MLP,CNN+,selfdefined network)
- [ ] new DATASETS(cifar10,fashionMNIST,etc.)
- [ ] backpropagation?(how to solve weight precisions)
- [ ] noise/mismatch distribution model(norm,others)
- [ ] circuit/transistor level(cap,res,delay,area,power)


**03.30 UPDATE**
--
- **delaytovalue（）** -> **delayquantize（）**  
- simplify functions to **convolution3d()**  
- cancel odd/oven delay partition. (haven't seen any necessity, except for understanding code)  
- weight mapping method: from +1,-1 to 1,0 using rescale function.  
- TDC: half quantize method. rescale digital number to range[0,1], and then back to delayvalue again.  
- TDC range choise affects test accuracy.Finding different interval for delaysum's quantization is under work.
