function [beta,W]=EML_train_tanh(X,Y,nodos)
[~,b]=size(X);
W=weight_matrix(nodos,b);
%bias=rand(nodos,1);
Hi=X*W';
%Hi=[bias'; Hi];
H=tanh(Hi);
beta=pinv(H)*Y;
end
