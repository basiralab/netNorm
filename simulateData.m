%simulateData function
function [data,nv,N,m]=simulateData
rng(1);
prompt = 'What is the number of views? ';
nv = input(prompt)

prompt = 'What is the number of subjects in the population? ';
N = input(prompt)


prompt = 'What is the number of ROIs? ';
m = input(prompt)
while (m<20)
    prompt = 'Please choose a number >20: ';
    m = input(prompt)
end 

for k=1:nv
data{k}=rand(m,m,N);
for i=1:N
data{k}(:,:,i)=data{k}(:,:,i)-diag(diag(data{k}(:,:,i))); %eliminating self symetry (diagonal=0)
data{k}(:,:,i)=(data{k}(:,:,i)+(data{k}(:,:,i))')./2; %Insuring data symetry
end
end 