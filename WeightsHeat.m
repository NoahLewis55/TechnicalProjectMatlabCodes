rA = reshape(transpose(bigarrayA),[],1);
rB = reshape(transpose(bigarrayB),[],1);
rAVE = reshape(transpose(bigarrayAVE),[],1);

rA = num2cell(rA);
rB = num2cell(rB);
rAVE = num2cell(rAVE);



rA(:,2) = {[]};
rA(:,3) = {[]};
rA(:,3) = rA(:,1);
rA(:,1) = {[]};

rB(:,2) = {[]};
rB(:,3) = {[]};
rB(:,3) = rB(:,1);
rB(:,1) = {[]};

rAVE(:,2) = {[]};
rAVE(:,3) = {[]};
rAVE(:,3) = rAVE(:,1);
rAVE(:,1) = {[]};


for i = 1:36
    if i>0 && i<7
        rA(i,1) = {'Greedy'};
        rB(i,1) = {'Greedy'};
        rAVE(i,1) = {'Greedy'};
    elseif i>6 && i<13
        rA(i,1) = {'Share'};
        rB(i,1) = {'Share'};
        rAVE(i,1) = {'Share'};
    elseif i>12 && i<19
        rA(i,1) = {'Random'};
        rB(i,1) = {'Random'};
        rAVE(i,1) = {'Random'};
    elseif i>18 && i<25
        rA(i,1) = {'Tit-for-tat'};
        rB(i,1) = {'Tit-for-tat'};
        rAVE(i,1) = {'Tit-for-tat'};
    elseif i>24 && i<31
        rA(i,1) = {'Nasty Tit-for-tat'};
        rB(i,1) = {'Nasty Tit-for-tat'};
        rAVE(i,1) = {'Nasty Tit-for-tat'};
    elseif i>30 && i<37
        rA(i,1) = {'Grim Trigger'};
        rB(i,1) = {'Grim Trigger'};
        rAVE(i,1) = {'Grim Trigger'};
    end
end


for n = 1:6:36
    rA(n,2) = {'Greedy'};
    rB(n,2) = {'Greedy'};
    rAVE(n,2) = {'Greedy'};
end
for n = 2:6:36
    rA(n,2) = {'Share'};
    rB(n,2) = {'Share'};
    rAVE(n,2) = {'Share'};
end
for n = 3:6:36
    rA(n,2) = {'Random'};
    rB(n,2) = {'Random'};
    rAVE(n,2) = {'Random'};
end
for n = 4:6:36
    rA(n,2) = {'Tit-for-tat'};
    rB(n,2) = {'Tit-for-tat'};
    rAVE(n,2) = {'Tit-for-tat'};
end
for n = 5:6:36
    rA(n,2) = {'Nasty Tit-for-tat'};
    rB(n,2) = {'Nasty Tit-for-tat'};
    rAVE(n,2) = {'Nasty Tit-for-tat'};
end
for n = 6:6:36
    rA(n,2) = {'Grim Trigger'};
    rB(n,2) = {'Grim Trigger'};
    rAVE(n,2) = {'Grim Trigger'};
end



RA = cell2table(rA, ...
    'VariableNames', {'Astrat', 'Bstrat', 'DaysSurvived'});
RheatA = heatmap(RA, 'Bstrat', 'Astrat', 'ColorVariable', 'DaysSurvived');
RheatA.Title = {'Days Survived by Bat A for Each Strategy Combination', ''};
RheatA.XLabel = {'Bat B Strategy'};
RheatA.YLabel = {'Bat A Strategy'};
RheatA.FontSize = 14;
caxis([200 365])


% RB = cell2table(rB, ...
%     'VariableNames', {'Astrat', 'Bstrat', 'DaysSurvived'});
% RheatB = heatmap(RB, 'Bstrat', 'Astrat', 'ColorVariable', 'DaysSurvived');
% RheatB.Title = {'Days Survived by Bat B for Each Strategy Combination', ''};
% RheatB.XLabel = {'Bat B Strategy'};
% RheatB.YLabel = {'Bat A Strategy'};
% RheatB.FontSize = 14;
% caxis([200 365])
% 
% 
% RAVE = cell2table(rAVE, ...
%     'VariableNames', {'Astrat', 'Bstrat', 'DaysSurvived'});
% RheatAVE = heatmap(RAVE, 'Bstrat', 'Astrat', 'ColorVariable', 'DaysSurvived');
% RheatAVE.Title = {'Average Days Survived for Each Strategy Combination', ''};
% RheatAVE.XLabel = {'Bat B Strategy'};
% RheatAVE.YLabel = {'Bat A Strategy'};
% RheatAVE.FontSize = 14;
% caxis([270 365])