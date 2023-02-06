clear;clc;
%% Preparación y limpieza de datos
PreparacionDatos;

%% Creación de matrices de la red neuronal
estructura_red=[entradas,20,20,salidas];
layer=struct('W',0,'value',0,'der',0,'trans',0);
Number_W=length(estructura_red)-1;
for i1=1:Number_W
    %layer(i1).W=rand(estructura_red(i1),estructura_red(i1+1))-0.5;
    init=1.0/sqrt(estructura_red(i1)+1);
    layer(i1).W=weight_matrix_nn(estructura_red(i1)+1,estructura_red(i1+1),init);
end
%% train
max_it=1e6;
n_train=size(Xt,1);
learning_rate=0.0000000001;
k_ac=0.5/n_train;
err_all=ones(max_it,1);
err_por=ones(max_it,estructura_red(end));
tot=1:1:size(Xt,1);
tot_train = tot(randperm(n_train));
it=1;
%%
tic
while (err_all(it)>=0.001&&it<=max_it)
        
%     for sa=1:n_train% number of instances
        input=Xt(tot_train,:);               % taking one instance each time
        in_la=[input,ones(length(tot_train),1)];                 % input at each layer
        output=Yt(tot_train,:);              % load one target each time

        % b. calculate hidden layers (forward propagation)
            for i=1:Number_W
                Wi=layer(i).W;
                layer(i).value=tanh(in_la*Wi); % calculate the hidden layer
                layer(i).der=1-(layer(i).value).^2;
                if i==Number_W
                  out_m=layer(i).value;
                else
                  in_la=[layer(i).value,ones(length(tot_train),1)];            % set the actual hidden layers as the input of the next layer 
                end
            end 
        % c. calculate the error
        error=output-out_m;% 
        err_all(it)=sqrt(mse(error));
        err_por(it,:)=mean(abs(error./output))*100;
        
        % d.update weights if the error doesn't satisfy our coditions (C2)
        % d.1. calculate traversing_value of each  hidden layer (backword propagation)

        %%%% backpropagation starts from here%%%%
         for i=Number_W:-1:1 
             if i==Number_W
                 layer(i).trans=error.*layer(i).der; % compute & Store The traversing_value      
             else
                layer(i).trans=layer(i).der.*(layer(i+1).trans*layer(i+1).W(1:end-1,:)');
             end
         end
         %%%% backpropagation ends here%%%%
         % d.2.weights correction
         for i=1:Number_W
                if i==1
                 layer(i).W(1:end-1,:)=layer(i).W(1:end-1,:)+k_ac*(input'*layer(i).trans); % update weights step1
                else
                 layer(i).W(1:end-1,:)=layer(i).W(1:end-1,:)+k_ac*(layer(i-1).value'*layer(i).trans); % update weights step1  
                end
         end
         if mod(it,100)==0
             fprintf('iteración %d, error CA50: %.5f, error NOx: %.5f, error Rendimiento: %.5f  \n',it ,err_por(it,1),err_por(it,2), err_por(it,3))
         end
         %if mod(it,50000)==0
           %  k_ac=k_ac*0.5;
         %end
         it=it+1;
end 
toc
 %% validation
[Y_salida,err_val_all,err_val_por]=NN_prediccion_bias_tanh(layer,Xv,Yv,estructura_red);