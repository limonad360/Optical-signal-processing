function [dk] = GetThick(R, len, A, B, C, D, wavelength, denominator)
dk = zeros(len-1,1);
rampd = 0;
% dflag = false;
Points = 30000;
% lastsigndR = sign(R(17+Points)-R(16));
for ii = Points:len
    
%     signdR = sign(R(ii)-R(ii-Points/2));
    X = -(A - C * R(ii))/(B - D * R(ii));
    
%     if (signdR < 0)
%         X = -X;
%     end
%     
%     if (signdR ~= lastsigndR)
%         dflag = false;
%     end
%         
%     lastsigndR = signdR;
%     
%     if (~dflag)
%         rampd = dk(ii-1);
%         dflag = true;
% %         ii
% %         dk(ii-1)
%     end
    dk(ii) = wavelength * (acos(X)) / denominator + rampd;
end


end
