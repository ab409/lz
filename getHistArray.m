function histArray = getHistArray(image, startX, width, startY, height)

histArray = getHistArrayCore(image(startY: startY - 1 + height, startX : startX - 1 + width));


function histArray = getHistArrayCore(image)
global grayScale;
histArray = zeros(1, grayScale);
[height, width] = size(image);
pixelCount = height * width;
for pixel = 0 : grayScale - 1
    histArray(1, pixel+1) = sum(sum(image == pixel)) / pixelCount;
end

