function pdf_model = pdf_representation(frame, rect)

global rect_x
global rect_y

num_bins = 16;
pixel_range = 256;
bin_width = pixel_range / num_bins;

[rows, cols] = size(rect);

kernel = zeros(rows, cols);
[kernel, kernel_sum] = Epanechnikov_kernel(kernel);
normalized_C = 1.0 / kernel_sum;
pdf_model = ones(3, bin_width) * 1e-10;

% top left rect_y ile rect_x galiba
row_index = rect_y;
col_index = rect_x;
bin_value = zeros(rows, cols, 3);

for i=1:rows
    col_index = rect_x;
    for j=1:cols
        
        curr_pixel_value = frame(row_index, col_index,:);
        
        R = (curr_pixel_value(:,:,1) / bin_width);
        G = (curr_pixel_value(:,:,2) / bin_width);
        B = (curr_pixel_value(:,:,3) / bin_width);
        
        R = max(1,R);
        G = max(1,G);
        B = max(1,B);
        
        pdf_model(1, R) = pdf_model(1, R) + kernel(i,j) * normalized_C;
        pdf_model(2, G) = pdf_model(2, G) + kernel(i,j) * normalized_C;
        pdf_model(3, B) = pdf_model(3, B) + kernel(i,j) * normalized_C;
        
        col_index = col_index + 1;
        
    end
    row_index = row_index + 1;
end
