
function [gx] = g_DD_mael(x_t,P,u,in)
%%% Binary choice, hyperbolic delay discounting + softmax decision
% INPUT
% - x_t : []
% - P : Parameters
%   - beta
%   - side bias
%   - delay bias
%   - cond bias
%   - discount factors
% - u_t : []
% - in :
%   - V : 2*Ntrials, 'objective' value of proposed alternatives
%   - T : 2*Ntrials, time of delivery of the proposed alternatives
%   - cond : 1,2 for photo, sentence
%   - domain : 1,2,3 for food,culture,sport
%   - side_delay : 1 or 2 for left or right position of the delayed item
% OUTPUT
% - gx : Scalar, P(a=a1|x_t), probability of choice 1


T = in.delay; % delay of the delayed option
V = in.rating; % ratings (now, later)
cond = in.cond; % condition (now,later)
side_delay = in.side_delay; % side of the delayed option
domain = in.domain;

I = find( cond(1,:)~=cond(2,:) ); % where condition is different now and later
P_S = I(find(cond(I)==1)); % indices when photo_now, sentence later


% All bias can be fixed

% Use of parameters
beta = exp(P(1));
side_bias = P(2)*ones(length(T),1); % bias toward the side
delay_bias = P(3)*(side_delay'-0.5)*2;
cond_bias = zeros(length(T),1); cond_bias(P_S) = P(4) ; % bias toward one of the two


% INDICES OF PARAMETERS
% - 1 : beta
% - 2 : side bias
% - 3 : delay bias
% - 4 : condition bias
% - 5 : discount factor

K = ones(1,length(T))*exp(P(5));

if isin(in.COND_EFFECT,'discount_condition_specific')
    K(find(cond(2,:))) = exp(P(6));
end

if isin(in.COND_EFFECT,'discount_domain_specific')
    K(find(domain==1)) = exp(P(5));
    K(find(domain==2)) = exp(P(6));
    K(find(domain==3)) = exp(P(7));
end

if isin(in.COND_EFFECT,'discount_cross_domain_specific')
    K(P_S) = exp(P(6));
end

if isin(in.COND_EFFECT,'discount_cond_couple_specific')
    I1 = find( (cond(1,:)==1)&(cond(2,:)==1) );
    I2 = find( (cond(1,:)==0)&(cond(2,:)==0) );
    I3 = find( cond(1,:)~=cond(2,:) );
    K(I1) = exp(P(5));
    K(I2) = exp(P(6));
    K(I3) = exp(P(7));
end


    %K = log(K);


if ~isin(in.COND_EFFECT,'side_bias')
   side_bias = 0;
end

if ~isin(in.COND_EFFECT,'delay_bias')
    delay_bias= 0;
end

if ~isin(in.COND_EFFECT,'cond_bias')
    cond_bias = 0;
end

if isequal(in.DISCOUNT,'RAND')
    dU = 0;
elseif isequal(in.DISCOUNT,'NONE')
    dU = V(1,:) - V(2,:);
elseif isequal(in.DISCOUNT,'HYPERBOLIC')
dU = V(1,:) - V(2,:)./(1+K.*T);
elseif isequal(in.DISCOUNT,'EXPONENTIAL')
 dU = V(1,:) - V(2,:).*exp(-K.*T);
 elseif isequal(in.DISCOUNT,'HYPERBOLIC_LOG')
dU = V(1,:) - V(2,:)./(1+K.*log(T));
elseif isequal(in.DISCOUNT,'EXPONENTIAL_LOG')
 dU = V(1,:) - V(2,:).*exp(-K.*log(T));

elseif isequal(in.DISCOUNT,'NO DISCOUNT')
 dU = V(1,:) - V(2,:);
end

gx = sig( beta.*dU(:) + side_bias + cond_bias + delay_bias);


end

function y=sig(x)
y = 1./(1+exp(-x));
y(y<eps) = eps;
y(y>1-eps) = 1-eps;
end

function a = isin(c,s)
a = false;
if iscell(c)
    for i = 1 : length(c)
       if isequal(c{i},s)
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