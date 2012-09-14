function [ posterior, out ] = invert_DD_mael( i_subject, SESS , COND_EFFECT)


try COND_EFFECT;
catch
    COND_EFFECT = '';
end
%------

 [ y,in ] = load_data_DD_mael( i_subject, SESS );
  in.COND_EFFECT = COND_EFFECT;

g_fname = @g_RND_mael; % observation function, Parameters : [K, beta] => n_phi = 2
N = length(y); % number of trials
dim = struct('n',0,...
    'n_theta',0,...
    'n_phi',1,...
    'p',N,...
    'n_t',1);

if ( isequal(COND_EFFECT,'photo_vs_sentence') || isequal(COND_EFFECT,'same_vs_different') )
    dim.n_phi = 2;
end

if isequal(COND_EFFECT,'couple')
    dim.n_phi = 3;
end


% Priors on parameters (mean and Covariance matrix)
priors.muPhi = zeros(dim.n_phi,1); 
priors.SigmaPhi = 1e1*eye(dim.n_phi);


%priors.SigmaPhi(end,end) = 0; % Do not infer beta!
% No state noise for deterministic update rules
priors.a_alpha = Inf;
priors.b_alpha = 0;
% Options for inversion
options.priors = priors;
options.DisplayWin = 1;
options.GnFigs = 0;
options.binomial = 1; % Dealing with binary data
options.dim = dim;
options.verbose = 0;
options.inG = in;

%%

%-----------------Model inversion
[posterior,out] = VBA_NLStateSpaceModel(y,[],[],g_fname,dim,options);  % Inversion function

end

