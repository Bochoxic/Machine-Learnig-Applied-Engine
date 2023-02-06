aciertos11=0;
errores10=0;
aciertos00=0;
errores01=0;
umbral=0.5;
Y_aciertos=Ynorm;
for i=1:length(Y_salida)
    if Y_salida(i)>=umbral && Y_aciertos(i)==1
        aciertos11=aciertos11+1;
    elseif Y_salida(i)<umbral && Y_aciertos(i)==0
        aciertos00=aciertos00+1;
    elseif Y_salida(i)>=umbral && Y_aciertos(i)==0
        errores10=errores10+1;
    elseif Y_salida(i)<umbral && Y_aciertos(i)==1
        errores01=errores01+1;
    end
            
end
salidilla=[aciertos11, errores01, errores10, aciertos00]./length(Y_aciertos)
