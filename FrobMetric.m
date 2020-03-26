function [N1]=FrobMetric(view,A)
N1=0;
[~,~,N]=size(view);

for i=1:N
N1=N1+norm((A-view(:,:,i)),'fro');
end

N1=N1/N;

end
