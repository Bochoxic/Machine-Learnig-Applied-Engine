function [Y,Y_der] = tangenteh(X)
%LINEAL Función de activación lineal
%   Detailed explanation goes here
%a=length(X);
Y=tanh(X);
Y_der=1-Y.^2;
end
