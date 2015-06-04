function result = fastIac2(source, deltaT, cg, times, gamma1, gamma2, miu)

[height, width] = size(source);
%source = double(source);

%%
%形态学顶帽底帽去噪
subBackImage = source;
for i = 1 : 3
    subBackImage = hatSubBack(subBackImage);
end
subBackImage = double(subBackImage);
subBackImage = subBackImage./255;
grayStretchImage = subBackImage.^1.5;
subBackImage = grayStretchImage.*255;
subBackImage = uint8(subBackImage);

figure;
subplot(2, 1, 1);
imshow(source);
title('原图像');
subplot(2, 1, 2);
imshow(uint8(subBackImage)), title('处理后图像');

% showImage(subBackImage);
% subBackImage = relax(subBackImage);
% showImage(subBackImage);
u = zeros(height, width);
startX = 1;
w = 104;
delta = w / 2;
while startX < width
    endX = startX + w;
    if endX > width
        endX = width;
    end  
    midU = testIAC2(subBackImage(:, startX : endX), deltaT, cg, times, gamma1, gamma2, miu);   
    if startX == 1 || endX == width
        u(:, startX : endX) = midU;
    else
        u(:, startX + (endX - startX) / 4 : startX + (endX - startX) * 3 / 4) = midU(:, (endX - startX) / 4 : (endX - startX) * 3 / 4);
    end 
    startX = startX + delta;
end
% showCon(subBackImage, u);
result = u;


% grayStretchImage = subBackImage;
% testIAC(grayStretchImage);