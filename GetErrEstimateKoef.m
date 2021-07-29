clc
clear

fname = '191112/BLUE_10.dat';
f_blue = fopen(fname, 'r');
blue10 = double(cell2mat(textscan(f_blue, '%d', 'Delimiter', {','})));
FunctionBx = blue10(8.518*10^5:1.124*10^6);

fnameRef = '1912187hoursExp/BLUE_REF.dat';
f_blueRef = fopen(fnameRef, 'r');
blue_refx = double(cell2mat(textscan(f_blueRef, '%d', 'Delimiter', {','})));
FunctionBR = blue_refx(8.518*10^5:1.124*10^6);

fnameNone10 = '1912187hoursExp/None10.dat';
f_none10 = fopen(fnameNone10, 'r');
none10 = double(cell2mat(textscan(f_none10, '%d', 'Delimiter', {','})));
FunctionNx = none10(8.518*10^5:1.124*10^6);

fnameNoneRef = '1912187hoursExp/NoneRef.dat';
f_noneRef = fopen(fnameNoneRef, 'r');
noneRef = double(cell2mat(textscan(f_noneRef, '%d', 'Delimiter', {','})));
FunctionNR = noneRef(8.518*10^5:1.124*10^6);

count = numel(FunctionBx);
q = 5000;
k = 0.22;
p = floor(numel(FunctionBx)/q);
deltat = 1/300;

RP = zeros(count,1);
R = zeros(p,1);
deltaR = zeros(p,1);

for j = 1: count
   [RP(j)]=GetRefPoints(FunctionBx(j),...
                        FunctionNx(j),...
                        FunctionBR(j),...
                        FunctionNR(j));
end

for i = 1:p
    startIndex = q*(i-1)+1;
    finishIndex = q*i;
    [R(i),deltaR(i)]=GetRef(FunctionBx(startIndex:finishIndex),...
        FunctionNx(startIndex:finishIndex),...
        FunctionBR(startIndex:finishIndex),...
        FunctionNR(startIndex:finishIndex));
end

figure;
subplot(1, 2, 2);

x = 0:deltat:(numel(RP)-1)*deltat;
plot(x,RP);

kk = mean(RP)/mean(R);
x1 = (deltat * q) * (1/2 : 1 : p - 1/2);
plot(x, RP);
hold on
grid on

errorbar (x1,kk.*R,kk.*deltaR);
hold off

RefInd = (2.52/1.52)^2;

subplot(1, 2, 1);
errorbar(x1, RefInd.*R, RefInd.*deltaR);
hold on;
plot(x1, RefInd.*R, '-x');
