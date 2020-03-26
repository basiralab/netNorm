function [M]=anti_vectorize(V,m)
M=zeros(m);
t=0;
for i=1:m-1
    for j=i+1:m
        t=t+1;
        M(i,j)=V(t);
    end
end
end