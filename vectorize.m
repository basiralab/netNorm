function [V]=vectorize(T)
%only vectorizes the upper triangular part
[m,n,N]=size(T);
V=zeros(N,1);
       for k=1:N
           t=0;
        for i=1:(m-1)
            for j=i+1:n
                t=t+1;
        V(k,t)=T(i,j,k);
            end
        end
       end
       
end