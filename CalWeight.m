function  weight = CalWeight(frame, target_model, target_candidate, rect)

global rect_x
global rect_y

num_bins = 16;
pixel_range = 256;
bin_width = pixel_range / num_bins;

[rows, cols] = size(rect);
weight = ones(rows, cols);

row_index = rect_y;
col_index = rect_x;

for k=1:3
    row_index = rect_y;
    for i=1:rows
        col_index = rect_x;
        for j=1:cols
            
            curr_pixel = frame(row_index, col_index, k);
            bin_value = max(1,curr_pixel / bin_width);
            weight(i, j) = weight(i, j) * sqrt(target_model(k, bin_value) / target_candidate(k, bin_value));
            col_index = col_index + 1;
            
        end
        row_index = row_index + 1;
    end
end