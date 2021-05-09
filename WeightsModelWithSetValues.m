%% Parameters

% Number of bats
% b = input('How many bats?\n');

b = 2;

% Number of days
d = 364;

% Number of runs
r = 10;

% Hours per day
h = 24;

% Decay constant
c = exp(-0.007*h);

% Max weight
maxW = 50;

% Min weight
minW = 30;

% Minimum pre-decay survival weight
minSW = minW/c;

% Parameters vector
params = [b d r h c maxW minW minSW];

%% Strategy choosing

% For bat A
% fprintf('\nBat strategies:\n- 1: Always greedy\n- 2: Always share\n- 3: Random strategy\n- 4: Tit-for-tat\n- 5: Nasty tit-for-tat\n- 6: Grim trigger\n\n\n');
% 
% stratselect = zeros(b, 1);
% 
% for i_stratselect = 1:b
%     stratselect(i_stratselect, 1) = input( sprintf('Choose a strategy for Bat %d : ', i_stratselect));
%     
%     if stratselect(i_stratselect, 1) == 1
%         stratselect(i_stratselect, 1) = 1;
%     elseif stratselect(i_stratselect, 1) == 2
%         stratselect(i_stratselect, 1) = 2;
%     elseif stratselect(i_stratselect, 1) == 3
%         stratselect(i_stratselect, 1) = 3;
%     elseif stratselect(i_stratselect, 1) == 4
%         stratselect(i_stratselect, 1) = 4;
%     elseif stratselect(i_stratselect, 1) == 5
%         stratselect(i_stratselect, 1) = 5;
%     elseif stratselect(i_stratselect, 1) == 6
%         stratselect(i_stratselect, 1) = 6;
%     else
%         fprintf('invalid strategy\n');
%         return
%     end
%         
% end

%% Initial bat weights

% Bats weights
batW = zeros(b, d);
batWA = zeros(r, d+1);
batWB = zeros(r, d+1);

% Random initial weight for each bat
for i_weight_bat = 1:b
    for i_weight_round = 1:r
%         batW(i_weight_bat, i_weight_round) = 5*rand(1) + 42;
        batW(i_weight_bat, i_weight_round) = 45;
    end
end

% Pre-decay bat weights
batWpredecay(i_weight_bat, i_weight_round) = batW(i_weight_bat, i_weight_round);

%% Bat life

batLife = zeros(b, r);

%% Bat strategy history

batS = zeros(b, d);

batSfun = batS;

%% Bat hunting abilities

batH = zeros(b, r);

% Random hunting ability for each bat
for i_hunt_bat = 1:b
    for i_hunt_round = 1:r
%         batH(i_hunt_bat, i_hunt_round) = rand(1);   % continuous random distribution
%         batH(i_hunt_bat, i_hunt_round) = 2 - randi(2);   % good or bad (1 or 0)
%         x = rand;
%         if x < 0.08
%             batH(i_hunt_bat, i_hunt_round) = 0.01;
%         else
%             batH(i_hunt_bat, i_hunt_round) = (1/3)*rand(1) + (1/3);
%         end
            
    end
end



batH(1,:) = 0;
batH(2,:) = 1;

%% Food

% Array of maximum amount food that can be found on each day
% maxF = (11*rand(1, d) + 11)*b;
maxF = zeros(1, d) + 30;
maxFfun = maxF;

% Food found by each bat on each day
foundF = zeros(b, d);

% Total food found by bats on each day
totalF = zeros(1, d);

%% Comparisons array

bigarrayA = zeros(6, 6);
bigarrayB = zeros(6, 6);
bigarrayAVE = zeros(6, 6);

%% Run functions

for i_A = 1:6
    for i_B = 1:6
        stratselect(1,1) = i_A;
        stratselect(2,1) = i_B;

for i_round = 1:r
    
