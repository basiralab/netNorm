% MIT License

% Copyright (c) 2019 Salma Dhifallah and Islem Rekik.

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

%%------------------------------------------------------------------------------




%% Main function of netNorm framework for multiview brain network fusion
% Details can be found in the original paper: https://www.sciencedirect.com/science/article/pii/S1361841519301070
% Salma Dhifallah and Islem Rekik. "Estimation of connectional brain
% templates using selective multi-view network normalization", Medical Image
% Analysis, 2019, p. 101567.


% Inputs: 
%          *view: a cell array of size n_v where view{k} is(m*m*N) 
%                 nv the total number of views
%                 m the total number of ROIs (regions of interest in the brain) 
%                 N the total number of subjects.

% Outputs: 
%          *Frob_dist: The mean Frobenius distance between the estimated CBT
%                    (Connectional Brain Template) and each network on the whole population.
%          *The figure of the estimated CBT displayed.

%To test netNorm on random data we defined the function 'simulateData' where the size of the dataset is chosen by the user. 

%%------------------------------------------------------------------------------

clc
clear all;
close all;

% Parameter setting
K = 20;%number of neighbors, usually (10~30)
alpha = 0.5; %hyperparameter, usually (0.3~0.8) 
T = 20; %Number of Iterations, usually (10~20) 


%data definition
[view,nv,N,m]=simulateData;


for i=1:nv
   V{i}=vectorize(view{i}); 
end

   %Concatenated vectorized views
for i=1:N
subj{i}=V{1}(i,:);
for j=2:nv
   subj{i}=[subj{i};V{j}(i,:)]; %V{i}:4*595: number of views*number of features
end
end

[~,NumFeatures]=size(subj{1});

%construct hyper graphs
for k=1:NumFeatures
   
    for i=1:N
        for j=1:N
    X=[subj{i}(:,k),subj{j}(:,k)];
    X=X';
    score_matrix{k}(i,j)=pdist(X); %score matrix for each feature k
        end 
    end
    score_matrix{k}=score_matrix{k}-diag(diag(score_matrix{k}));
end

%Sum of rows H{k} to calculate the score for each feature vector

 Score_vect=zeros(N,NumFeatures);
for k=1:NumFeatures   
    for j=1:N
    Score_vect(:,k)=Score_vect(:,k)+score_matrix{k}(:,j); %score vector for each feature k
    end
end

min_Sc=zeros(NumFeatures,1);
for k=1:NumFeatures
    Score=Score_vect(:,k);
    min_Sc(k,1)=min(Score);
end

for k=1:NumFeatures
    for i=1:N
       L(i)=(min_Sc(k,1)==Score_vect(i,k));
    end
    [Index{k}]=find(L,1);
end


for k=1:nv
for i=1:NumFeatures
    representative_view{k}(i,1)=V{k}(Index{i},i);
end
end

%reconstruction of representative views
for k=1:nv
VIEW{k}=anti_vectorize((representative_view{k})',m);
VIEW{k}=VIEW{k}+(VIEW{k})'-diag(diag(VIEW{k}));%matrix symetry
end


%SNF application

[netNorm_CBT]=SNF(VIEW,K,T,alpha);
netNorm_CBT=netNorm_CBT-diag(diag(netNorm_CBT)); %Estimated brain connectional template

L1=min(min(netNorm_CBT(netNorm_CBT>0)));
L2=max(max(netNorm_CBT));


Frob_dist=0;
for k=1:nv
Frob_dist=Frob_dist+FrobMetric(view{k},netNorm_CBT);
end
Frob_dist=Frob_dist/nv;


fprintf('The mean Frobenius distance is:')
Frob_dist
Round_Distance = sprintf('%.3f',Frob_dist)
imagesc(netNorm_CBT,[L1 L2])
title('The estimated CBT')
colorbar