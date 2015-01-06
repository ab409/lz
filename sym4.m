function newImage = sym4(image)

wname = 'sym4';
level = 4;
[c,l] = wavedec2(image, level, wname);
sigma_s = 0.0544779;
alpha = 2;
thr_s=wbmpen(c, l, sigma_s, alpha);

keepapp = l;
newImage=wdencmp('gbl', image, wname, level, thr_s, 's', keepapp);
newImage = uint8(newImage);
