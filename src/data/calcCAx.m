function [CA50]=calcCAx(HRr,ang,x)
a=length(HRr);
CA50=zeros(a,1);
for i=1:a
CA50n=find(HRr(:,i)<=(max(HRr(:,i))-min(HRr(:,i)))*x+min(HRr(:,i)),1,'last');
CA50(i,1)=ang(CA50n+800,1);
end
end