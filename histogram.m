clc, clear, close all;

I1 = imread('C:\Users\86189\Desktop\db\IEI2019\H22.png');
figure(1), subplot(121), imshow(I1), title('H22');
subplot(122), imhist(I1);
ylim([0 2.2e4]), title('histogram');

I2 = imread('C:\Users\86189\Desktop\db\IEI2019\H26.jpg');
figure(2), subplot(121), imshow(I2), title('H26');
subplot(122), imhist(I2);
ylim([0 1.6e4]), title('histogram');

I3 = imread('C:\Users\86189\Desktop\db\IEI2019\R1.jpg');
figure(3), subplot(121), imshow(I3), title('R1');
subplot(122), imhist(I3);
ylim([0 2.2e5]), title('histogram');
