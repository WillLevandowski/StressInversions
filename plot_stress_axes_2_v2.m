%*************************************************************************%
%                                                                         %
%  function PLOT_STRESS_AXES                                              %
%                                                                         %
%  plot of the principal stress axes into the focal sphere                %
%                                                                         %
%  input: principal stress directions                                     %
%         name of figure                                                  %
%                                                                         %
%*************************************************************************%
function [x_sigma_1,x_sigma_2,x_sigma_3,y_sigma_1,y_sigma_2,y_sigma_3]= plot_stress_axes_2_v2(sigma_vector_1_,sigma_vector_2_,sigma_vector_3_,plot_file)

N = length(sigma_vector_1_(1,:));
x_sigma_1=zeros(N,1);
x_sigma_2=zeros(N,1);
x_sigma_3=zeros(N,1);
y_sigma_1=zeros(N,1);
y_sigma_2=zeros(N,1);
y_sigma_3=zeros(N,1);
%--------------------------------------------------------------------------
% loop over individual solutions
%--------------------------------------------------------------------------
for i = 1:N
    
    sigma_vector_1 = sigma_vector_1_(:,i);
    sigma_vector_2 = sigma_vector_2_(:,i);
    sigma_vector_3 = sigma_vector_3_(:,i);
    
    if (sigma_vector_1(3)<0); sigma_vector_1 = -sigma_vector_1; end
    if (sigma_vector_2(3)<0); sigma_vector_2 = -sigma_vector_2; end
    if (sigma_vector_3(3)<0); sigma_vector_3 = -sigma_vector_3; end
    
    %----------------------------------------------------------------------
    % 1. stress axis
    fi_1 = atan(abs(sigma_vector_1(2)./sigma_vector_1(1)))*180/pi;
    
    if (sigma_vector_1(2)>=0 && sigma_vector_1(1)>=0); azimuth_sigma_1 =     fi_1; end  
    if (sigma_vector_1(2)>=0 && sigma_vector_1(1)< 0); azimuth_sigma_1 = 180-fi_1; end  
    if (sigma_vector_1(2)< 0 && sigma_vector_1(1)< 0); azimuth_sigma_1 = 180+fi_1; end  
    if (sigma_vector_1(2)< 0 && sigma_vector_1(1)>=0); azimuth_sigma_1 = 360-fi_1; end  
    
    theta_sigma_1 = acos(abs(sigma_vector_1(3)))*180/pi;
    
    %----------------------------------------------------------------------
    % 2. stress axis
    fi_2 = atan(abs(sigma_vector_2(2)./sigma_vector_2(1)))*180/pi;
    
    if (sigma_vector_2(2)>=0 && sigma_vector_2(1)>=0); azimuth_sigma_2 =     fi_2; end  
    if (sigma_vector_2(2)>=0 && sigma_vector_2(1)< 0); azimuth_sigma_2 = 180-fi_2; end  
    if (sigma_vector_2(2)< 0 && sigma_vector_2(1)< 0); azimuth_sigma_2 = 180+fi_2; end  
    if (sigma_vector_2(2)< 0 && sigma_vector_2(1)>=0); azimuth_sigma_2 = 360-fi_2; end  
    
    theta_sigma_2 = acos(abs(sigma_vector_2(3)))*180/pi;
    
    %----------------------------------------------------------------------
    % 3. stress axis
    fi_3 = atan(abs(sigma_vector_3(2)./sigma_vector_3(1)))*180/pi;
    
    if (sigma_vector_3(2)>=0 && sigma_vector_3(1)>=0); azimuth_sigma_3 =     fi_3; end  
    if (sigma_vector_3(2)>=0 && sigma_vector_3(1)< 0); azimuth_sigma_3 = 180-fi_3; end  
    if (sigma_vector_3(2)< 0 && sigma_vector_3(1)< 0); azimuth_sigma_3 = 180+fi_3; end 
    if (sigma_vector_3(2)< 0 && sigma_vector_3(1)>=0); azimuth_sigma_3 = 360-fi_3; end  
    
    theta_sigma_3 = acos(abs(sigma_vector_3(3)))*180/pi;
    
    %----------------------------------------------------------------------
    % projection into the lower hemisphere
    projection_1 = 1; projection_2 = 1; projection_3 = 1;
    
    %----------------------------------------------------------------------
    %  zenithal equal-area projection
    
    radius_sigma_1 = projection_1*sin(theta_sigma_1*pi/360.);
    radius_sigma_2 = projection_2*sin(theta_sigma_2*pi/360.);
    radius_sigma_3 = projection_3*sin(theta_sigma_3*pi/360.);
    
    x_sigma_1(i) = sqrt(2.)*radius_sigma_1*cos(azimuth_sigma_1*pi/180.);
    y_sigma_1(i) = sqrt(2.)*radius_sigma_1*sin(azimuth_sigma_1*pi/180.);
    
    x_sigma_2(i) = sqrt(2.)*radius_sigma_2*cos(azimuth_sigma_2*pi/180.);
    y_sigma_2(i) = sqrt(2.)*radius_sigma_2*sin(azimuth_sigma_2*pi/180.);
    
    x_sigma_3(i) = sqrt(2.)*radius_sigma_3*cos(azimuth_sigma_3*pi/180.);
    y_sigma_3(i) = sqrt(2.)*radius_sigma_3*sin(azimuth_sigma_3*pi/180.);
    
end

%--------------------------------------------------------------------------
% plotting the stress directions in the focal sphere
%--------------------------------------------------------------------------
figure; hold on; %title('Confidence of principal stress axes                 ','FontSize',16);
axis off; axis equal; axis([-1.05 1.05 -1.05 1.05]);

%--------------------------------------------------------------------------

  % boundary circle and the centre of the circle
fi=0:0.1:360;				
plot(cos(fi*pi/180.),sin(fi*pi/180.),'k','LineWidth',2.0)
plot(0,0,'k+','MarkerSize',10);		

%--------------------------------------
%--------------------------------------------------------------------------
% grid lines - constant theta
for theta_grid = 0:30:90
    radius_grid = projection_1*sin(theta_grid*pi/360.);
    
    x_grid = sqrt(2.)*radius_grid*cos(fi*pi/180.);
    y_grid = sqrt(2.)*radius_grid*sin(fi*pi/180.);

    plot(y_grid,x_grid,'k:','LineWidth',0.5);
end

%--------------------------------------------------------------------------
% grid lines - constant fi
theta_grid = 0:15:90;

for fi_grid = 0:15:360
    radius_grid = projection_1*sin(theta_grid*pi/360.);
    
    x_grid = sqrt(2.)*radius_grid*cos(fi_grid*pi/180.);
    y_grid = sqrt(2.)*radius_grid*sin(fi_grid*pi/180.);

    plot(y_grid,x_grid,'k:','LineWidth',0.5);
end
%--------------------------------------------------------------------------

end

