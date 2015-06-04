function result = dilateImage2(image)

se = strel('disk', 1);
temp = imdilate(image, se);

result = imerode(temp, se);
