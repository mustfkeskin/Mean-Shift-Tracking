function [G]=gauss(H, W)

G = zeros(H,W);
R = 1;

sigmaH = (R*H/2)/3;
sigmaW = (R*W/2)/3;
% sigma = x/3 as a gaussian is almost equal to 0
% from 3*sigma.
for i=1:H
  for j=1:W
    G(i,j) = exp(-.5*((i-.5*H)^2/sigmaH^2+...
             (j-.5*W)^2/sigmaW^2));
  end
end