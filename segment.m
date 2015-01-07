function result = segment(image)

[height, width] = size(image);
result = zeros(height, width);
tmp = image;
minPixel = min(min(tmp));
maxPixel = max(max(tmp));
key1 = (minPixel + maxPixel) / 2;

key2 = getNextKey(image, key1);
count = 0;
while abs(key1 - key2) < 1
   count = count + 1
   key1 = key2;
   key2 = getNextKey(image, key2);
end

for i = 1 : height 
   for j = 1 : width
      if image(i, j) < key1
        result(i, j) = 0;
      else
        result(i, j) = 255;
      end
   end
end