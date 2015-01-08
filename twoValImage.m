function result = twoValImage(image)

[height, width] = size(image);
result = zeros(height, width);
result(:, :) = 255;
for i = 1 : height 
   for j = 1 : width
       if image(i, j) < 255
           result(i, j) = 0;
       end
   end
end

result = uint8(result);