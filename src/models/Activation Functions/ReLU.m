function [Y,Y_der] = ReLU(X)
%LINEAL Función de activación lineal
%   Detailed explanation goes here
a=length(X);
Y=max(0,X);
Y_der=zeros(a,1);
for i=1:a
    if X(i)<0
        Y_der(i)=0;
    end
    if X(i)>0
        Y_der(i)=1;
    end
    if X(i)==0
        Y_der(i)=NaN
    end
end
