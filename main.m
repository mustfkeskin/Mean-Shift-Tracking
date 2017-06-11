clear;

v = VideoReader('Ball.avi');
video = readFrame(v);
[rows, cols] = size(video);

[object,x0,y0,H,W] = Select_patch(video,1);


%
object = rgb2gray(object);
object = im2double(object);

%normalized Weight
weight = gauss(H, W);
M = sum(sum(weight .* object)) / sum(sum(weight));

%bin histogram
nbins = 32;
[hist_object,edges] = histcounts(object,nbins);
hist_object = hist_object / sum(hist_object);

M = length(x0 - W/2 : x0 + W/2);
N = length(y0 - H/2 : y0 + H/2);

while hasFrame(v)
    video = readFrame(v);
    video = rgb2gray(video);
    video = im2double(video);
    
    minr = max(1, round(x0 - H/2));
    maxr = min(rows, round(x0 + H/2));
    
    minc = max(1, round(y0 - W/2));
    maxc = min(cols, round(y0 + W/2));
    
    results = zeros((maxr - minr) * (maxc - minc), 3);
        
    for i = minr : maxr
        for j =  minc : maxc   

            aday = video(i:i + H, j:j + W);
            [hist_aday,edges] = histcounts(aday, nbins);
            hist_aday = hist_aday / sum(hist_aday);
            %
            result = sum(sqrt(hist_object .* hist_aday));
            results(i,1) = i;
            results(i,2) = j;
            results(i,3) = result;   
        end
    end
    
    [temp, sortedIndeces] = sortrows(results,-3);
	bestMatchIndex = sortedIndeces(1, 1);
    
    x0 = results(bestMatchIndex,1);
    y0 = results(bestMatchIndex,2);
    object = video(x0 : x0 + H, y0 : y0 + W);
    video = Draw_target(x0,y0,H,W,video,3);
    imshow(video);
end