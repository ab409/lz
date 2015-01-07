function [newImage, fixedImage, fixedUpLine, fixedDownLine] = getExactlyBorderImage(image)

[height, width] = size(image);
newImage = zeros(height, width);
upLine = ones(1, width);
downLine = ones(1, width);
for i = 1 : width
    line = image(:, i);
    [exactlyUp, exactlyDown]=getExactlyUpDownBorder(line);
%     line(exactlyUp) = 255;
%     line(1:exactlyUp - 1) = 0;
%     line(exactlyDown) = 255;
%     line(exactlyDown + 1: height) = 0;
%     newImage(:, i) = line;
    upLine(i) = exactlyUp;
    downLine(i) = exactlyDown;
end
x = 1 : width;
[a, b, fixedUpLine] = createFit3(x, upLine);
fixedUpLine = int32(round(fixedUpLine));
[a, b, fixedDownLine] = createFit3(x, downLine);
fixedDownLine = int32(round(fixedDownLine));
for i = 1 : width
   line = image(:, i);
   if fixedUpLine(i) < 1
       line(1) = 255;
   else
       line(1:fixedUpLine(i)) = 0;
       line(fixedUpLine(i)) = 255;       
   end
   if fixedDownLine(i) > height
       line(height) = 255;
   else
       line(fixedDownLine(i): height) = 0;
       line(fixedDownLine(i)) = 255;
   end
   newImage(:, i) = line;
end
fixedImage = zeros(height, width);
for i = 1: width
   fixedLine = image(:, i);
   if fixedUpLine(i) > 1
      fixedLine(1: fixedUpLine(i)) = 0;
   end
   if fixedDownLine(i) < height
      fixedLine(fixedDownLine(i) : height) = 0; 
   end
   fixedImage(:, i) = fixedLine;
end

newImage = uint8(newImage);
fixedImage = uint8(fixedImage);
