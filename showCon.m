function showCon(source, im, u)
figure;
subplot(2, 1, 1);
imshow(source);
title('ԭͼ��');
subplot(2, 1, 2);
imshow(uint8(im)),title('��ȡ���'),colormap gray      
hold on;
[c0,h] = contour(u,[0 0],'r');
hold off