function result = iac3(subBackImage, deltaT, cg, times, gamma1, gamma2, miu)
[height, width] = size(subBackImage);
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