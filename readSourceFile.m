function grayImage = readSourceFile(fileName)

sourceImage = imread(fileName);
grayImage = rgb2gray(sourceImage);
