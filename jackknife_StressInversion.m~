
%% Initialize outputs
no_regime_count=0;
STYLE=zeros(N_noise_realizations,1);
SHMAX_all=zeros(N_noise_realizations,1);
n_error_=zeros(N_noise_realizations,1);
u_error_=zeros(N_noise_realizations,1);
fric=zeros(N_noise_realizations,1);
dir_s1=zeros(N_noise_realizations,2);
dir_s2=zeros(N_noise_realizations,2);
dir_s3=zeros(N_noise_realizations,2);
shape_ratio_statistics=zeros(N_noise_realizations,1);
sigma_vector_1_statistics=zeros(3,N_noise_realizations);
sigma_vector_2_statistics=zeros(3,N_noise_realizations);
sigma_vector_3_statistics=zeros(3,N_noise_realizations);


%% Set weights for each of the num_obs mechanisms
%%% If you want to weight the individual mechanisms, do so here. At present
%%% "D" is written as though it is "D"istance from a point of interest, so
%%% the mechanisms are weighted inversely by their respective "D". By
%%% default, I have set all the weights equal.
D=ones(num_obs,1);

%% conduct inversions 

for i = 1:N_noise_realizations 
    
    STYLE(i)=999; %%% initialize
    while STYLE(i)>2  %%% Will be set to normal, strike-slip, or thrust, 
        %%%following the convention of Zoback (1992, JGR). "While" loop is
        %%%usually unnecessary, since most inversions return a well defined
        %%%faulting style.
    
        %%% choose random friction
        friction=friction_mean+friction_spread*(rand-0.5); 

        % superposition of noise to focal mechanisms. Also returns 
        % both nodal planes and respective (noisy) rakes
        [Dist_keep,strike1,dip1,rake1,strike2,dip2,rake2,n_error,u_error] = noisy_mechanisms_DistWeighted(mean_deviation,strike,dip,rake,D);    

        % these values are not important in the current formulation
        n_error_(i) = mean(n_error); 
        u_error_(i) = mean(u_error);

        % now run a single inversion with the noisy mechanisms...
        % see function and subfunctions for details. Returns stress
        % tensor as 3 vectors and value of stress ratio "phi"
        [d1,d2,d3,sigma_vector_1,sigma_vector_2,sigma_vector_3,shape_ratio_noisy] = statistics_stress_inversion(strike1,dip1,rake1,strike2,dip2,rake2,friction,N_iterations,N_realizations,Dist_keep); 

        % reformat some of the output
        dir_s1(i,:)=d1';
        dir_s2(i,:)=d2';
        dir_s3(i,:)=d3';
        sigma_vector_1_statistics (:,i) = sigma_vector_1;
        sigma_vector_2_statistics (:,i) = sigma_vector_2;
        sigma_vector_3_statistics (:,i) = sigma_vector_3;
        shape_ratio_statistics    (i)   = shape_ratio_noisy;
        n=999; SHMAX_all(i)=999;


        % determine faulting style, following Zoback (1992, JGR)
        if d1(2) > 52 && d3(2) < 35 ;  n=0;SHMAX_all(i)=d2(1); end
        if d1(2) > 40 && d1(2) <  52 && d3(2) < 20; n=0 ; SHMAX_all(i)=d3(1)+90;  end
        if d1(2) < 40 && d2(2) > 45 && d3(2) < 20 ; n=1;  SHMAX_all(i)=d3(1)+90; end
        if d1(2) < 20 && d2(2) > 45 && d3(2) < 40 ; n=1; SHMAX_all(i)=d1(1); end
        if d1(2) < 20  &&  d3(2) > 40 && d3(2) < 52 ; n=2; SHMAX_all(i)=d1(1); end
        if d1(2) < 35  && d3(2) > 52  ;  n=2; SHMAX_all(i)=d1(1); end
        STYLE(i)=n;


        % if the faulting style cannot be determined, try another set of noise
        % added to the mechanisms and another friction
        if STYLE(i)==999; no_regime_count=no_regime_count+1; 
            if mod(no_regime_count,100)==1
                fprintf([num2str(no_regime_count) ' iterations have failed out of ' num2str(i) '\n']); 
            end
        end
        % Alternatively, you can force the inversion to find 1 vertical
        % principal stress. Ask Will (BoulderGeophysics@gmail.com) if you want
        % that set of functions

    
    end
    fric(i)=friction;

end




