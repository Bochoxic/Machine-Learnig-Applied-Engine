function [Y,Y_der] = sigmoide2(X)
%LINEAL Función de activación lineal
%   Detailed explanation goes here
%a=length(X);
Y=1./(1+exp(-X));
Y_der=Y.*(1-Y);
end
