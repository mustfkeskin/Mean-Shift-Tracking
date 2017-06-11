function [f,w] = Simil_func(q,p,T2,k,H,W)

w = zeros(H,W);
f = 0;
for i=1:H
    for j=1:W
        w(i,j) = sqrt(q(T2(i,j)+1)/p(T2(i,j)+1));
        f = f+w(i,j)*k(i,j);
    end
end
% Normalization of f
f = f/(H*W);