%*************************************************************************%
%                                                                         %
%  function STABILITY_CRITERION                                           %
%                                                                         %
%  function calculates the fault instability and and identifies faults    %
%  with unstable nodal planes                                             %
%                                                                         %
%  input:  stress                                                         %
%          friction                                                       %
%          complementary focal mechanisms                                 %
%                                                                         %
%  output: focal mechanisms with correct fault orientations               %
%          instability of faults                                          %
%                                                                         %
%*************************************************************************%
function [strike,dip,rake,instability] = stability_criterion(tau,friction,strike1,dip1,rake1,strike2,dip2,rake2)

%--------------------------------------------------------------------------
% principal stresses
%--------------------------------------------------------------------------
sigma = sort(eig(tau));
shape_ratio = (sigma(1)-sigma(2))/(sigma(1)-sigma(3));

%--------------------------------------------------------------------------
% principal stress directions
%--------------------------------------------------------------------------
[vector,diag_tensor] = eig(tau);

value = eig(diag_tensor);
[~,j]=sort(value);

sigma_vector_1  = vector(:,j(1));
sigma_vector_2  = vector(:,j(2));
sigma_vector_3  = vector(:,j(3));

%--------------------------------------------------------------------------
%  two alternative fault normals
%--------------------------------------------------------------------------
% first fault normal
n1_1 = -sin(dip1*pi/180).*sin(strike1*pi/180);
n1_2 =  sin(dip1*pi/180).*cos(strike1*pi/180);
n1_3 = -cos(dip1*pi/180);

% second fault normal
n2_1 = -sin(dip2*pi/180).*sin(strike2*pi/180);
n2_2 =  sin(dip2*pi/180).*cos(strike2*pi/180);
n2_3 = -cos(dip2*pi/180);

%--------------------------------------------------------------------------
% notation: sigma1 = 1; sigma2 = 1-2*shape_ratio; sigma3 = -1
%--------------------------------------------------------------------------
% fault plane normals in the coordinate system of the principal stress axes
n1_1_ = n1_1.*sigma_vector_1(1) + n1_2.*sigma_vector_1(2) + n1_3.*sigma_vector_1(3);
n1_2_ = n1_1.*sigma_vector_2(1) + n1_2.*sigma_vector_2(2) + n1_3.*sigma_vector_2(3);
n1_3_ = n1_1.*sigma_vector_3(1) + n1_2.*sigma_vector_3(2) + n1_3.*sigma_vector_3(3);

n2_1_ = n2_1.*sigma_vector_1(1) + n2_2.*sigma_vector_1(2) + n2_3.*sigma_vector_1(3);
n2_2_ = n2_1.*sigma_vector_2(1) + n2_2.*sigma_vector_2(2) + n2_3.*sigma_vector_2(3);
n2_3_ = n2_1.*sigma_vector_3(1) + n2_2.*sigma_vector_3(2) + n2_3.*sigma_vector_3(3);

%--------------------------------------------------------------------------
% 1. alternative
%--------------------------------------------------------------------------
tau_shear_n1_norm   = sqrt(n1_1_.^2+(1-2*shape_ratio)^2*n1_2_.^2.+n1_3_.^2-(n1_1_.^2+(1-2*shape_ratio)*n1_2_.^2-n1_3_.^2).^2);
tau_normal_n1_norm = (n1_1_.^2+(1-2*shape_ratio)*n1_2_.^2-n1_3_.^2);

%--------------------------------------------------------------------------
% 2. alternative
%--------------------------------------------------------------------------
tau_shear_n2_norm   = sqrt(n2_1_.^2+(1-2*shape_ratio)^2*n2_2_.^2.+n2_3_.^2-(n2_1_.^2+(1-2*shape_ratio)*n2_2_.^2-n2_3_.^2).^2);
tau_normal_n2_norm = (n2_1_.^2+(1-2*shape_ratio)*n2_2_.^2-n2_3_.^2);

%--------------------------------------------------------------------------
% instability
%--------------------------------------------------------------------------
instability_n1 = (tau_shear_n1_norm - friction.*(tau_normal_n1_norm-1))/(friction+sqrt(1+friction^2));
instability_n2 = (tau_shear_n2_norm - friction.*(tau_normal_n2_norm-1))/(friction+sqrt(1+friction^2));

[instability,i_index] = max([instability_n1'; instability_n2']);

%--------------------------------------------------------------------------
% identification of the fault according to the instability criterion
%--------------------------------------------------------------------------
strike = (i_index'-1).*strike2+(2-i_index').*strike1;
dip    = (i_index'-1).*dip2   +(2-i_index').*dip1;
rake   = (i_index'-1).*rake2  +(2-i_index').*rake1;

end

