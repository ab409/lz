function image = fixBoard(image)

[height, width] = size(image);

for i = 1 : height
   image = fixBoardCore(image, height, width, i, 1);
   image = fixBoardCore(image, height, width, i , width);
end