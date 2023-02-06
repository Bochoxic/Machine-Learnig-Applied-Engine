function [Y_salida,err_val_all,err_val_por]=NN_prediccion(layer,X,Y,estructura_red)
Y_salida=ones(size(X,1),1);
number_W=length(estructura_red)-1;
for j=1:size(X,1)

    input=X(j,:);
    input_layer=input;
    
    
    for i1=1:number_W
        Wi=layer(i1).W;
        if i1==number_W
            out_m=sigmoid(input_layer*Wi);
        else
            input_layer=sigmoid(input_layer*Wi);
        end
    end
    Y_salida(j)=out_m;
end
error=Y-Y_salida;
err_val_all=sqrt(mse(error));
err_val_por=mean(abs(error./Y))*100;
figure;hold on;
plot(Y)
plot(Y_salida)
end