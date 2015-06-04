function newImage = subBackground2(image)

se = strel('disk',10);

newImage = imsubtract(imadd(image,imtophat(image,se)), imbothat(image,se));
