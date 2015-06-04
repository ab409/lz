function result = dilateImage3(image, size)

se = strel('disk', size);
temp = imdilate(image, se);

result = imerode(temp, se);
