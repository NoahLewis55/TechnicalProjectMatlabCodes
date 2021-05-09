rA = reshape(transpose(resultA),[],1);
rB = reshape(transpose(resultB),[],1);
rAVE = reshape(transpose(resultAVERAGE),[],1);

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
        rA(i,1) = {'Share'};
        rB(i,1) = {'Share'};
        rAVE(i,1) = {'Share'};
    elseif i>6 && i<13
        rA(i,1) = {'Greedy'};
        rB(i,1) = {'Greedy'};
        rAVE(i,1) = {'Greedy'};
    elseif i>12 && i<19
        rA(i,1) = {'Random'};
        rB(i,1) = {'Random'};
        rAVE(i,1) = {'Random'};
    elseif i>18 && i<25
        rA(i,1) = {'Alt from Share'};
        rB(i,1) = {'Alt from Share'};
        rAVE(i,1) = {'Alt from Share'};
    elseif i>24 && i<31
        rA(i,1) = {'Alt from Greedy'};
        rB(i,1) = {'Alt from Greedy'};
        rAVE(i,1) = {'Alt from Greedy'};
    elseif i>30 && i<37
        rA(i,1) = {'Tit-for-tat'};
        rB(i,1) = {'Tit-for-tat'};
        rAVE(i,1) = {'Tit-for-tat'};
    end
end


for n = 1:6:36
    rA(n,2) = {'Share'};
    rB(n,2) = {'Share'};
    rAVE(n,2) = {'Share'};
end
for n = 2:6:36
    rA(n,2) = {'Greedy'};
    rB(n,2) = {'Greedy'};
    rAVE(n,2) = {'Greedy'};
end
for n = 3:6:36
    rA(n,2) = {'Random'};
    rB(n,2) = {'Random'};
    rAVE(n,2) = {'Random'};
end
for n = 4:6:36
    rA(n,2) = {'Alt from Share'};
    rB(n,2) = {'Alt from Share'};
    rAVE(n,2) = {'Alt from Share'};
end
for n = 5:6:36
    rA(n,2) = {'Alt from Greedy'};
    rB(n,2) = {'Alt from Greedy'};
    rAVE(n,2) = {'Alt from Greedy'};
end
for n = 6:6:36
    rA(n,2) = {'Tit-for-tat'};
    rB(n,2) = {'Tit-for-tat'};
    rAVE(n,2) = {'Tit-for-tat'};
end


RA = cell2table(rA, ...
    'VariableNames', {'Astrat', 'Bstrat', 'Success'});
RheatA = heatmap(RA, 'Bstrat', 'Astrat', 'ColorVariable', 'Success');
RheatA.Title = {'Success of Bat A for Each Strategy Combination', ''};
RheatA.XLabel = {'Bat B Strategy'};
RheatA.YLabel = {'Bat A Strategy'};
RheatA.CellLabelFormat = '%.4f';
RheatA.FontSize = 14;
caxis([0.4 1])


RB = cell2table(rB, ...
    'VariableNames', {'Astrat', 'Bstrat', 'Success'});
RheatB = heatmap(RB, 'Bstrat', 'Astrat', 'ColorVariable', 'Success');
RheatB.Title = {'Success of Bat B for Each Strategy Combination', ''};
RheatB.XLabel = {'Bat B Strategy'};
RheatB.YLabel = {'Bat A Strategy'};
RheatB.CellLabelFormat = '%.4f';
RheatB.FontSize = 14;
caxis([0.4 1])


RAVE = cell2table(rAVE, ...
    'VariableNames', {'Astrat', 'Bstrat', 'Success'});
RheatAVE = heatmap(RAVE, 'Bstrat', 'Astrat', 'ColorVariable', 'Success');
RheatAVE.Title = {'Average Success for Each Strategy Combination', ''};
RheatAVE.XLabel = {'Bat B Strategy'};
RheatAVE.YLabel = {'Bat A Strategy'};
RheatAVE.CellLabelFormat = '%.4f';
RheatAVE.FontSize = 14;
caxis([0.4 1])