global ARRAY_ROW;
global ARRAY_COL;
global MAXDELAY;
global MINDELAY;
global TDC_BIT;
global TdcMismatch;
global TdcMismatchEn;
global CellMismatch;
global CellMismatchEn;
global K;
global MAXPOOL_DIM;


ARRAY_ROW = 128;    %Chip cell array row number
ARRAY_COL = 64;     %Chip cell array col number
MAXDELAY  = 150;    %max time domain delay
MINDELAY  = 50;     %min time domain delay
TDC_BIT   = 2;      %TDC precision
K         = 0.35;   %time to value rescale parameter
MAXPOOL_DIM = [2 2];%Maxpool function filter [row# col#]

CellMismatchEn = 0; %enable cellmismatch
CellMismatch = normrnd(0,0.5*0.005,ARRAY_ROW,ARRAY_COL);

TdcMismatchEn = 0;  %enable tdcmismatch
TdcMismatch = zeros([TDC_BIT,ARRAY_COL]);
for i =1:TDC_BIT
    TdcMismatch(TDC_BIT-i+1,:) = normrnd(0,0.5/pow2(i-1)*0.005,1,ARRAY_COL);%Mismatch distribution function
end

disp('Specify chip parameter succesfully...');