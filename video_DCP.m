clc, clear, close all;

w0 = 0.95; t0 = 0.15;

V = VideoReader('C:\Users\86189\Desktop\db\IEV2022\huangshan.mp4'); % requires editing the path before running
n = V.NumberOfFrames; % get the frames of the origin video
writerObj = VideoWriter('C:\Users\86189\Desktop\新建文件夹\Huangshan');  % define a video
open(writerObj);

for ii = 1:n

    II = read(V, ii); I = double(II);
    [h, w, s] = size(I);
    for i = 1:h
        for j = 1:w
            dark_I(i,j) = min(I(i, j, :)); % dark channel
        end
    end

    a = double(max(max(dark_I))); % atm light

    % soft matting
    dark_I = ordfilt2(dark_I, 1, ones(3, 3), 'symmetric');
    p = 1 - w0*dark_I/a; % get the transmission map
    gray_I = rgb2gray(I);
    r = 50; eps = 1e-4;
    tr = guidedfilter(gray_I, p, r, eps);

    t = max(tr, t0);
    J(:, :, 1) = uint8((I(:, :, 1) - (1-t)*a)./t);
    J(:, :, 2) = uint8((I(:, :, 2) - (1-t)*a)./t);
    J(:, :, 3) = uint8((I(:, :, 3) - (1-t)*a)./t);
    writeVideo(writerObj, J);
    
end
close(writerObj);