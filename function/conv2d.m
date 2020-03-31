function [state,opnum]=conv2d(data,kernel)


[data_row,data_col]=size(data);
[kernel_row,kernel_col]=size(kernel);
state=zeros(data_col-kernel_col+1,data_row-kernel_row+1);
opnum=zeros(data_col-kernel_col+1,data_row-kernel_row+1);
for m=1:data_col-kernel_col+1
    for n=1:data_row-kernel_row+1
        state(m,n)=sum(sum(data(m:m+kernel_row-1,n:n+kernel_col-1).*kernel));   
    end
end

end