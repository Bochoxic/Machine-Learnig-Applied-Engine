function [Y,Y_der] = SoftPlus(X)
%LINEAL Función de activación lineal
%   Detailed explanation goes here
%a=length(X);
Y=log(1+exp(X));
Y_der=1./(1+exp(-X));
end
