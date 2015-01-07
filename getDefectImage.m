function newImage = getDefectImage(image)

[height, width] = size(image);
newImage = zeros(height, width);
for i = 1 : width
    line = zeros(height, 1);
    line(:, 1) = 255;
    [x, y] = getExtremePoint(image(:, i));
    [up, down] = getDefect(x, y, line);
%     if up ~= 1 && down ~= 1
%         a = up 
%         b = down
%     end
    line(up :down, 1) = image(up : down, i); 
    newImage(:, i) = line;
end
newImage = uint8(newImage);