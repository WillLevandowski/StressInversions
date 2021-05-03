opacity=0.05;
marksize=20;

%%% set inside and outside contour lines. For example, [0.05 0.05] will
%%% draw a single contour line at 95% confidence surface. 
contourlevel=[0.05 0.05]; 


%%% set parameters for Scatter2D
x_weight=2;
y_weight=2;
roughness=20; %% inversely related to smoothness of contouring
x_intervals=100;

[x_sigma_1,x_sigma_2,x_sigma_3,y_sigma_1,y_sigma_2,y_sigma_3]=plot_stress_axes_2_v2(sigma_vector_1_statistics,sigma_vector_2_statistics,sigma_vector_3_statistics,plot_file);





xp=y_sigma_1;
yp=x_sigma_1;
scatter(xp,yp,marksize,[ 0 0 1],'filled')
alpha(opacity)
 [XH,YH,Hit]=Scatter2D_v2(xp',yp',x_weight,y_weight,roughness,x_intervals);
m = max(max(Hit));
[xh,yh] = meshgrid(YH,XH);
jj = find((xh.^2 + yh.^2)>1);
Hit(jj) = NaN;
 [~,pl1] = contour(XH,YH,Hit',m*contourlevel,'Color', [0 0 0.5]);
 set(pl1,'linewidth',1)
 
 xp=y_sigma_2;
yp=x_sigma_2;
scatter(xp,yp,marksize,[ 0.2 0.6 0.2],'filled')
alpha(opacity)
[XH,YH,Hit]=Scatter2D_v2(xp',yp',x_weight,y_weight,roughness,x_intervals);
m = max(max(Hit));
[xh,yh] = meshgrid(YH,XH);
jj = find((xh.^2 + yh.^2)>1);
Hit(jj) = NaN;
 [~,pl2] = contour(XH,YH,Hit',m*contourlevel,'Color', [0.15 0.45 0.15]);
 set(pl2,'linewidth',1)
 
 xp=y_sigma_3;
yp=x_sigma_3;
scatter(xp,yp,marksize,[ 0.75 0 0],'filled')
alpha(opacity)
[XH,YH,Hit]=Scatter2D_v2(xp',yp',x_weight,y_weight,roughness,x_intervals);
m = max(max(Hit));
[xh,yh] = meshgrid(YH,XH);
jj = find((xh.^2 + yh.^2)>1);
Hit(jj) = NaN;
 [~,pl3] = contour(XH,YH,Hit',m*contourlevel,'Color', [0.5 0 0]);
 set(pl3,'linewidth',1.5)

            
 
if A_phi>=2.75;  type = 'Horizontal squashing';  end
if A_phi>=2.25 && A_phi<2.75; type = 'Pure Thrust';  end
if A_phi>=1.75 && A_phi<2.25; type = 'Reverse-Oblique';   end
if A_phi>=1.25 && A_phi<1.75; type = 'Strike-slip';  end
if A_phi>=0.75 && A_phi<1.25; type = 'Oblique-Normal';  end
if A_phi>=0.25 && A_phi<0.75; type = 'Pure Normal';  end
if A_phi<0.25;  type = 'Vertical pancaking';  end %%% Term taken from Unruh et al., 2013 Geosphere; after Unruh and Hauksson, 2009
 
 
 

 text(-1,1.07, [name '     ' type],'fontsize',20)
text(-1,0.79,['n=' num2str(num_obs)],'fontsize', 12)



aphi=sortrows(aphi');  
text(-1,0.97,['A\phi=' num2str(round(100*median(aphi))/100) ], 'fontsize',12);
text(-0.715,0.97,['±' num2str(round(100*Aphi_uncert)/100)], 'fontsize',9)



text(-1,0.89,'\sigma_H_m_a_x  ', 'fontsize',10);
text(-0.82,0.89,['N' num2str(round(SHmax)) 'E±' num2str(round(SH_uncert)) '°'], 'fontsize',9);

text(-1, -0.6, '\sigma_1', 'Color',[0 0 0.5],'FontSize',24)
text(-1, -0.75, '\sigma_2', 'Color',[0.15 0.45 0.15],'FontSize',24)
text(-1, -0.9, '\sigma_3', 'Color',[0.75 0 0],'FontSize',24)