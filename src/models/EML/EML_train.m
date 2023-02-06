function [beta,W]=EML_train(X,Y,nodos)
[~,b]=size(X);
W=weight_matrix(nodos,b);
%bias=rand(nodos,1);
Hi=X*W';
%Hi=[bias'; Hi];
H=sigmoid(Hi);
beta=pinv(H)*Y;
end


