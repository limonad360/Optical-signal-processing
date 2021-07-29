function [Rk, deltaRk] = GetRef (Bxk, Nxk, BRk, NRk)
    
    MEAN_Bx = mean(Bxk);
    MEAN_Nx = mean(Nxk);
    MEAN_BR = mean(BRk);
    MEAN_NR = mean(NRk);
    Rk = (MEAN_Bx - MEAN_Nx) / (MEAN_BR - MEAN_NR);
    STD_Bxk = std(Bxk);
    STD_Nxk = std(Nxk);
    STD_BRk = std(BRk);
    STD_NRk = std(NRk);
     
    deltaRk = sqrt(abs(1/(MEAN_BR-MEAN_NR)*STD_Bxk)^2 +...
              abs(-1/(MEAN_BR-MEAN_NR)*STD_Nxk)^2 +...
              abs(-(MEAN_Bx - MEAN_Nx)/(MEAN_BR - MEAN_NR)^2 * STD_BRk)^2 +...
              abs((MEAN_Bx - MEAN_Nx)/(MEAN_BR - MEAN_NR)^2 * STD_NRk)^2);
end

% syms lambda A B C D R x1
% y = (x1 - x2)/(x3 - x4)
% y1 = (lambda*acos(-(A - C*R)/(B - D*R)))/x1
% diff(y, x1)
% diff(y, x2)
% diff(y, x3)
% diff(y, x4)
