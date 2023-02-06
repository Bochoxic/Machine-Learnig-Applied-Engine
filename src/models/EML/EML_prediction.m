function [Yv,error_por,error]=EML_prediction(beta,XV,YV,W)
Yv=sigmoid(XV*W')*beta;
error_por=mean(abs((Yv-YV)./YV))*100;
error=sqrt(mean((Yv-YV).^2));
end