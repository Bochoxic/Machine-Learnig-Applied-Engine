[beta,W]=EML_train(XT,YT,15);
Yv=EML_prediction(beta,XV,W);
E=mean(abs((Yv-CA50_1(4002:5138))./CA50_1(4002:5138)))*100
e=immse(Yv,CA50_1(4002:5138))