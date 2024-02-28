function F=Fm(x,G)
    D = x*G;
    [U,~,V] = svd (D,'econ');%对d做svd分解求F
    F = (U)*(V)';
end

 

