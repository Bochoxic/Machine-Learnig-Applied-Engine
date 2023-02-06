clear;clc;

%% Extracción de datos
fprintf('Extrayendo datos... \n')
find_missfire;

%% Entrenamiento redes
error_por_t=zeros(50,salidas);
error_por_v=zeros(50,salidas);
error_t=zeros(50,salidas);
error_v=zeros(50,salidas);
aciertos_v=zeros(250,1);
errores_v=zeros(250,1);
fprintf('Entrenando EML... \n')
for nn=1:250
    [beta,W]=EML_train(Xt,Yt,nn);
    [Y_salida_t,error_por_t(nn,:),error_t(nn,:)]=EML_prediction(beta,Xt,Yt,W);
    [Y_salida_v,error_por_v(nn,:),error_v(nn,:)]=EML_prediction(beta,Xv,Yv,W);
    
end

figure; plot(error_t);hold on; plot(error_v);
figure; plot(aciertos_v);

tic
[beta,W]=EML_train(Xt,Yt,80);
tiempo_entrenamiento=toc;
[Y_salida_t,error_por_t_ind,error_t_ind]=EML_prediction(beta,Xt,Yt,W);
[Y_salida_v,error_por_v_ind,error_v_ind]=EML_prediction(beta,Xv,Yv,W);