Y=Datos(1:end,entradas+1:end);
Y_salida_sn=Y_salida.*((max(Y)+0.1)-(min(Y)-0.1))+(min(Y)-0.1);
Y_salida_cp=Datos(1:end,entradas+1:end);

for i=1:salidas
figure;hold on;
plot(Y_salida_cp(:,i))
plot(Y_salida_sn(:,i))
end