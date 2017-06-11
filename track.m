function next_rect = track(next_frame, target_region)

global rect_x
global rect_y
global target_model

MaxIter = 10;
num_bins = 16;
pixel_range = 256;
bin_width = pixel_range / num_bins;

for iter=1:MaxIter
    target_candidate = pdf_representation(next_frame, target_region);
    weight = CalWeight(next_frame, target_model, target_candidate, target_region);
    
    [weight_rows, weight_cols] = size(weight);
    
    delta_x = 0.0;
    sum_wij = 0.0;
    delta_y = 0.0;
    center = (weight_rows - 1) / 2.0;
    mult = 0.0;
    
    next_rect_x = rect_x;
    next_rect_y = rect_y;
    
    for i=1:weight_rows
        for j=1:weight_cols
            norm_i = (i - center) / center;
            norm_j = (j - center) / center;
            if(norm_i * norm_i + norm_j * norm_j > 1.0)
                mult = 0.0;
            else
                mult = 1.0;
            end
            delta_x = delta_x + norm_j * weight(i,j) * mult;
            delta_y = delta_y + norm_i * weight(i,j) * mult;
            sum_wij = sum_wij + weight(i,j) * mult;
        end
    end
    
    next_rect_x = next_rect_x + (delta_x / sum_wij) * center;
    next_rect_y = next_rect_y +(delta_y / sum_wij) * center;
    
    next_rect_x = round(next_rect_x);
    next_rect_y = round(next_rect_y);
    
    if(abs(next_rect_x - rect_x) < 1 && abs(next_rect_y - rect_y) < 1)
        next_rect = [next_rect_x, next_rect_y];
        break;
    else
        rect_x = round(next_rect_x);
        rect_y = round(next_rect_y);
    end
        
    next_rect = [rect_x, rect_y];
    
end