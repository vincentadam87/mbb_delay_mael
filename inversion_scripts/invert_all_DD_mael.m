clear all
close all
SUBJECTS = [1:13,15:18,20,22,23];
Nsubjects = length(SUBJECTS);
SESS  = [1,3];


%--- Perform the inversion for all models and subject and save results ---

for  i_s = 1:Nsubjects

i_subject=SUBJECTS(i_s);
disp(['-------- subject : ',num2str(i_s),' / ',num2str(length(SUBJECTS)), ' --------'])

% RANDOM MODELS
[ posterior, out ] = invert_RND_mael( i_subject, SESS);
INVERSION{i_s}.RND.SIMPLE.out = out;
INVERSION{i_s}.RND.SIMPLE.posterior = posterior;

[ posterior, out ] = invert_RND_mael( i_subject, SESS,'photo_vs_sentence' );
INVERSION{i_s}.RND.PHOTO_SENTENCE.out = out;
INVERSION{i_s}.RND.PHOTO_SENTENCE.posterior = posterior;

[ posterior, out ] = invert_RND_mael( i_subject, SESS,'couple' );
INVERSION{i_s}.RND.COUPLE.out = out;
INVERSION{i_s}.RND.COUPLE.posterior = posterior;

[ posterior, out ] = invert_RND_mael( i_subject, SESS,'same_vs_different' );
INVERSION{i_s}.RND.SAME_DIFFERENT.out = out;
INVERSION{i_s}.RND.SAME_DIFFERENT.posterior = posterior;

% HYPERBOLIC MODELS

[ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC' );
INVERSION{i_s}.HYP.SIMPLE.out = out;
INVERSION{i_s}.HYP.SIMPLE.posterior = posterior;

[ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', 'photo_vs_sentence');
INVERSION{i_s}.HYP.PHOTO_SENTENCE.out = out;
INVERSION{i_s}.HYP.PHOTO_SENTENCE.posterior = posterior;

[ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', 'couple');
INVERSION{i_s}.HYP.COUPLE.out = out;
INVERSION{i_s}.HYP.COUPLE.posterior = posterior;

[ posterior, out ] = invert_DD_mael( i_subject, SESS,'HYPERBOLIC', 'same_vs_different');
INVERSION{i_s}.HYP.SAME_DIFFERENT.out = out;
INVERSION{i_s}.HYP.SAME_DIFFERENT.posterior = posterior;

% EXPONENTIAL MODELS


[ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL' );
INVERSION{i_s}.EXP.SIMPLE.out = out;
INVERSION{i_s}.EXP.SIMPLE.posterior = posterior;

[ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', 'photo_vs_sentence');
INVERSION{i_s}.EXP.PHOTO_SENTENCE.out = out;
INVERSION{i_s}.EXP.PHOTO_SENTENCE.posterior = posterior;

[ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', 'couple');
INVERSION{i_s}.EXP.COUPLE.out = out;
INVERSION{i_s}.EXP.COUPLE.posterior = posterior;

[ posterior, out ] = invert_DD_mael( i_subject, SESS,'EXPONENTIAL', 'same_vs_different');
INVERSION{i_s}.EXP.SAME_DIFFERENT.out = out;
INVERSION{i_s}.EXP.SAME_DIFFERENT.posterior = posterior;
end

 %save INVERSION_DD INVERSION
%%

%--- Extract log evidences from inversion for all models and subjects ---

model_names={'hyp','hyp photo sentence','hyp couple','hyp same vs different',...
            'exp','exp photo sentence','exp couple','exp same vs different',...
            'rand','rand photo sentence','rand couple','rand same vs different'};
Nmodels = length(model_names);
LogEv =zeros(Nsubjects,Nmodels);

for  i_s = 1:Nsubjects



LogEv(i_s,1)=INVERSION{i_s}.HYP.SIMPLE.out.F;
LogEv(i_s,2)=INVERSION{i_s}.HYP.PHOTO_SENTENCE.out.F;
LogEv(i_s,3)=INVERSION{i_s}.HYP.COUPLE.out.F;
LogEv(i_s,4)=INVERSION{i_s}.HYP.SAME_DIFFERENT.out.F;

LogEv(i_s,5)=INVERSION{i_s}.EXP.SIMPLE.out.F;
LogEv(i_s,6)=INVERSION{i_s}.EXP.PHOTO_SENTENCE.out.F;
LogEv(i_s,7)=INVERSION{i_s}.EXP.COUPLE.out.F;
LogEv(i_s,8)=INVERSION{i_s}.EXP.SAME_DIFFERENT.out.F;

LogEv(i_s,9)=INVERSION{i_s}.RND.SIMPLE.out.F;
LogEv(i_s,10)=INVERSION{i_s}.RND.PHOTO_SENTENCE.out.F;
LogEv(i_s,11)=INVERSION{i_s}.RND.COUPLE.out.F;
LogEv(i_s,12)=INVERSION{i_s}.RND.SAME_DIFFERENT.out.F;


end

%--- Perform and display group level analysis ---



group_level_analysis(LogEv,'RFX',model_names)
pause(1); % to update display

partition_hyp_exp = {[1,2,3,4],[5,6,7,8]};
group_level_analysis(LogEv,'RFX',{'hyp','exp'},partition_hyp_exp);
pause(1); % to update display

partition_cond = {[1,5,9],[2,6,10],[3,7,11],[4,8,12]};
group_level_analysis(LogEv,'RFX',{'simple','photo sentence','couple','same diff'},partition_cond);
pause(1); % to update display