%     for i_batinitiate = 1:b
%         batW(i_batinitiate, 1) = 5*rand(1) + 40;
%     end
%     batWpredecay = batW;
%     for i_hunthunt = 1:b
%         batH(i_hunthunt, i_round) = (1/3)*rand(1) + (1/3);
%     end
%     maxF = 10*b*rand(1, d) + 10*b;
    
    batWfun = batW;
    batWpredecayfun = batWpredecay;
    batSfun = batS;
    batHfun = batH(:, i_round);
    maxFfun = maxF;
    
    for i_day = 2:d+1
        
        batWfun(:, i_day) = batWfun(:, i_day-1);
        
        for i_food = 1:b
            foundF(i_food, i_day-1) = maxFfun(1, i_day-1).*(batHfun(i_food, 1)/b);   % How much food each bat finds
        end
        
        totalF = sum(foundF);
        
        for i_bat = randperm(b)
            
            
%             if ff(i_bat, i_round-1) > (1/3) * batW(i_bat, i_round-1)
%                 batW(i_bat, i_round) = (4/3) * batW(i_bat, i_round-1);   % Max carrying capacity of bats
%                 
%             else
%                 batW(i_bat, i_round) = batW(i_bat, i_round-1);
%                 
%             end
            
            
            switch stratselect(i_bat, 1)
                case 1
                    [batWfun, ...
                        batSfun] = ...
                        greedy(...
                        params, ...
                        batWfun, ...
                        batSfun, ...
                        foundF, ...
                        totalF, ...
                        i_bat, ...
                        i_day...
                        );
                case 2
                    [batWfun, ...
                        batSfun] = ...
                        share(...
                        params, ...
                        batWfun, ...
                        batSfun, ...
                        foundF, ...
                        totalF, ...
                        i_bat, ...
                        i_day...
                        );
                case 3
                    [batWfun, ...
                        batSfun] = ...
                        randomstrat(...
                        params, ...
                        batWfun, ...
                        batSfun, ...
                        foundF, ...
                        totalF, ...
                        i_bat, ...
                        i_day...
                        );
                case 4
                    [batWfun, ...
                        batSfun] = ...
                        titfortat(...
                        params, ...
                        batWfun, ...
                        batSfun, ...
                        foundF, ...
                        totalF, ...
                        i_bat, ...
                        i_day...
                        );
                case 5
                    [batWfun, ...
                        batSfun] = ...
                        titfortatnasty(...
                        params, ...
                        batWfun, ...
                        batSfun, ...
                        foundF, ...
                        totalF, ...
                        i_bat, ...
                        i_day...
                        );
                case 6
                    [batWfun, ...
                        batSfun] = ...
                        grim(...
                        params, ...
                        batWfun, ...
                        batSfun, ...
                        foundF, ...
                        totalF, ...
                        i_bat, ...
                        i_day...
                        );
                    
            end
            
            
            
            
        end
        
        
        for i_decay = 1:b
            
            if batWfun(i_decay, i_day) <= maxW
                batWpredecayfun(i_decay, i_day) = batWfun(i_decay, i_day);
                
            else
                batWpredecayfun(i_decay, i_day) = maxW;
                
            end
            
            batWfun(i_decay, i_day) = batWpredecayfun(i_decay, i_day)*c;
            
            if batWfun(i_decay, i_day) >= minW
                batWfun(i_decay, i_day) = batWfun(i_decay, i_day);
                
            else
                batWfun(i_decay, i_day) = 0;
                batHfun(i_decay, 1) = 0;
                batSfun(i_decay, i_day) = 0;
                
            end
            
        end
        
    end
    
    batWA(i_round, :) = batWfun(1, :);
    batWB(i_round, :) = batWfun(2, :);
    
    batLife(:, i_round) = sum(batWfun~=0,2);
    
end
    
        bigarrayA(i_A, i_B) = sum(batLife(1,:))./r;
        
        bigarrayB(i_A, i_B) = sum(batLife(2,:))./r;
        
        bigarrayAVE(i_A, i_B) = ((sum(batLife(1,:))./r) +(sum(batLife(2,:))./r))/b;
    end
end

batH;
batS;
foundF;
batWpredecay;
batW;
batLife;
batLifeA = sum(batLife(1,:))./r;
batLifeB = sum(batLife(2,:))./r;