clear;clc;
%% Ajuste parámetros
learning_rate=0.00001;
attempts=300;
error_desired=5;

%% Preparación y limpieza de datos
procesar_geometria;
n_train=length(Xt);
err_all=ones(n_train, attempts);
err_prc=ones(n_train, attempts);
%% Creación de matrices de la red neuronal
estructura_red=[8,20,12];
layer=struct('W',0,'value',0,'der',0,'trans',0);
number_W=length(estructura_red)-1;
init=1.0/sqrt(estructura_red(i1)+1);
for i1=1:number_W
    %layer(i1).W=rand(estructura_red(i1),estructura_red(i1+1))-0.5;
    layer(i1).W=weight_matrix_nn(estructura_red(i1),estructura_red(i1+1),init);
end

%% Entrenamiento
tic
i=1;
while 1
    %actualizar entrada de cada capa
    for j=1:n_train 
        input=Xt(j,:);
        input_layer=input;
        output=Yt(j,:);
        
        %calculamos las capas ocultas (foward propagation)
        for i1=1:number_W 
            Wi=layer(i1).W;
            layer(i1).value=sigmoid(input_layer*Wi);
            layer(i1).der=layer(i1).value.*(1-layer(i1).value);
            if i1==number_W
                out_m=layer(i1).value;
            else 
                input_layer=layer(i1).value;
            end
        end
        
        %Calculamos los errores
        error=output-out_m;
        RMSE=sqrt(mse(error));
        err_all(j,i)=RMSE;
        err_prc(j,i)=mean(abs((error)./output)*100);

        
        %Backpropagation
        for i2=number_W:-1:1
            if i2==number_W
                layer(i2).trans=error.*layer(i2).der;
            else
                layer(i2).trans=layer(i2).der.*(layer(i2+1).trans*layer(i2+1).W');
            end
        end
        
        %Actualización de pesos
        for i3=1:number_W
            if i3==1
                layer(i3).W=layer(i3).W+learning_rate*(input'*layer(i3).trans);
            else
                layer(i3).W=layer(i3).W+learning_rate*(layer(i3-1).value'*layer(i3).trans);
            end
        end
    end
    error_prc_ind=mean(err_prc(:,i));
    formatSpec = 'Iteración nº%d, error %f \n';
    fprintf(formatSpec,i,error_prc_ind);
    if error_prc_ind<error_desired
        break
    end
    if i>=attempts
        break
    end
    i=i+1;
end
toc
%% Validación

out_all=ones(size(Xv,1),1);
for j=1:size(Xv,1)

    input=Xv(j,:);
    input_layer=input;
    output=Yv(j,:);
    
    for i1=1:number_W
        Wi=layer(i1).W;
        if i1==number_W
            out_m=sigmoid(input_layer*Wi);
        else
            input_layer=sigmoid(input_layer*Wi);
        end
    end
    out_all(j)=out_m;
end
figure;hold on;
plot(out_all)
plot(Yv)

out_all=ones(size(XNorm,1),1);
for j=size(XNorm,1)

    input=XNorm(j,:);
    input_layer=input;
    output=Y(j,:);
    
    for i1=1:number_W
        Wi=layer(i1).W;
        if i1==number_W
            out_m=sigmoid(input_layer*Wi);
        else
            input_layer=sigmoid(input_layer*Wi);
        end
    end
    out_all(j)=out_m;
end
figure;hold on;
plot(out_all)
plot(Y)
