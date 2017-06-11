function [kernel, kernel_sum] = Epanechnikov_kernel(kernel)

[h,w] = size(kernel);

epanechnikov_cd = 0.1 * pi * h * w;
kernel_sum = 0.0;

for i=1:h
    for j=1:w
        
        x = i - h/2;
        y = j - w/2;
        norm_x = x * x/(h * h/4) + y * y/(w * w/4);
        
        if norm_x < 1
            result = epanechnikov_cd * (1.0 - norm_x);
        else
            result = 0;
        end
        
        kernel(i,j) = result;
        kernel_sum = kernel_sum + result;
        
    end
end