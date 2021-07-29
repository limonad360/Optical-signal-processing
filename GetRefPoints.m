function [RPk] = GetRefPoints(Bxk, Nxk, BRk, NRk)
     
    RPk = (Bxk - Nxk) / (BRk - NRk);
end

% syms x1 x2 x3 x4
% y = (x1 - x2)/(x3 - x4)
% diff(y, x1)
% diff(y, x2)
% diff(y, x3)
% diff(y, x4)
