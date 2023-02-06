CA50=zeros(5095,1)';
for i=1:5095
CA50n=find(HR4r(:,i)<=max(HR2r(:,i))*0.1,1,'last');
CA50(i)=ang(CA50n);
end