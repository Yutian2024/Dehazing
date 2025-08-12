clc, clear, close all;

w0 = 0.85; t0 = 0.1;

II = imread('C:\Users\86189\Desktop\db\IEI2019\H18.jpg'); I = double(II); % requires editing the path before running
% figure(), imshow(II), title('Origin image');
tic
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

figure();
t = max(p, t0);
J(:, :, 1) = uint8((I(:, :, 1) - (1-t)*a)./t);
J(:, :, 2) = uint8((I(:, :, 2) - (1-t)*a)./t);
J(:, :, 3) = uint8((I(:, :, 3) - (1-t)*a)./t);
subplot(121), imshow(J), title('After dehazing(without soft matting)');

t = max(tr, t0);
J(:, :, 1) = uint8((I(:, :, 1) - (1-t)*a)./t);
J(:, :, 2) = uint8((I(:, :, 2) - (1-t)*a)./t);
J(:, :, 3) = uint8((I(:, :, 3) - (1-t)*a)./t);
subplot(122), imshow(J), title('After dehazing(with soft matting)');
toc