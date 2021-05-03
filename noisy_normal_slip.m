%*************************************************************************%
%                                                                         %
%   function NOISY_NORMAL_SLIP                                            %
%                                                                         %
%   generating noisy fault normals and slip directions                    %
%                                                                         %
%   input: fault normal n, slip direction u                               %
%          mean deviation                                                 %
%                                                                         %
%*************************************************************************%
function [n_noisy,u_noisy] = noisy_normal_slip(mean_deviation,n,u)

b = cross(n,u);   
%--------------------------------------------------------------------------
% noisy fault normal
%--------------------------------------------------------------------------
% uniform distribution
deviation_random = mean_deviation*(rand-0.5);
% while abs(deviation_random)>2*mean_deviation;
%     deviation_random = mean_deviation*randn;
% end
% uniform distribution of azimuth in the interval (0,360)    
azimuth_random   = 360*rand(1);
    
n_perpendicular = u*sin(azimuth_random*pi/180)+b*cos(azimuth_random*pi/180);
n_noise_component = n_perpendicular*sin(deviation_random*pi/180);
    
n_noisy = n + n_noise_component;
n_noisy = n_noisy/norm(n_noisy);
    
n_deviation_ = acos(n*n_noisy')*180/pi;
    
%--------------------------------------------------------------------------
% noisy slip direction, uniform distribution
%--------------------------------------------------------------------------
% uniform distribution
%    deviation_random = random('unif',0,2*mean_deviation); 
% normal distribution
deviation_random = mean_deviation*(rand-0.5);
% while abs(deviation_random)>2*mean_deviation;
%     deviation_random = mean_deviation*randn;
% end
% uniform distribution of azimuth in the interval (0,360)    
azimuth_random   = 360*rand(1);

b_perpendicular = n_noisy*sin(azimuth_random*pi/180)+u*cos(azimuth_random*pi/180);
b_noise_component = b_perpendicular*sin(deviation_random*pi/180);
    
b_noisy = b + b_noise_component;
b_noisy = b_noisy/norm(b_noisy);
    
b_deviation_ = acos(b*b_noisy')*180/pi;
    
% u_noisy must be perpendicular to n_noisy
u_noisy = cross(n_noisy,b_noisy);
    
% direction must be similar to the original u
u_noisy = sign(u*u_noisy')*u_noisy;
    
end

