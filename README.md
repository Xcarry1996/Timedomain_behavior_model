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
- simplify functions to **conv3d_cim()**  
- cancel odd/even delay partition. (haven't seen any necessity, except for understanding code)  
- weight mapping method: from +1,-1 to 1,0 using rescale function.  
- TDC: half quantize method. rescale digital number to range[0,1], and scale back to delaysumvalue.  
- TDC range choise affects classification accuracy ->Finding best interval for delay quantization is under work.


**03.31 UPDATE**
--
- K=0.32 best accuracy = 96.70%(the result is greatly impressed by quantization division)
- next work: set different intervals for odd/even if the in case CELL_ROW is odd, change mismatch for different delay


**04.01 UPDATE**
--
- separate odd/even delay for TDC quantization(only 1 TDC in a column so detect them in seq)
- add coefficient to delay/cell mismatch(200:150:100ns -> 200/450:150/450:100/450)
- comments on conv3d and conv2d(different dimension sequence for convolution)
