clear;clc;
%% Preparación y limpieza de datos
PreparacionDatos;

%% Creación de matrices de la red neuronal
estructura_red=[7,20,20,20,3];
layer=struct('W',0,'value',0,'der',0,'trans',0);
Number_W=length(estructura_red)-1;
for i1=1:Number_W
    %layer(i1).W=rand(estructura_red(i1),estructura_red(i1+1))-0.5;
    init=1.0/sqrt(estructura_red(i1)+1);
    layer(i1).W=weight_matrix_nn(estructura_red(i1)+1,estructura_red(i1+1),init);
end
%% train
max_it=1e6;
length_batch=32;
batches=1:length_batch:1653;
n_train=size(Xt,1);
learning_rate=0.0000000001;
k_ac=0.1/length_batch;
err_all=ones(max_it,1);
err_por=ones(max_it,estructura_red(end));
it=1;
err_batch_all=ones(length(batches),1);
err_batch_por=ones(length(batches),3);

%%
tic
while (err_all(it)>=0.001&&it<=max_it)
        for sa=1:length(batches)-1% number of instances
            starter=batches(sa);
            ender=batches(sa+1)-1;
            input=Xt(starter:ender,:);               % taking one instance each time
            in_la=[input,ones(length_batch,1)];                 % input at each layer
            output=Yt(starter:ender,:);              % load one target each time

         % b. calculate hidden layers (forward propagation)
            for i=1:Number_W
                Wi=layer(i).W;
                layer(i).value=tanh(in_la*Wi); % calculate the hidden layer
                layer(i).der=1-(layer(i).value).^2;
                if i==Number_W
                  out_m=layer(i).value;
                else
                  in_la=[layer(i).value,ones(length_batch,1)];            % set the actual hidden layers as the input of the next layer 
                end
            end 
        % c. calculate the error
            error=output-out_m;%
            err_batch_all(sa)=sqrt(mse(error));
            err_batch_por(sa,:)=mean(abs(error./output))*100;

        
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
        end
         err_all(it)=mean(err_batch_all);
         err_por(it,:)=mean(err_batch_por);
         if mod(it,100)==0
             fprintf('iteraci�n %d, error: %.5f, error CA50: %.5f, error NOx: %.5f, error Rendimiento: %.5f  \n',it,err_all(it),err_por(it,1),err_por(it,2), err_por(it,3))
         end
         %if mod(it,50000)==0
           %  k_ac=k_ac*0.5;
        it=it+1;
end
toc
 %% validation
[Y_salida,err_val_all,err_val_por]=NN_prediccion_bias_tanh(layer,Xv,Yv,estructura_red);