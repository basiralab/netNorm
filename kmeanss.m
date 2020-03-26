%K-means
%clc
clear all
close all

%data directory
cd 'C:\Users\user\Desktop\wwoorrkk\Morphological data\ASD RH'
%construct the concatenation matrix allViews 70(35*2)*70*74 
[view1, view3, view5, view6] = getAllViews;

cd 'C:\Users\user\Desktop\wwoorrkk\morphological (K, T)'
% Setting all the parameters of the SNF technique for all views.
K = 20;%number of neighbors, usually (10~30)
alpha = 0.5; %hyperparameter, usually (0.3~0.8) (salma: mu explained in equation 1)
T = 20; %Number of Iterations, usually (10~20) 
C=97; % Number of subjects

R_NC_LH_orig=zeros(4,1);
R_NC_LH_map=zeros(4,1);


%SA------------------------------------------------------------------------
[SA_NC_LH,SNF1]=SA(view1,view3,view5,view6,C,K,alpha,T);
%AS------------------------------------------------------------------------
%[AS_NC_LH,A1]=AS(view1,view3,view5,view6,C,K,alpha,T);
%AS_NC_LH = AS_NC_LH- diag(diag(AS_NC_LH));
%SS------------------------------------------------------------------------
%[SS_NC_LH,SN1]=SS(view1,view3,view5,view6,C,K,alpha,T);
%SS_NC_LH = SS_NC_LH - diag(diag(SS_NC_LH));
%SCA-clustering in the mapped space----------------------------------------

 FusedViews=zeros(35,35,C);
      
for k=1:C
    w{1}= view1(:,:,k);
    w{2}=view3(:,:,k);
    w{3}=view5(:,:,k);
    w{4}=view6(:,:,k);
    %w{i}=affinityMatrix(w{i});
    [S1] = SNF(w, K, T);
    FusedViews(:,:,k)=S1-diag(diag(S1));
end

Cl=1;
%Subj=vectorize_map(view1,view3,view5,view6,C);
Subj1=vectorize(view1,C);
Subj2=vectorize(view3,C);
Subj3=vectorize(view5,C);
Subj4=vectorize(view6,C);
[group2,Y1]=kmeans(Subj1,Cl,'distance','correlation');
[group2,Y2]=kmeans(Subj2,Cl,'distance','correlation');
[group2,Y3]=kmeans(Subj3,Cl,'distance','correlation');
[group2,Y4]=kmeans(Subj4,Cl,'distance','correlation');

t=0;
for i=1:34
    for j=i+1:35
        t=t+1
C1(i,j)=Y1(1,t);
C2(i,j)=Y2(1,t);
C3(i,j)=Y3(1,t);
C4(i,j)=Y4(1,t);
    end
end

for i=1:35
    for j=1:i-1
       C1(i,j)=C1(j,i);  
       C2(i,j)=C2(j,i);
       C3(i,j)=C3(j,i);
       C4(i,j)=C4(j,i);
    end
    
end

