clear;

global rect_x
global rect_y
global target_model

v = VideoReader('Ball.avi');
frame = readFrame(v);
[rows, cols] = size(frame);

[rect, rect_x, rect_y, H, W] = Select_patch(frame,1);
target_model = pdf_representation(frame, rect);

while hasFrame(v)
    frame = readFrame(v);
    rect = track(frame, rect);
    
    x = rect(1);
    y = rect(2);
    rect = frame(x:x + H - 1, y:y + W - 1);
    
    frame = Draw_target(x, y, H, W, frame, 3);
    imshow(frame);
end