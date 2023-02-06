%% Pre-entrenamiento
clc;clear;
NN_class_missfire;
%% Cargar capa
n_train=length(Yonl);
attempts=100;


%% Creación nueva Red y cargamos datos de la preentrenada
estructura_red=ones(1,length(layer)+1);
learning_rate=0.00001;

for i=1:length(layer)
    if i==1
        [a,b]=size(layer(i).W);
        estructura_red(i)=a;
        estructura_red(i+1)=b;
    end
    [a,b]=size(layer(i).W);
    estructura_red(i+1)=b;
    
end
layerNN=struct('W',0,'value',0,'der',0,'trans',0);
number_W=length(estructura_red)-1;
for i1=1:number_W
    layerNN(i1).W=layer(i1).W;
end

err_all=ones(n_train,attempts);
err_prc=ones(n_train,attempts,estructura_red(end));
error_prc_ind=ones(attempts,estructura_red(end));
%% Entrenamiento Online
tic
i=1;
while 1
    %actualizar entrada de cada capa
    for j=1:n_train 
        input=Xonl(j,:);
        in_la=[input,1];
        output=Yonl(j,:);
        
        %calculamos las capas ocultas (foward propagation)
        for i1=1:number_W 
            Wi=layerNN(i1).W;
            layerNN(i1).value=tanh(in_la*Wi);
            layerNN(i1).der=1-(layerNN(i1).value).^2;
            if i1==number_W
                out_m=layerNN(i1).value;
            else 
                in_la=[layerNN(i1).value,1];
            end
        end
        
        %Calculamos los errores
        error=output-out_m;
        RMSE=sqrt(mse(error));
        err_all(j,i)=RMSE;
        err_prc(j,i,:)=abs((error)./output)*100;

        
        %Backpropagation
        for i2=number_W:-1:1
            if i2==number_W
                layerNN(i2).trans=error.*layerNN(i2).der;
            else
                layerNN(i2).trans=layerNN(i2).der.*(layerNN(i2+1).trans*layerNN(i2+1).W(1:end-1,:)');
            end
        end
        
        %Actualización de pesos
        for i3=1:number_W
            if i3==1
                layerNN(i3).W(1:end-1,:)=layerNN(i3).W(1:end-1,:)+learning_rate*(input'*layerNN(i3).trans);
            else
                layerNN(i3).W(1:end-1,:)=layerNN(i3).W(1:end-1,:)+learning_rate*(layerNN(i3-1).value'*layerNN(i3).trans);
            end
        end
    end
    error_prc_ind(i)=mean(err_all(:,i));
    formatSpec = 'Iteración nº%d, error: %.5f \n';
    fprintf(formatSpec,i,error_prc_ind(i));
    if i>=attempts
        break
    end
    i=i+1;
end
tiempo_online=toc

%% Validación
plotting=0;
[Y_salida,err_val_all,err_val_por]=NN_prediccion_bias_tanh(layer,Xonl,Yonl,estructura_red,plotting);
[Y_salida_onl,err_val_all_onl,err_val_por_on]=NN_prediccion_bias_tanh(layerNN,Xonl,Yonl,estructura_red,plotting);