w{1}=C1;
w{2}=C2;
w{3}=C3;
w{4}=C4;
atlas=SNF(w,K,T)-diag(diag(SNF(w,K,T)));
%{
Y1=Y(:,1:595);
Y2=Y(:,596:1190);
Y3=Y(:,1191:1785);
Y4=Y(:,1786:2380);

t=0;
for i=1:34
    for j=i+1:35
        t=t+1
C1view1(i,j)=Y1(1,t);
C1view3(i,j)=Y2(1,t);
C1view5(i,j)=Y3(1,t);
C1view6(i,j)=Y4(1,t);

C2view1(i,j)=Y1(2,t);
C2view3(i,j)=Y2(2,t);
C2view5(i,j)=Y3(2,t);
C2view6(i,j)=Y4(2,t);

C3view1(i,j)=Y1(3,t);
C3view3(i,j)=Y2(3,t);
C3view5(i,j)=Y3(3,t);
C3view6(i,j)=Y4(3,t);

C4view1(i,j)=Y1(4,t);
C4view3(i,j)=Y2(4,t);
C4view5(i,j)=Y3(4,t);
C4view6(i,j)=Y4(4,t);

C5view1(i,j)=Y1(5,t);
C5view3(i,j)=Y2(5,t);
C5view5(i,j)=Y3(5,t);
C5view6(i,j)=Y4(5,t);
%{
C4view1(i,j)=Y1(4,t);
C4view3(i,j)=Y2(4,t);
C4view5(i,j)=Y3(4,t);
C4view6(i,j)=Y4(4,t);
%}
%C3(i,j)=Y(3,t);
%C4(i,j)=Y(4,t);
%C5(i,j)=Y(5,t);
%C6(i,j)=Y(6,t);
    end
end

for i=1:35
    for j=1:i-1
       
C1view1(i,j)=C1view1(j,i);
C1view3(i,j)=C1view3(j,i);
C1view5(i,j)=C1view5(j,i);
C1view6(i,j)=C1view6(j,i);

C2view1(i,j)=C2view1(j,i);
C2view3(i,j)=C2view3(j,i);
C2view5(i,j)=C2view5(j,i);
C2view6(i,j)=C2view6(j,i);

C3view1(i,j)=C3view1(j,i);
C3view3(i,j)=C3view3(j,i);
C3view5(i,j)=C3view5(j,i);
C3view6(i,j)=C3view6(j,i);

C4view1(i,j)=C4view1(j,i);
C4view3(i,j)=C4view3(j,i);
C4view5(i,j)=C4view5(j,i);
C4view6(i,j)=C4view6(j,i);

C5view1(i,j)=C5view1(j,i);
C5view3(i,j)=C5view3(j,i);
C5view5(i,j)=C5view5(j,i);
C5view6(i,j)=C5view6(j,i);
%C3(i,j)=C3(j,i);
%C4(i,j)=C4(j,i);
%C5(i,j)=C5(j,i);
%C6(i,j)=C6(j,i);
    end
end

w{1}=C1view1;
w{2}=C1view3;
w{3}=C1view5;
w{4}=C1view6;
C1=SNF(w,K,T);
C1=C1-diag(diag(C1));

w{1}=C2view1;
w{2}=C2view3;
w{3}=C2view5;
w{4}=C2view6;
C2=SNF(w,K,T);
C2=C2-diag(diag(C2));


w{1}=C3view1;
w{2}=C3view3;
w{3}=C3view5;
w{4}=C3view6;
C3=SNF(w,K,T);
C3=C3-diag(diag(C3));

w{1}=C4view1;
w{2}=C4view3;
w{3}=C4view5;
w{4}=C4view6;
C4=SNF(w,K,T);
C4=C4-diag(diag(C4));

w{1}=C5view1;
w{2}=C5view3;
w{3}=C5view5;
w{4}=C5view6;
C5=SNF(w,K,T);
C5=C5-diag(diag(C5));

atlas=(C1+C2+C3+C4+C5)/Cl;
%}
%SCA=(SCAM+SCAO)/2;
%Results with the original space

R_NC_LH_orig(1,1)=(FrobMetric(view1,SA_NC_LH,C)+FrobMetric(view3,SA_NC_LH,C)+FrobMetric(view5,SA_NC_LH,C)+FrobMetric(view6,SA_NC_LH,C))/4;
%R_NC_LH_orig(2,1)=(FrobMetric(view1,AS_NC_LH,C)+FrobMetric(view3,AS_NC_LH,C)+FrobMetric(view5,AS_NC_LH,C)+FrobMetric(view6,AS_NC_LH,C))/4;
%R_NC_LH_orig(3,1)=(FrobMetric(view1,SS_NC_LH,C)+FrobMetric(view3,SS_NC_LH,C)+FrobMetric(view5,SS_NC_LH,C)+FrobMetric(view6,SS_NC_LH,C))/4;
%R_NC_LH_orig(4,1)=(FrobMetric(view1,SCA,C)+FrobMetric(view3,SCA,C)+FrobMetric(view5,SCA,C)+FrobMetric(view6,SCA,C))/4;
R_NC_LH_orig(2,1)=(FrobMetric(view1,atlas,C)+FrobMetric(view3,atlas,C)+FrobMetric(view5,atlas,C)+FrobMetric(view6,atlas,C))/4;

