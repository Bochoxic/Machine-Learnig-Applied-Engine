function [Yv,error_por,error]=EML_prediction_tanh(beta,XV,YV,W)
Yv=tanh(XV*W')*beta;
error_por=mean(abs((Yv-YV)./YV))*100;
error=sqrt(mean((Yv-YV).^2));
end