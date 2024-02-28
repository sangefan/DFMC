function  [GG,G,ag,obj] = runDFMC(x,d,gt,M,L,A,beta,lambda)
maxiter=50;
epsilon=1e-4;

N=size(x{1},2);%样本数N
K=max(gt);%聚类数

E=size(A,1);%网络结构的边数

B=abs(A);
A=kron(A,eye(N));
B=kron(B,eye(N));
%% 初始化
G=zeros(N*M,K);%低维表示矩阵
F=cell(1,M);%基矩阵
    for i=1:M
       F{i}=zeros(d(i),K);
    end
v=zeros(E*N,K);%对偶变量

%% 迭代
for t=1:maxiter
     %----------基矩阵----------
  for j=1:M
      F{j}=Fm(x{j},G(N*(j-1)+1:N*j,:));
  end
     %---------低维表示矩阵------
   G=g(x,F,L,N,M,lambda,beta,G,A,B,v);
     %---------对偶变量--------
   v=v+beta*A*G;
   
     %----------约束违反度-----------
    ee=(norm(G,'fro'))^2;
  ag(t)=(norm(A*G,'fro'))^2 / ee;
   
   %Compare the current iteration value with the previous iteration value
     Obj(t) = computeObjValue(x,F,G,L,lambda,M,N);
%     if (t>1 && abs(Obj(t-1)-Obj(t))<epsilon)
%         break;
%     end
 end
%% output the final result
%算平均值
GG=0;
for i=1:M
     GG=GG+G(N*(i-1)+1:N*i,:);
end
GG=1/M * GG;
 %目标函数值
 obj=Obj;

