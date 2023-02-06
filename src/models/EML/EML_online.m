%clear;clc;

%% Extracción de datos
%fprintf('Extrayendo datos... \n')
%procesar_geometria;

%% Entrenamiento datos offline
nodos=70;
[beta_off,W_off]=EML_train(Xt,Yt,nodos);
[Y_off_t,error_por_off_t,error_off_t]=EML_prediction(beta_off,Xt,Yt,W_off);
[Y_off_v,error_por_off_v,error_off_v]=EML_prediction(beta_off,Xv,Yv,W_off);
[Y_off_ad,error_por_off_adap,error_off_adap]=EML_prediction(beta_off,Xonl,Yonl,W_off);
[Y_off_norm,error_por_off_tot,error_off_tot]=EML_prediction(beta_off,Xnorm,Ynorm,W_off);
fprintf('Entrenamiento offline, error: %.5f \n',mean(error_off_tot))

%% Creación y actualización de buffer
%buffer_max=500;
%actualizacion_buffer=150;
%datos_validacion=100;
tic
X_buffer=Xt;
Y_buffer=Yt;

salida=struct('W',0,'beta',0,'Y',0,'error',0,'mean_error',0,'error_por',0,'mean_error_por',0);
for i=1:length(Xonl)-datos_validacion
    
    if mod(i,actualizacion_buffer)==1 && i~=1 
        if length(X_buffer)==buffer_max || length(X_buffer)>=buffer_max
            X_buffer=[X_buffer(1+actualizacion_buffer:end,:);Xonl(i-actualizacion_buffer:i,:)];
            Y_buffer=[Y_buffer(1+actualizacion_buffer:end,:);Yonl(i-actualizacion_buffer:i,:)];
        else
            X_buffer=[X_buffer;Xonl(i-actualizacion_buffer:i,:)];
            Y_buffer=[Y_buffer;Yonl(i-actualizacion_buffer:i,:)];
        end
    end

    [beta,W]=EML_train(X_buffer,Y_buffer,nodos);
    salida(i).W=W;
    salida(i).beta=beta;
    [Y_salida,error_por,error]=EML_prediction(beta,Xonl(i:i+datos_validacion,:),Yonl(i:i+datos_validacion,:),W);
    salida(i).Y=Y_salida;
    salida(i).error=error;
    salida(i).mean_error=mean(error);
    salida(i).error_por=error_por;
    salida(i).mean_error_por=mean(error_por);
    
    error_mean(i)=mean(error);
    error_mean_porCA10(i)=mean(error_por(1,1:3));
    error_mean_porCA50(i)=mean(error_por(1,4:6));
    error_mean_porCA90(i)=mean(error_por(1,7:9));
    error_mean_porRend(i)=mean(error_por(1,10:12));
    if mod(i,10)==1
        fprintf('iteración %d, error: %.5f \n',i ,mean(error))
    end
    
end
tiempo_ejecucion=toc;
%plot_eml_online;