%*************************************************************************%
%                                                                         %
%  function LINEAR_STRESS_INVERSION                                       %
%                                                                         %
%  linear inversion for stress from focal mechansisms                     %
%                                                                         %
%  input:  focal mechanisms                                               %
%  output: stress tensor                                                  %
%                                                                         %
%  Michael, A.J., 1984. Determination of stress from slip data:           %
%  Faults and folds, J. geophys. Res., 89, 11,517-11,526.                 %
%                                                                         %
%*************************************************************************%
function stress = linear_stress_inversion_DistWeighted(strike,dip,rake,Distances)

N = length(strike);

%--------------------------------------------------------------------------
%  fault normals and slip directions
%--------------------------------------------------------------------------
u1 =  cos(rake*pi/180).*cos(strike*pi/180) + cos(dip*pi/180).*sin(rake*pi/180).*sin(strike*pi/180);
u2 =  cos(rake*pi/180).*sin(strike*pi/180) - cos(dip*pi/180).*sin(rake*pi/180).*cos(strike*pi/180);
u3 = -sin(rake*pi/180).*sin(dip*pi/180);
   
n1 = -sin(dip*pi/180).*sin(strike*pi/180);
n2 =  sin(dip*pi/180).*cos(strike*pi/180);
n3 = -cos(dip*pi/180);

%--------------------------------------------------------------------------
% inverted matrix A
%--------------------------------------------------------------------------
A1 = zeros(N,5); A2 = zeros(N,5); A3 = zeros(N,5); 
a_vector(1:3*N+1,1) = 0;

% matrix coefficients
A11_n = [ n1.*(1  -n1.^2)];
A21_n = [      -n1.*n2.^2];
A31_n = [      -n1.*n3.^2];
A41_n = [   -2*n1.*n2.*n3];
A51_n = [ n3.*(1-2*n1.^2)];
A61_n = [ n2.*(1-2*n1.^2)];

A12_n = [      -n2.*n1.^2];
A22_n = [ n2.*(1-  n2.^2)];
A32_n = [      -n2.*n3.^2];
A42_n = [ n3.*(1-2*n2.^2)];
A52_n = [   -2*n1.*n2.*n3];
A62_n = [ n1.*(1-2*n2.^2)];

A13_n = [      -n3.*n1.^2];
A23_n = [      -n3.*n2.^2];
A33_n = [ n3.*(1-  n3.^2)];
A43_n = [ n2.*(1-2*n3.^2)];
A53_n = [ n1.*(1-2*n3.^2)];
A63_n = [   -2*n1.*n2.*n3];

A1 = [A11_n A21_n A31_n A41_n A51_n A61_n]; 	
A2 = [A12_n A22_n A32_n A42_n A52_n A62_n]; 	
A3 = [A13_n A23_n A33_n A43_n A53_n A63_n]; 	

for i=1:N
    a_vector_1(i,1) = u1(i);
    a_vector_2(i,1) = u2(i);
    a_vector_3(i,1) = u3(i);
end

A = [A1; A2; A3];

a_vector = [a_vector_1; a_vector_2; a_vector_3];

% condition for zero trace of the stress tensor
A(3*N+1,1:3  ) = 1; 
a_vector(3*N+1,1) = 0;
WEIGHTS=1./Distances;
for weight_A=1:6
    A(:,weight_A)=A(:,weight_A).*[WEIGHTS'; WEIGHTS'; WEIGHTS'; 1] ;
end
a_vector=a_vector.*[WEIGHTS'; WEIGHTS'; WEIGHTS'; 1] ;
%--------------------------------------------------------------------------
% generalized inversion
%--------------------------------------------------------------------------
stress_vector = pinv(A)*a_vector;

stress_tensor = [stress_vector(1) stress_vector(6) stress_vector(5);
                 stress_vector(6) stress_vector(2) stress_vector(4);
                 stress_vector(5) stress_vector(4) stress_vector(3)];
             
sigma  = eig(stress_tensor);
stress = stress_tensor/max(abs(sigma));

end


