clc;
clear;

%%% Setup

expname = '7hours';
fname = ['out/' expname '.csv'];

n0 = 1; %Refractive index of Air
ns = 1.52; %Refractive index of substrate
n1 = 1.7; %Refractive index of layer
wavelength = 450; %Reference wavelength
q = 50000; %Every q points need process
deltat = 1/300; % Convert point count into seconds

%Load indices from plotOC.m

% 1 - startAttenuationIdx 2 - finishAttenuationIdx
% 3 - startThicknessIdx 4 - finishThicknessIdx

fnameInd = ['out/' expname ' indices.csv'];
indices = dlmread(fnameInd);

startThicknessIdx = Indixies(:, 3);
finishThicknessIdx = Indixies(:, 4);
%%%

%Get attenuation coefficient
fnameAttenCoef = ['./out/' expname ' AttenCoef.csv'];
k = dlmread(fnameAttenCoef);

% Get data from file
inData = dlmread(fname);

% 1 - blueref 2 - blue1 3 - blue10 4 - blue200
% 5 - NoneRef 6 - None1 7 - None10 8 - None200
FunctionBx = inData(startThicknessIdx:finishThicknessIdx, 3);
FunctionBR = inData(startThicknessIdx:finishThicknessIdx, 1);
FunctionNx = inData(startThicknessIdx:finishThicknessIdx, 7);
FunctionNR = inData(startThicknessIdx:finishThicknessIdx, 5);

count = numel(FunctionBx);
p = floor(numel(FunctionBx)/q);

RP = zeros(count,1);
R = zeros(p,1);
deltaR = zeros(p,1);
d1 = zeros(p,1);

%Get R in every points
for j = 1: count
   [RP(j)]=GetRefPoints(FunctionBx(j),...
                        FunctionNx(j),...
                        FunctionBR(j),...
                        FunctionNR(j));
end

RWithNoize = smooth(RP*k, 1000, 'moving');
len = numel(RWithNoize);

%Get meanR and deltaR in q points
for i = 1:p
    startIndex = q*(i-1)+1;
    finishIndex = q*i;
    [R(i),deltaR(i)]=GetRef(FunctionBx(startIndex:finishIndex),...
        FunctionNx(startIndex:finishIndex),...
        FunctionBR(startIndex:finishIndex),...
        FunctionNR(startIndex:finishIndex));
end

%Constant
A = (n0 - ns)^2 + (((n0 * ns)/n1) - n1)^2;
B = (n0 - ns)^2 - (((n0 * ns)/n1) - n1)^2;
C = (n0 + ns)^2 + (((n0 * ns)/n1) + n1)^2;
D = (n0 + ns)^2 - (((n0 * ns)/n1) + n1)^2;
denominator = 4 * pi * n1;


dl = 5 * (1/2 : 1 : p - 1/2);
phi = 2.* pi.* n1.* dl./ wavelength;
R_theory = (A + B.*cos(2.*phi))./((C + D.*cos(2.*phi)));


R_correct = R*k; %Transfer Reflections coefficent using k - attenuation coefficient
deltaR_correct = deltaR *k;


%[d1, deltadk]=GetThick(R_correct,p, A, B, C, D, wavelength, denominator, deltaR_correct);

[dN] = GetThickNoize(RWithNoize, len, A, B, C, D, wavelength, denominator);


% plot(real(d1))
% yyaxis right
% plot(R_correct)

plot(real(dN))
yyaxis right
plot(RWithNoize)

% errorbar(d1, deltadk);
% yyaxis right;
% errorbar(R_correct, deltaR_correct);
% hold on
% plot(R_theory)
% grid on


                
% plot(d1, '-x')
% yyaxis right
% plot(R_correct, '-o')
% 
% figure;
% subplot(1, 2, 2);
% 
% x = 0:deltat:(numel(RP)-1)*deltat;
% plot(x,RP);
% 
% kk = mean(RP)/mean(R);
% x1 = (deltat * q) * (1/2 : 1 : p - 1/2);
% plot(x, RP);
% hold on
% grid on
% 
% errorbar (x1,kk.*R,kk.*deltaR);
% hold off
% 
% subplot(1, 2, 1);
% errorbar(x1, k.*R, 100*k.*deltaR);
% hold on;
% plot(x1, k.*R, '-x');
