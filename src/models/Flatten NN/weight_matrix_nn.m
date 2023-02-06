function[W]=weight_matrix_nn(a,b,init) 
W=zeros(a,b);
for i=1:a
    for j=1:b
        W(i,j)=-init+(init+init).*rand(1,1);
    end
end