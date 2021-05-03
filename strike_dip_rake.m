%*************************************************************************%
%                                                                         %
%   function STRIKE_DIP_RAKE                                              %
%                                                                         %
%   calculation of strike, dip and rake from the fault normals and slip   %
%   directions                                                            %
%                                                                         %
%   input:  fault normal n                                                %
%           slip direction u                                              %
%                                                                         %
%   output: strike, dip and rake                                          %
%                                                                         %
%*************************************************************************%
function [strike1,dip1,rake1,strike2,dip2,rake2] = strike_dip_rake(n,u)

n1 = n;
u1 = u;
	
if n1(3)>0;
    n1 = -n1; 
    u1 = -u1; 
end % vertical component is always negative!
        
n2 = u;
u2 = n;
    
if n2(3)>0;
    n2 = -n2;
    u2 = -u2; 
end % vertical component is always negative!

%% ------------------------------------------------------------------------
% 1st solution
%--------------------------------------------------------------------------
dip    = acos(-n1(3))*180/pi;
strike = asin(-n1(1)/sqrt(n1(1)^2+n1(2)^2))*180/pi;

% determination of a quadrant
if n1(2)<0
    strike=180-strike;
end

rake = asin(-u1(3)/sin(dip*pi/180))*180/pi;

% determination of a quadrant
cos_rake = u1(1)*cos(strike*pi/180)+u1(2)*sin(strike*pi/180);
if cos_rake<0;
    rake=180-rake;
end

if strike<0
    strike = strike+360;
end
if rake  <-180
    rake   = rake  +360;
end
if rake  > 180
    rake   = rake  -360;
end  % rake is in the interval -180<rake<180
    
strike1 = strike; dip1 = dip; rake1 = rake;

%% ------------------------------------------------------------------------
% 2nd solution
%--------------------------------------------------------------------------
dip    = acos(-n2(3))*180/pi;
strike = asin(-n2(1)/sqrt(n2(1)^2+n2(2)^2))*180/pi;

% determination of a quadrant
if n2(2)<0 
    strike=180-strike;
end

rake = asind(-u2(3)/sind(dip));
if -u2(3)/sind(dip)>0.99999;
    rake=90;
end

% determination of a quadrant
cos_rake = u2(1)*cos(strike*pi/180)+u2(2)*sin(strike*pi/180);
if (cos_rake<0) rake=180-rake; end;

if (strike<0   ) strike = strike+360; end;
if (rake  <-180) rake   = rake  +360; end;
if (rake  > 180) rake   = rake  -360; end;  
    
strike2 = strike; dip2 = dip; rake2 = rake;

end


