function result = erodeImage(image, size)

se = strel('disk', size);
result = imerode(image, se);