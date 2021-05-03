%*************************************************************************%
%                                                                         %
%   function NOISY_MECHANISMS                                             %
%                                                                         %
%   generating noisy mechanisms                                           %
%                                                                         %
%   input: strke, dip and rake                                            %
%          noise_level                                                    %
%                                                                         %
%*************************************************************************%
function [Dist_keep,strike1_noisy,dip1_noisy,rake1_noisy,strike2_noisy,dip2_noisy,rake2_noisy,n_error,u_error] = noisy_mechanisms_DistWeighted(mean_deviation,strike,dip,rake,distances)

N = length(strike);
% NN=N-floor(sqrt(N)-0.5);
NN=round(N-sqrt(N));
% if NN==0;NN=1;end
%  NN=N;
mark=zeros(N,1);
%--------------------------------------------------------------------------
% loop over focal mechanisms
%--------------------------------------------------------------------------
strike1_noisy=zeros(NN,1);
strike2_noisy=zeros(NN,1);
dip1_noisy=zeros(NN,1);
dip2_noisy=zeros(NN,1);
rake1_noisy=zeros(NN,1);
rake2_noisy=zeros(NN,1);
n_error=zeros(NN,1);
u_error=zeros(NN,1);
for i=1:NN
    
     ii=ceil(rand*N);
  while mark(ii)==1; ii=ceil(rand*N); end
mark(ii)=1;
Dist_keep(i)=distances(ii);
%--------------------------------------------------------------------------
%  fault normal and slip direction
%--------------------------------------------------------------------------
    n(1) = -sin(dip(ii)*pi/180).*sin(strike(ii)*pi/180);
    n(2) =  sin(dip(ii)*pi/180).*cos(strike(ii)*pi/180);
    n(3) = -cos(dip(ii)*pi/180);

    u(1) =  cos(rake(ii)*pi/180).*cos(strike(ii)*pi/180) + cos(dip(ii)*pi/180).*sin(rake(ii)*pi/180).*sin(strike(ii)*pi/180);
    u(2) =  cos(rake(ii)*pi/180).*sin(strike(ii)*pi/180) - cos(dip(ii)*pi/180).*sin(rake(ii)*pi/180).*cos(strike(ii)*pi/180);
    u(3) = -sin(rake(ii)*pi/180).*sin(dip(ii)*pi/180);
   
% superposition of noise, the procedure is symmtric 
% with respect to the fault normal and slip direction    
    if (mod(i,2) == 1)
        [n_noisy,u_noisy] = noisy_normal_slip(mean_deviation,n,u);
    else
        [u_noisy,n_noisy] = noisy_normal_slip(mean_deviation,u,n);
    end       
    
    [strike1,dip1,rake1,strike2,dip2,rake2] = strike_dip_rake(n_noisy,u_noisy);

    strike1_noisy(i,1) = strike1; dip1_noisy(i,1) = dip1; rake1_noisy(i,1) = rake1;
    strike2_noisy(i,1) = strike2; dip2_noisy(i,1) = dip2; rake2_noisy(i,1) = rake2;

    n_error(i) = min(acos(abs(n_noisy*n'))*180/pi);
    u_error(i) = min(acos(abs(u_noisy*u'))*180/pi);

end

end

