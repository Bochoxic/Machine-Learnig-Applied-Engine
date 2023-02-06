function [beta,bias]=ELM(X,Y,nodos,parametros)
W=weight_matrix(nudos,parametros);
bias=repmat(-0.5+(0.5+0.5).*rand(1,1),nodos,1);
Hi=X*W';
Hi=[bias Hi];
H=sigmoid(Hi);
beta=pinv(H)*Y;
end


