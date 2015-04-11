function result = dilateImage(image)

se = strel('disk', 1);
temp = imdilate(image, se);

result = imerode(temp, se);