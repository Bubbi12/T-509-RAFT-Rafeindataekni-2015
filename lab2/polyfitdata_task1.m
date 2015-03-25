clear all; close all; clc
x = [0 0.28 0.56 0.75 1.03 1.31 1.5 1.69 1.8 1.85 1.9 2 2.1 2.2 2.3 2.4];
y = [-1.537 -1.521 -1.523 -1.537 -1.53 -1.532 -1.534 -1.444 -0.608 -0.55 0.923 3.95 9.255 17.1 25.7 32.38];

plot(x,y,'xr','linewidth',2)
hold on
plot([0 2.4],[0 0],'--k','linewidth',2)

p = polyfit(x,y,9);
x_polyfit = 0:0.01:2.4;
y_polyfit = polyval(p,x_polyfit);

plot(x_polyfit,y_polyfit);


x_zero = find(y_polyfit > 0);
x_z = x_polyfit(min(x_zero)-1)






