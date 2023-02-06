function [Y_salida,err_val_all,err_val_por]=NN_prediccion_bias_tanh(layer,X,Y,estructura_red,plotting)
[a,b]=size(Y);
Y_salida=ones(a,b);
number_W=length(estructura_red)-1;
tot_train=a;
for j=1:size(X,1)

    input=X(j,:);
    input_layer=[input,ones(length(tot_train),1)];
    
    
    for i1=1:number_W
        Wi=layer(i1).W;
        value=tanh(input_layer*Wi);
        if i1==number_W
            out_m=value;
        else
            input_layer=[value,ones(length(tot_train),1)];
            
        end
    end
    Y_salida(j,:)=out_m;
end
error=Y-Y_salida;
err_val_all=sqrt(mse(error));
err_val_por=nanmean(abs(error./Y))*100;
if plotting==1
    for i=1:b
        figure;hold on;
        plot(Y(:,i))
        plot(Y_salida(:,i))
    end
end