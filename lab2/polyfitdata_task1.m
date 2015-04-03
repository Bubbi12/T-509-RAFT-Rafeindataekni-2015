clear all; close all; clc
% %from current measurments
% x = [0 0.28 0.56 0.75 1.03 1.31 1.5 1.69 1.8 1.85 1.9 2 2.1 2.2 2.3 2.4];
% y = [-1.537 -1.521 -1.523 -1.537 -1.53 -1.532 -1.534 -1.444 -0.608 -0.55 0.923 3.95 9.255 17.1 25.7 32.38];

x = [0 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3];
y = 1000*[0 0 0 0 0 0 0 0 0 0.000309524 0.000902597 0.002311688 0.005525974 0.010331169 0.017474026 0.025872294];



plot(x,y,'xr','linewidth',2)
hold on
plot([0 2.4],[0 0],'--k','linewidth',2)

p = polyfit(x,y,9);
x_polyfit = 0:0.01:2.3;
y_polyfit = polyval(p,x_polyfit);

plot(x_polyfit,y_polyfit,'linewidth',2);

xlabel('Gate voltage [V]','fontsize',14)
ylabel('Drain current [mA]','fontsize',14)
title('V_G vs. V_T','fontsize',14)


%%
clc
Rin = 48.1*10^3;
Rout = 462;
V_T = 1.74; %--------Flexible----------
hold on; plot(V_T,polyval(p,V_T),'ok','Markersize',9,'linewidth',2)
legend('Data points','V = 0','Fitted curve','V_T = 1.74 V')
R1=94000; R2 = 98500; R3 = 462; R4 = 462; RL = 1050;
C1 = 1.015*10^-6;
C2 = 98.375*10^-6;
C3 = 10.09*10^-6;
Id_0 = y(length(y)-2)/1000;
Vg_0 = x(length(y)-2);
K = Id_0/((Vg_0-V_T)^2)%mA/V^2

syms Id Vgs

[Id_val,Vgs_val]=solve(Vgs == 15*R1/(R1+R2)-Id*R4, Id == K*(Vgs-V_T)^2);

Id_val1 = vpa(Id_val(1,1))
Vgs_val1 = vpa(Vgs_val(1,1))

Id_val = vpa(Id_val(2,1))
Vgs_val = vpa(Vgs_val(2,1))

g_m = 2*K*(Vgs_val-V_T)
gain_VV = -g_m*(R3*RL)/(RL+R3) 
gain_dB = real(20*log10(gain_VV))

w1 = 1/(2*pi*Rin*C1)
w2 = 1/(2*pi*(R3+RL)*C2)
w3 = vpa(1/(2*pi*(R4/(1+g_m*R4))*C3))



