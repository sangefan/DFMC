function G=g(x,F,L,N,M,lambda,beta,G,A,B,v)


T = [];
L_1=A'*A;
L_2=B'*B;
Deg=(L_1+L_2)./2;

    for i = 1:M
        temp = 2*eye(N)+2*lambda*L(:,:,i);
        temp1 = 2*(x{i})'*(F{i});
        re=temp*G(N*(i-1)+1:N*i,:)-temp1;
        T = [T;re];
    end
    
    lin=T+A'*v-beta*L_2*G;
    qua=2*beta*Deg;
    G=(qua^-1)*(-lin);
end

