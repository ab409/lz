function newImage = getSplineSmoothImage(image)

[height, width] = size(image);
x = 1 : height;
newImage = zeros(height, width);
for i = 1:width
    y = image(:, i)';
    y = double(y);
    [a, b, newY] = createFit(x, y);
    newImage(:, i) = newY;
end
newImage = uint8(newImage);


