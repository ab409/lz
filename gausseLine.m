a=0;sigma=2; % 方差sigma=2
x=-10:0.0001:10;
y=(1/((sqrt(2*pi))*sigma))*exp(-((x-a).^2)/(2*sigma.^2));
plot(x,y,'b','LineWidth',1.5);
xlabel('像素点位置X');
ylabel('灰度值');