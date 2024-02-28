clc
clear

load BBCSport.mat %数据矩阵
load L_bbc.mat %拉普拉斯矩阵
M=size(fea,2);%视图数M
K=max(gt);%聚类数
[x,d]=data(fea,M);
A=[1 -1];%BBCSPORT

beta=5;%参数设置
lambda=10^-4;

% %-----------run--------------
GG = runDFMC(x,d,gt,M,L,A,beta,lambda);
opts = statset('MaxIter',1000);
[label,~] = kmeans(GG,K,'Options',opts);
% %----------聚类结果-----------
predY=label;%预测标签
Y=gt;%真实标签
result=ZHIBIAO(Y, predY);