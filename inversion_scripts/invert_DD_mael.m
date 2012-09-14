function [ posterior, out ] = invert_DD_mael( i_subject, SESS ,DISCOUNT,COND_EFFECT)
% Inversion of the synthetic data from and with a hyperbolic discount
% model with softmax decision in a binary decision task


%--------------------- Task
% Two alternatives choice task
% - At each Trial, two alternatives are proposed by the experimenter
%   Each of which has two dimensions (value, time of delivery)
%   Delay between alternatives is kept constant 
% - The Subject chooses one among the two alternatives
%--------------------- Model
% Hyperbolic discount v(r,e) = r / (1 + k*d) 
% Exponential discount v(r,e) = r*exp(-k*d)
% Hidden states : None
% Observed variable : chosen alternative (1*Ntrials)
% Parameters : k, be
%---------------------------
%COND_EFFECT = '';

try COND_EFFECT;
catch
    COND_EFFECT = '';
end

try DISCOUNT;
catch
    DISCOUNT = '';
end
%COND = 'photo_vs_sentence';

%------

 [ y,in ] = load_data_DD_mael( i_subject, SESS );
 in.COND_EFFECT = COND_EFFECT;
in.DISCOUNT = DISCOUNT;
 
%------
g_fname = @g_DD_mael; % observation function, Parameters : [K, beta] => n_phi = 2
%------


N = length(y); % number of trials
dim = struct('n',0,...
    'n_theta',0,...
    'n_phi',5,... beta / 3 bias / discounts
    'p',N,...
    'n_t',1);


% Condition effect
if ( isin(COND_EFFECT,'photo_vs_sentence') || isin(COND_EFFECT,'same_vs_different') )
    dim.n_phi = 6;
end

if isin(COND_EFFECT,'discount_cond_couple_specific')
    dim.n_phi = 7;
end

if isin(COND_EFFECT,'discount_cross_domain_specific') ||  isin(COND_EFFECT,'discount_condition_specific')
    dim.n_phi = 6;
end
    
if isin(COND_EFFECT,'discount_domain_specific')
    dim.n_phi = 8;
end
    




% Priors on parameters (mean and Covariance matrix)
priors.muPhi = zeros(dim.n_phi,1); 
priors.SigmaPhi = 1e1*eye(dim.n_phi);


% bias
priors.SigmaPhi(2:4,2:4) = 0;
if isin(COND_EFFECT,'side_bias')
priors.SigmaPhi(2,2)=10;end
if isin(COND_EFFECT,'delay_bias')
priors.SigmaPhi(3,3)=10;end
if isin(COND_EFFECT,'cond_bias')
priors.SigmaPhi(4,4)=10;end


% Discount
if isin(DISCOUNT,'RAND')
priors.SigmaPhi([1,5],[1,5])=0; % beta,K
end
if isin(DISCOUNT,'NO DISCOUNT')
priors.SigmaPhi(5,5)=0; % K
end


%priors.SigmaPhi(end,end) = 0; % Do not infer beta!
% No state noise for deterministic update rules
priors.a_alpha = Inf;
priors.b_alpha = 0;
% Options for inversion
options.priors = priors;
options.DisplayWin = 0;
options.GnFigs = 0;
options.binomial = 1; % Dealing with binary data
options.dim = dim;
options.verbose = 0;
options.inG = in;

%%

%-----------------Model inversion
[posterior,out] = VBA_NLStateSpaceModel(y,[],[],g_fname,dim,options);  % Inversion function


end


function a = isin(c,s)
a = false;
if iscell(c)
    for i = 1 : length(c)
       if isin(c{i},s)
           a = true;
           return
       end
    end
else
    if isequal(c,s)
           a = true;
    end
end
end

