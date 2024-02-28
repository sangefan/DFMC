function objvalue = computeObjValue(x,F,G,L,lambda,M,N)

%Compute the current iteration objective function value
obj1 = 0;
obj2 = 0;
for i=1:M
    obj1=obj1+norm(x{i}-F{i}*G(N*(i-1)+1:N*i,:)','fro')^2;
    obj2=obj2+trace((G(N*(i-1)+1:N*i,:))'*(L(:,:,i))*G(N*(i-1)+1:N*i,:));
end
objvalue=obj1+lambda*obj2;