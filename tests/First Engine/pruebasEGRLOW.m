clear;clc;
procesar_geometria;
length_batch=32;
%% Prueba 1
k_ac=0.5/length_batch;
NN_diesel;
tiempo1=tiempo_entrenamiento;
err__all_1=err_all;
err_por_1=err_por;
layer1=layer;
clear layer estructura_red

%% Prueba 2
k_ac=0.1/length_batch;
NN_diesel;
tiempo2=tiempo_entrenamiento;
err__all_2=err_all;
err_por_2=err_por;
layer2=layer;
clear layer estructura_red

%% Prueba 3
k_ac=0.05/length_batch;
NN_diesel;
tiempo3=tiempo_entrenamiento;
err__all_3=err_all;
err_por_3=err_por;
layer3=layer;
clear layer estructura_red

%% Prueba 4
k_ac=0.01/length_batch;
NN_diesel;
tiempo4=tiempo_entrenamiento;
err__all_4=err_all;
err_por_4=err_por;
layer4=layer;
clear layer estructura_red

%% Prueba 5
k_ac=1/length_batch;
NN_diesel;
tiempo5=tiempo_entrenamiento;
err__all_5=err_all;
err_por_5=err_por;
layer5=layer;
clear layer estructura_red

%% Prueba 6
k_ac=0.005/length_batch;
NN_diesel;
tiempo6=tiempo_entrenamiento;
err__all_6=err_all;
err_por_6=err_por;
layer6=layer;
clear layer estructura_red