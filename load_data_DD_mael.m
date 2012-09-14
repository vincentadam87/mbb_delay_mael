function [ Y,in ] = load_data_DD_mael( i_subject, SESS )
% This file loads and formats data of the delay discounting task of mael
%
%--- Different folders per subjects
%---- Different sessions
% Condition Episodic : matrices 1 & 3
% Condition Money: matrix 2
%--- Information about the data
% Matrix of size 72*16
%         1     2      3     4      5      6       7        8     9      10     11      12       13    14   15     16
% matrix=[trial domain time1 pict1' cond1' delay1' rating1' time2 pict2' cond2' delay2' rating2' time3 side choice rt];
%--- details
% domain 1 2 3 = food culture sport
% pict = stim ID
% cond: 1 if picture, 0 if sentence
% delay: 0 1 2 3 = 'maintenant' '1 mois '1 an' '10 ans'
% choice: 1= rep impulsive
% side: 1= smallR on the right
%

if nargin == 0
    i_subject = 1;
    SESS = [1];
end


root = 'C:\Users\vincent.adam\Desktop\Vincent Adam\Matlab\Demo_toolbox\Data\DELAY_MAEL\Behav\';

switch i_subject
    case 1; folder = '2009_05_08_U610_VOYAGE_SUJET_1\';
    case 2; folder = '2009_05_08_U610_VOYAGE_SUJET_2\';
    case 3; folder = '2009_05_08_U610_VOYAGE_SUJET_3\';
    case 4; folder = '2009_05_08_U610_VOYAGE_SUJET_4\';
    case 5; folder = '2009_05_08_U610_VOYAGE_SUJET_5\';
    case 6; folder = '2009_05_08_U610_VOYAGE_SUJET_6\';
    case 7; folder = '2009_05_08_U610_VOYAGE_SUJET_7\';
    case 8; folder = '2009_05_09_U610_VOYAGE_SUJET_8\';
    case 9; folder = '2009_05_09_U610_VOYAGE_SUJET_9\';
    case 10; folder = '2009_05_09_U610_VOYAGE_SUJET_10\';
    case 11; folder = '2009_05_09_U610_VOYAGE_SUJET_11\';
    case 12; folder = '2009_05_09_U610_VOYAGE_SUJET_12\';
    case 13; folder = '2009_05_09_U610_VOYAGE_SUJET_13\';
    case 14; disp('no number 14!')
    case 15; folder = '2009_05_10_U610_VOYAGE_SUJET_15\';
    case 16; folder = '2009_05_10_U610_VOYAGE_SUJET_16\';
    case 17; folder = '2009_05_10_U610_VOYAGE_SUJET_17\';
    case 18; folder = '2009_05_10_U610_VOYAGE_SUJET_18\';
    case 19; disp('no number 19!')
    case 20; folder = '2009_05_10_U610_VOYAGE_SUJET_20\';
    case 21; disp('no number 21!')
    case 22; folder = '2009_06_19_U610_VOYAGE_SUJET_22\';
    case 23; folder = '2009_06_26_U610_VOYAGE_SUJET_23\';
end

in = struct();
in.domain = [];% domain of the trial shared by both choices (food/culture/sport)
in.cond = [];% type of item (now, later)
in.delay = [];% DELAYED option (later)
in.rating = []; % ratings (now, later)
in.side_delay = []; % which side is the delayed option. 0 : left / 1 : right

Y = [];
DELAY = [0,1,12,120]*30;

for i_sess = SESS

filename = ['MatrixSub',num2str(i_subject),'Session',num2str(i_sess)];
load([root,folder,filename])

%--- loading raw data 
Ntrials = size(matrix,1); % number of trials

domain = matrix(:,2); % domain shared by the alternatives for all choices
cond =[matrix(:,5),matrix(:,10)];
delay = [ DELAY([matrix(:,6),matrix(:,11)]+1)]; % in months
rating = [matrix(:,7),matrix(:,12)];

cond_r = cond;
delay_r = zeros(Ntrials,1);
rating_r = rating;
side_delay_r = zeros(Ntrials,1);

%--- Reformating to always have now option as first
N = length(delay);
for i = 1 : N
    i_now =find(delay(i,:)==0); % 1 or 2 : indices of the now option
    i_later = (~(i_now-1))+1; % indices of the delayed option
cond_r(i,:)=[cond(i,i_now),cond(i,i_later)];
delay_r(i,1)=delay(i,i_later);
rating_r(i,:)=[rating(i,i_now),rating(i,i_later)];
side_delay_r(i,1) = i_later-1;
end





%--------------
choice =matrix(:,15)>0; % 1 rep impulsive
y = choice;
Y = [Y;y];

in.domain = [in.domain ; domain]; % domain shared by the alternatives for all choices
in.cond = [in.cond ;cond_r];
in.delay = [in.delay;delay_r]; % in months
in.rating = [in.rating;rating_r];
in.side_delay = [in.side_delay;side_delay_r];



end
in.side_delay = in.side_delay';
in.delay = in.delay';
in.rating = in.rating';
in.cond = in.cond';
in.y =Y;
%

end