%Results with the mapped space

%R_NC_LH_map(1,1)=FrobMetric(SNF1,SA_NC_LH,C);
%R_NC_LH_map(2,1)=FrobMetric(A1,AS_NC_LH,C);
%R_NC_LH_map(3,1)=FrobMetric(SN1,SS_NC_LH,C);
%R_NC_LH_map(4,1)=FrobMetric(FusedViews1,SCA,C);
%R_NC_LH_map(2,1)=(FrobMetric(Fused1,atlas,C)+FrobMetric(Fused1,atlas,C))/2;

R_NC_LH_map(2,1)=FrobMetric(FusedViews,atlas,C);
    

old=digits(9);
vpa(R_NC_LH_orig(1,1))
vpa(R_NC_LH_orig(2,1))
%vpa(R_NC_LH_orig(3,1))
%vpa(R_NC_LH_orig(4,1))
%vpa(R_NC_LH_orig(5,1))

R_NC_LH_orig


    old=digits(6);
100*vpa(R_NC_LH_map(1,1))
100*vpa(R_NC_LH_map(2,1))
%100*vpa(R_NC_LH_map(3,1))
%100*vpa(R_NC_LH_map(4,1))
%100*vpa(R_NC_LH_map(5,1))


R_NC_LH_map

%{
%R_NC_LH_orig(4,:)
%R_NC_LH_map(4,:)
%min(min(R_NC_LH_orig(4,4:20)));
%min(min(R_NC_LH_map(4,4:20)));

%i=5:20;
%plot(i,R_NC_LH_map(4,i))
%figure;
%plot(i,R_NC_LH_orig(4,i))
%}
%{
%Vectorizing SN1
for k=1:C
       t=0;
  for i=1:34
        for j=i+1:35
            t=t+1;
             X(k,t)=view1(i,j,k);
        end
   end
end
 
for k=C+1:2*C
       t=0;
  for i=1:34
        for j=i+1:35
            t=t+1;
             X(k,t)=view3(i,j,k-C);
        end
   end
end
 
for k=2*C+1:3*C
       t=0;
  for i=1:34
        for j=i+1:35
            t=t+1;
             X(k,t)=view5(i,j,k-2*C);
        end
   end
end
 
for k=3*C+1:4*C
       t=0;
  for i=1:34
        for j=i+1:35
            t=t+1;
             X(k,t)=view6(i,j,k-3*C);
        end
   end
end
 

 for k=4*C+1:4*C+length(index1)
       t=0;
  for i=1:34
        for j=i+1:35
            t=t+1;
             X(4*C+1,t)=Fused1(i,j,k-4*C);
        end
  end
 end
  
 
 for k=4*C+1+length(index1):4*C+length(index1)+length(index2)
         t=0;
  for i=1:34
        for j=i+1:35
            t=t+1;
             X(4*C+2,t)=Fused2(i,j,k-(4*C+length(index1)));
        end
  end
 end
   
  
    t=0
   for i=1:34    
        for j=i+1:35
           t=t+1;
            X(4*C+1+length(index1)+length(index2),t)=atlas(i,j);
        end
   end
   size(X)
%tsne paramters
           no_dims=2;
           initial_dims=50;
           perplexity=30;
           labels=[ones(C,1);3*ones(C,1);5*ones(C,1);6*ones(C,1);80*ones(length(index1),1);90*ones(length(index2),1);40];

           cd 'C:\Users\user\Desktop\wwoorrkk\t-sne'
%Train tsne
           mappedSS=tsne(X,labels,no_dims,initial_dims,perplexity);
%Plot results
           gscatter(mappedSS(:,1),mappedSS(:,2),labels);

%R_NC_LH
%}