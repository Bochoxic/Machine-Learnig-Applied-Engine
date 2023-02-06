function [Y,Y_der]=Softmax(X)
Y=exp(X)./sum(exp(X));
delta=eye(size(X));
Y_der=Y.*(delta-Y);
end