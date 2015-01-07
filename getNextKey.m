function result = getNextKey(image, key)

[height, width] = size(image);
back = zeros(height, width);
target = zeros(height, width);
for i = 1 : height 
   for j = 1 : width
      if image(i, j) < key
         back(i, j) = image(i, j);
         target(i, j) = 0;
      else
         back(i, j) = 255;
         target(i, j) = image(i, j);
      end
   end
end
backMean = mean(back(:));
targetMean = mean(target(:));
result = (backMean + targetMean) / 2;

