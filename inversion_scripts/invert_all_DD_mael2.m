clear all
close all
%SUBJECTS = [1:13,15:18,20,22,23];
SUBJECTS =setdiff(1:23,[10,14,19,21]);
% Subject 10 excluded to try

Nsubjects = length(SUBJECTS);
SESS  = [1,3];


%--- Perform the inversion for all models and subject and save results ---

for  i_s = 1:Nsubjects
    
    i_subject=SUBJECTS(i_s);
    disp(['-------- subject : ',num2str(i_s),' / ',num2str(length(SUBJECTS)), ' --------'])
    
    % NO DISCOUNT
     [ posterior, out ] = invert_DD_mael( i_subject, SESS,'NO DISCOUNT');
    INVERSION{i_s}.NO_DISCOUNT.SIMPLE.out = out;
    INVERSION{i_s}.NO_DISCOUNT.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'NO DISCOUNT','side_bias');
    INVERSION{i_s}.NO_DISCOUNT.SIDE.out = out;
    INVERSION{i_s}.NO_DISCOUNT.SIDE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'NO DISCOUNT','delay_bias');
    INVERSION{i_s}.NO_DISCOUNT.DELAY.out = out;
    INVERSION{i_s}.NO_DISCOUNT.DELAY.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'NO DISCOUNT','cond_bias');
    INVERSION{i_s}.NO_DISCOUNT.COND_SPEC.out = out;
    INVERSION{i_s}.NO_DISCOUNT.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'NO DISCOUNT',{'delay_bias','side_bias'});
    INVERSION{i_s}.NO_DISCOUNT.SIDE_DELAY.out = out;
    INVERSION{i_s}.NO_DISCOUNT.SIDE_DELAY.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'NO DISCOUNT',{'cond_bias','side_bias'});
    INVERSION{i_s}.NO_DISCOUNT.SIDE_COND.out = out;
    INVERSION{i_s}.NO_DISCOUNT.SIDE_COND.posterior = posterior;

    
    % RANDOM MODELS
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'RAND','side_bias');
    INVERSION{i_s}.RND.SIDE.out = out;
    INVERSION{i_s}.RND.SIDE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'RAND','delay_bias');
    INVERSION{i_s}.RND.DELAY.out = out;
    INVERSION{i_s}.RND.DELAY.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'RAND','cond_bias');
    INVERSION{i_s}.RND.COND.out = out;
    INVERSION{i_s}.RND.COND.posterior = posterior;
    
    
    
    % HYPERBOLIC MODELS
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC' );
    INVERSION{i_s}.HYP.SIMPLE.out = out;
    INVERSION{i_s}.HYP.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', 'discount_condition_specific');
    INVERSION{i_s}.HYP.COND_SPEC.out = out;
    INVERSION{i_s}.HYP.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', 'discount_cross_domain_specific');
    INVERSION{i_s}.HYP.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.HYP.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', 'discount_cond_couple_specific');
    INVERSION{i_s}.HYP.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.HYP.COND_COUPLE_SPEC.posterior = posterior;
    
    %
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC','cond_bias' );
    INVERSION{i_s}.COND_BIAS.HYP.SIMPLE.out = out;
    INVERSION{i_s}.COND_BIAS.HYP.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', {'discount_condition_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.HYP.COND_SPEC.out = out;
    INVERSION{i_s}.COND_BIAS.HYP.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', {'discount_cross_domain_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.HYP.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.COND_BIAS.HYP.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', {'discount_cond_couple_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.HYP.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.COND_BIAS.HYP.COND_COUPLE_SPEC.posterior = posterior;
    
    %
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC','side_bias' );
    INVERSION{i_s}.SIDE_BIAS.HYP.SIMPLE.out = out;
    INVERSION{i_s}.SIDE_BIAS.HYP.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', {'discount_condition_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.HYP.COND_SPEC.out = out;
    INVERSION{i_s}.SIDE_BIAS.HYP.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', {'discount_cross_domain_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.HYP.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.SIDE_BIAS.HYP.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', {'discount_cond_couple_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.HYP.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.SIDE_BIAS.HYP.COND_COUPLE_SPEC.posterior = posterior;
    
    
    %--- log
    
      [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG' );
    INVERSION{i_s}.HYP_LOG.SIMPLE.out = out;
    INVERSION{i_s}.HYP_LOG.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', 'discount_condition_specific');
    INVERSION{i_s}.HYP_LOG.COND_SPEC.out = out;
    INVERSION{i_s}.HYP_LOG.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', 'discount_cross_domain_specific');
    INVERSION{i_s}.HYP_LOG.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.HYP_LOG.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', 'discount_cond_couple_specific');
    INVERSION{i_s}.HYP_LOG.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.HYP_LOG.COND_COUPLE_SPEC.posterior = posterior;
    
    %
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG','cond_bias' );
    INVERSION{i_s}.COND_BIAS.HYP_LOG.SIMPLE.out = out;
    INVERSION{i_s}.COND_BIAS.HYP_LOG.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', {'discount_condition_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.HYP_LOG.COND_SPEC.out = out;
    INVERSION{i_s}.COND_BIAS.HYP_LOG.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', {'discount_cross_domain_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.HYP_LOG.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.COND_BIAS.HYP_LOG.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', {'discount_cond_couple_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.HYP_LOG.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.COND_BIAS.HYP_LOG.COND_COUPLE_SPEC.posterior = posterior;
    
    %
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG','side_bias' );
    INVERSION{i_s}.SIDE_BIAS.HYP_LOG.SIMPLE.out = out;
    INVERSION{i_s}.SIDE_BIAS.HYP_LOG.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', {'discount_condition_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.HYP_LOG.COND_SPEC.out = out;
    INVERSION{i_s}.SIDE_BIAS.HYP_LOG.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', {'discount_cross_domain_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.HYP_LOG.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.SIDE_BIAS.HYP_LOG.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC_LOG', {'discount_cond_couple_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.HYP_LOG.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.SIDE_BIAS.HYP_LOG.COND_COUPLE_SPEC.posterior = posterior;
    
    
    % EXPONENTIAL MODELS
    
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL' );
    INVERSION{i_s}.EXP.SIMPLE.out = out;
    INVERSION{i_s}.EXP.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', 'discount_condition_specific');
    INVERSION{i_s}.EXP.COND_SPEC.out = out;
    INVERSION{i_s}.EXP.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', 'discount_cross_domain_specific');
    INVERSION{i_s}.EXP.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.EXP.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', 'discount_cond_couple_specific');
    INVERSION{i_s}.EXP.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.EXP.COND_COUPLE_SPEC.posterior = posterior;
    
    
    
    %
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL' ,'cond_bias');
    INVERSION{i_s}.COND_BIAS.EXP.SIMPLE.out = out;
    INVERSION{i_s}.COND_BIAS.EXP.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', {'discount_condition_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.EXP.COND_SPEC.out = out;
    INVERSION{i_s}.COND_BIAS.EXP.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', {'discount_cross_domain_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.EXP.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.COND_BIAS.EXP.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL',{ 'discount_cond_couple_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.EXP.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.COND_BIAS.EXP.COND_COUPLE_SPEC.posterior = posterior;
    
    %
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL' ,'side_bias');
    INVERSION{i_s}.SIDE_BIAS.EXP.SIMPLE.out = out;
    INVERSION{i_s}.SIDE_BIAS.EXP.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', {'discount_condition_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.EXP.COND_SPEC.out = out;
    INVERSION{i_s}.SIDE_BIAS.EXP.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', {'discount_cross_domain_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.EXP.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.SIDE_BIAS.EXP.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL',{ 'discount_cond_couple_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.EXP.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.SIDE_BIAS.EXP.COND_COUPLE_SPEC.posterior = posterior;
    
    %--- log
    
      
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG' );
    INVERSION{i_s}.EXP_LOG.SIMPLE.out = out;
    INVERSION{i_s}.EXP_LOG.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG', 'discount_condition_specific');
    INVERSION{i_s}.EXP_LOG.COND_SPEC.out = out;
    INVERSION{i_s}.EXP_LOG.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG', 'discount_cross_domain_specific');
    INVERSION{i_s}.EXP_LOG.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.EXP_LOG.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG', 'discount_cond_couple_specific');
    INVERSION{i_s}.EXP_LOG.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.EXP_LOG.COND_COUPLE_SPEC.posterior = posterior;
    
    
    
    %
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG' ,'cond_bias');
    INVERSION{i_s}.COND_BIAS.EXP_LOG.SIMPLE.out = out;
    INVERSION{i_s}.COND_BIAS.EXP_LOG.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG', {'discount_condition_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.EXP_LOG.COND_SPEC.out = out;
    INVERSION{i_s}.COND_BIAS.EXP_LOG.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG', {'discount_cross_domain_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.EXP_LOG.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.COND_BIAS.EXP_LOG.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG',{ 'discount_cond_couple_specific','cond_bias'});
    INVERSION{i_s}.COND_BIAS.EXP_LOG.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.COND_BIAS.EXP_LOG.COND_COUPLE_SPEC.posterior = posterior;
    
    %
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG' ,'side_bias');
    INVERSION{i_s}.SIDE_BIAS.EXP_LOG.SIMPLE.out = out;
    INVERSION{i_s}.SIDE_BIAS.EXP_LOG.SIMPLE.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG', {'discount_condition_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.EXP_LOG.COND_SPEC.out = out;
    INVERSION{i_s}.SIDE_BIAS.EXP_LOG.COND_SPEC.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG', {'discount_cross_domain_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.EXP_LOG.CROSS_DOMAIN.out = out;
    INVERSION{i_s}.SIDE_BIAS.EXP_LOG.CROSS_DOMAIN.posterior = posterior;
    
    [ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL_LOG',{ 'discount_cond_couple_specific','side_bias'});
    INVERSION{i_s}.SIDE_BIAS.EXP_LOG.COND_COUPLE_SPEC.out = out;
    INVERSION{i_s}.SIDE_BIAS.EXP_LOG.COND_COUPLE_SPEC.posterior = posterior;
    
    
end

%save INVERSION_DD INVERSION
%%

%--- Extract log evidences from inversion for all models and subjects ---

model_names={    'hyp',...
    'hyp discount condition specific',...
    'hyp discount cross domain specific',...
    'hyp discount_cond_couple_specific',...
    'hyp condbias',...
    'hyp discount condition specific condbias',...
    'hyp discount cross domain specific condbias',...
    'hyp discount cond couple specific condbias',...
    'hyp sidebias',...
    'hyp discount condition specific sidebias',...
    'hyp discount cross domain specific sidebias',...
    'hyp discount cond couple specific sidebias',...
    'hyp log',...
    'hyp log discount condition specific',...
    'hyp log discount cross domain specific',...
    'hyp log discount_cond_couple_specific',...
    'hyp log condbias',...
    'hyp log discount condition specific condbias',...
    'hyp log discount cross domain specific condbias',...
    'hyp log discount cond couple specific condbias',...
    'hyp log sidebias',...
    'hyp log discount condition specific sidebias',...
    'hyp log discount cross domain specific sidebias',...
    'hyp log discount cond couple specific sidebias',...
    'exp',...
    'exp discount condition specific',...
    'exp discount cross domain specific',...
    'exp discount_cond_couple_specific',...
    'exp  condbias',...
    'exp discount condition specific condbias',...
    'exp discount cross domain specific condbias',...
    'exp discount_cond_couple_specific condbias',...
    'exp  sidebias',...
    'exp discount condition specific sidebias',...
    'exp discount cross domain specific sidebias',...
    'exp discount_cond_couple_specific sidebias',...
    'exp log',...
    'exp log discount condition specific',...
    'exp log discount cross domain specific',...
    'exp log discount_cond_couple_specific',...
    'exp log  condbias',...
    'exp log discount condition specific condbias',...
    'exp log discount cross domain specific condbias',...
    'exp log discount_cond_couple_specific condbias',...
    'exp log  sidebias',...
    'exp log discount condition specific sidebias',...
    'exp log discount cross domain specific sidebias',...
    'exp log discount_cond_couple_specific sidebias',...
    'rand side_bias',...
    'rand delay_bias',...
    'rand cond_bias',...
    'no discount',...
    'no discount side',...
    'no discount delay',...
    'no discount cond',...
    'no discount side+delay',...
    'no discount side+cond'
    };
Nmodels = length(model_names);
LogEv =zeros(Nsubjects,Nmodels);

for  i_s = 1:Nsubjects
    LogEv(i_s,:)=[INVERSION{i_s}.HYP.SIMPLE.out.F;%1
        INVERSION{i_s}.HYP.COND_SPEC.out.F;
        INVERSION{i_s}.HYP.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.HYP.COND_COUPLE_SPEC.out.F;
        INVERSION{i_s}.SIDE_BIAS.HYP.SIMPLE.out.F;%5
        INVERSION{i_s}.SIDE_BIAS.HYP.COND_SPEC.out.F;
        INVERSION{i_s}.SIDE_BIAS.HYP.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.SIDE_BIAS.HYP.COND_COUPLE_SPEC.out.F;
        INVERSION{i_s}.COND_BIAS.HYP.SIMPLE.out.F;
        INVERSION{i_s}.COND_BIAS.HYP.COND_SPEC.out.F;%10
        INVERSION{i_s}.COND_BIAS.HYP.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.COND_BIAS.HYP.COND_COUPLE_SPEC.out.F; 
        INVERSION{i_s}.HYP_LOG.SIMPLE.out.F;%13
        INVERSION{i_s}.HYP_LOG.COND_SPEC.out.F;
        INVERSION{i_s}.HYP_LOG.CROSS_DOMAIN.out.F;%15
        INVERSION{i_s}.HYP_LOG.COND_COUPLE_SPEC.out.F;
        INVERSION{i_s}.SIDE_BIAS.HYP_LOG.SIMPLE.out.F;%
        INVERSION{i_s}.SIDE_BIAS.HYP_LOG.COND_SPEC.out.F;
        INVERSION{i_s}.SIDE_BIAS.HYP_LOG.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.SIDE_BIAS.HYP_LOG.COND_COUPLE_SPEC.out.F;%20
        INVERSION{i_s}.COND_BIAS.HYP_LOG.SIMPLE.out.F;
        INVERSION{i_s}.COND_BIAS.HYP_LOG.COND_SPEC.out.F;%
        INVERSION{i_s}.COND_BIAS.HYP_LOG.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.COND_BIAS.HYP_LOG.COND_COUPLE_SPEC.out.F;  
        INVERSION{i_s}.EXP.SIMPLE.out.F;%25
        INVERSION{i_s}.EXP.COND_SPEC.out.F;
        INVERSION{i_s}.EXP.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.EXP.COND_COUPLE_SPEC.out.F;%
        INVERSION{i_s}.SIDE_BIAS.EXP.SIMPLE.out.F;
        INVERSION{i_s}.SIDE_BIAS.EXP.COND_SPEC.out.F;%30
        INVERSION{i_s}.SIDE_BIAS.EXP.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.SIDE_BIAS.EXP.COND_COUPLE_SPEC.out.F;        
        INVERSION{i_s}.COND_BIAS.EXP.SIMPLE.out.F;%
        INVERSION{i_s}.COND_BIAS.EXP.COND_SPEC.out.F;
        INVERSION{i_s}.COND_BIAS.EXP.CROSS_DOMAIN.out.F;%35
        INVERSION{i_s}.COND_BIAS.EXP.COND_COUPLE_SPEC.out.F;       
        INVERSION{i_s}.EXP_LOG.SIMPLE.out.F;%37
        INVERSION{i_s}.EXP_LOG.COND_SPEC.out.F;
        INVERSION{i_s}.EXP_LOG.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.EXP_LOG.COND_COUPLE_SPEC.out.F;%40  
        INVERSION{i_s}.SIDE_BIAS.EXP_LOG.SIMPLE.out.F;
        INVERSION{i_s}.SIDE_BIAS.EXP_LOG.COND_SPEC.out.F;
        INVERSION{i_s}.SIDE_BIAS.EXP_LOG.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.SIDE_BIAS.EXP_LOG.COND_COUPLE_SPEC.out.F;        
        INVERSION{i_s}.COND_BIAS.EXP_LOG.SIMPLE.out.F;%45
        INVERSION{i_s}.COND_BIAS.EXP_LOG.COND_SPEC.out.F;
        INVERSION{i_s}.COND_BIAS.EXP_LOG.CROSS_DOMAIN.out.F;
        INVERSION{i_s}.COND_BIAS.EXP_LOG.COND_COUPLE_SPEC.out.F;       
        INVERSION{i_s}.RND.SIDE.out.F;
        INVERSION{i_s}.RND.DELAY.out.F;%50
        INVERSION{i_s}.RND.COND.out.F;
        INVERSION{i_s}.NO_DISCOUNT.SIMPLE.out.F;
        INVERSION{i_s}.NO_DISCOUNT.SIDE.out.F;
        INVERSION{i_s}.NO_DISCOUNT.DELAY.out.F;
        INVERSION{i_s}.NO_DISCOUNT.COND_SPEC.out.F;%55        
        INVERSION{i_s}.NO_DISCOUNT.SIDE_DELAY.out.F;
        INVERSION{i_s}.NO_DISCOUNT.SIDE_COND.out.F];    
end    
        
        
        
        %--- Perform and display group level analysis ---
        
        
        
        group_level_analysis(LogEv,'RFX',model_names)
        pause(1); % to update display
        
        
            
       group_level_analysis(LogEv(:,[]),'RFX',model_names)
        pause(1); % to update display
        %
        % partition_hyp_exp = {[1,2,3,4],[5,6,7,8]};
        % group_level_analysis(LogEv,'RFX',{'hyp','exp'},partition_hyp_exp);
        % pause(1); % to update display
        %
        % partition_cond = {[1,5,9],[2,6,10],[3,7,11],[4,8,12]};
        % group_level_analysis(LogEv,'RFX',{'simple','photo sentence','couple','same diff'},partition_cond);
        % pause(1); % to update display
        
        %%

% Bayesian parameter averaging

% NO DISCOUT side bias

SigmaPhi = zeros(2,2,Nsubjects);
muPhi = zeros(2,Nsubjects);
   P = zeros(2,2);
   M = zeros(2,1);
     
for  i_s = 1:Nsubjects
    muPhi(:,i_s) = INVERSION{i_s}.NO_DISCOUNT.SIDE.posterior.muPhi([1,2]);
    SigmaPhi(:,:,i_s) = INVERSION{i_s}.NO_DISCOUNT.SIDE.posterior.SigmaPhi([1,2],[1,2]);
    P = P+inv(SigmaPhi(:,:,i_s));
    M = M+SigmaPhi(:,:,i_s)\muPhi(:,i_s);
end

V = inv(P) % Variance for the group
M = P\M % Mean for the group
%%
% Hyp DISCOUnT no bias

SigmaPhi = zeros(2,2,Nsubjects);
muPhi = zeros(2,Nsubjects);
   P = zeros(2,2);
   M = zeros(2,1);
     
for  i_s = 1:Nsubjects
    muPhi(:,i_s) = INVERSION{i_s}.HYP.SIMPLE.posterior.muPhi([1,5]);
    SigmaPhi(:,:,i_s) = INVERSION{i_s}.HYP.SIMPLE.posterior.SigmaPhi([1,5],[1,5]);
    P = P+inv(SigmaPhi(:,:,i_s));
    M = M+SigmaPhi(:,:,i_s)\muPhi(:,i_s);
end

V = inv(P) % Variance for the group
M = P\M % Mean for the group

