g = 100;   % number of games
n = 100;   % number of rounds
delta = 0.9;   % discount rate
bonus = 1/3;   % reward for sharing

batA = zeros(n,g);
batB = zeros(n,g);
batA_weighted = zeros(n,g);
batB_weighted = zeros(n,g);
batA_recent = zeros(1,1);
batB_recent = zeros(1,1);
maxfood = zeros(n,g);
pA = zeros(n,g);
pB = zeros(n,g);
strat = zeros(n,g);
dictstrat = zeros(n,g);

bats_success = zeros(g,1);

maximumfoodeach = zeros(1,n);
maximus = zeros(1,n);

for i = 1:n
    if mod(i, 2) == 1
        maximumfoodeach(1, i) = (1)* delta^(i-1);
    else
        maximumfoodeach(1, i) = (0.5 + bonus)* delta^(i-1);
    end
    maximus(1,i) = (1)* delta^(i-1);
end
maximumfoodeach = zeros(1, n) + sum(maximumfoodeach);
maximus =  zeros(1, n) + sum(maximus);

resultA = zeros(6,6);
resultB = zeros(6,6);
resultAVERAGE = zeros(6,6);
for i_A = 1:6
    for i_B = 1:6
        
        sA = i_A;
        sB = i_B;
        % sA = input('\nBat strategies:\n- 1: Always share\n- 2: Always greedy\n- 3: Random strategy\n- 4: Alternates between sharing and greedy (starting on sharing)\n- 5: Alternates between sharing and greedy (starting on greedy)\n- 6: Tit-for-tat (only for alternating dictator)\n\nDictator orders:\n- 1: Alternate dictator starting with bat A\n- 2: Alternate dictator starting with bat B\n- 3: Random dictator every round\n\n\nEnter a strategy for bat A: ');
        %
        % sB = input('\nEnter a strategy for bat B: ');
        %
        % d = input('\nEnter a dictator order: ');
        
        if sA == 1
            sANew = 'Sharing';
        elseif sA == 2
            sANew = 'Greedy';
        elseif sA == 3
            sANew = 'Random';
        elseif sA == 4
            sANew = 'Alternating strategy from sharing';
        elseif sA == 5
            sANew = 'Alternating strategy from greedy';
        elseif sA == 6
            sANew = 'Tit-for-tat';
        else
            fprintf('\nInvalid strategy\n\n' );
            return
        end
        
        if sB == 1
            sBNew = 'Sharing';
        elseif sB == 2
            sBNew = 'Greedy';
        elseif sB == 3
            sBNew = 'Random';
        elseif sB == 4
            sBNew = 'Alternating strategy from sharing';
        elseif sB == 5
            sBNew = 'Alternating strategy from greedy';
        elseif sB == 6
            sBNew = 'Tit-for-tat';
        else
            fprintf('\nInvalid strategy\n\n' );
            return
        end
        
        % if d == 1
            dNew = 'Alternating dictator from A';
        % elseif d == 2
        %     dNew = 'Alternating dictator from B';
        % elseif d == 3
        %     dNew = 'Random dictator';
        % else
        %     fprintf('\nInvalid strategy\n\n' );
        %     return
        % end
        
        
        for k = 1:g
            
            batA_recent(1,1) = randi(2);
            batB_recent(1,1) = randi(2);
            
            
            for i = 1:n
                strat(i,k) = rand;
                dictstrat(i,k) = rand;
                
                switch dNew
                    
                    case 'Alternating dictator from A'   % alternating dictator starting with bat A
                        
                        switch sANew   % bat A dictator strategy
                            
                            case 'Sharing'   % bat A is always sharing
                                pA(i,k) = 0;
                                
                            case 'Greedy'   % bat A is always greedy
                                pA(i,k) = 1;
                                
                            case 'Random'   % bat A has random strategy
                                pA(i,k) = rand;
                                
                            case 'Alternating strategy from sharing'   % bat A alternates between sharing and greedy (starting on sharing)
                                if mod(i-1, 4) == 0
                                    pA(i,k) = 0;
                                else
                                    pA(i,k) = 1;
                                end
                                
                            case 'Alternating strategy from greedy'   % bat A alternates between sharing and greedy (starting on greedy)
                                if mod(i-1, 4) == 0
                                    pA(i,k) = 1;
                                else
                                    pA(i,k) = 0;
                                end
                                
                            case 'Tit-for-tat'   % bat A uses tit-for-tat
                                if batB_recent == 1
                                    pA(i,k) = 1;
                                else
                                    pA(i,k) = 0;
                                end
                                
                            otherwise
                                fprintf('\nInvalid strategy\n\n' );
                                return
                        end
                        
                        switch sBNew   % bat B dictator strategy
                            
                            case 'Sharing'   % bat B is always sharing
                                pB(i,k) = 0;
                                
                            case 'Greedy'   % bat B is always greedy
                                pB(i,k) = 1;
                                
                            case 'Random'   % bat B has random strategy
                                pB(i,k) = rand;
                                
                            case 'Alternating strategy from sharing'   % bat B alternates between sharing and greedy (starting on sharing)
                                if mod(i, 4) == 0
                                    pB(i,k) = 1;
                                else
                                    pB(i,k) = 0;
                                end
                                
                            case 'Alternating strategy from greedy'   % bat B alternates between sharing and greedy (starting on greedy)
                                if mod(i, 4) == 0
                                    pB(i,k) = 0;
                                else
                                    pB(i,k) = 1;
                                end
                                
                            case 'Tit-for-tat'   % bat B uses tit-for-tat
                                if batA_recent == 1
                                    pB(i,k) = 1;
                                else
                                    pB(i,k) = 0;
                                end
                                
                            otherwise
                                fprintf('\nInvalid strategy\n\n' );
                                return
                        end
                        
                        if mod(i, 2) == 1
                            
                            if strat(i,k) < pA(i,k)
                                batA(i,k) = 1;
                                batB(i,k) = 0;
                                batA_recent = 1;
                                batB_recent = 0;
                            else
                                batA(i,k) = 0.5 + 1*bonus;
                                batB(i,k) = 0.5 + 1*bonus;
                                batA_recent = 0.5 + 1*bonus;
                                batB_recent = 0.5 + 1*bonus;
                            end
                            
                        else
                            if strat(i,k) < pB(i,k)
                                batA(i,k) = 0;
                                batB(i,k) = 1;
                                batA_recent = 0;
                                batB_recent = 1;
                            else
                                batA(i,k) = 0.5 + 1*bonus;
                                batB(i,k) = 0.5 + 1*bonus;
                                batA_recent = 0.5 + 1*bonus;
                                batB_recent = 0.5 + 1*bonus;
                            end
                        end
                        
                    case 'Alternating dictator from B'   % alternating dictator starting with bat B
                        
                        switch sANew   % bat A dictator strategy
                            
                            case 'Sharing'   % bat A is always sharing
                                pA(i,k) = 0;
                                
                            case 'Greedy'   % bat A is always greedy
                                pA(i,k) = 1;
                                
                            case 'Random'   % bat A has random strategy
                                pA(i,k) = rand;
                                
                            case 'Alternating strategy from sharing'   % bat A alternates between sharing and greedy (starting on sharing)
                                if mod(i, 4) == 0
                                    pA(i,k) = 1;
                                else
                                    pA(i,k) = 0;
                                end
                                
                            case 'Alternating strategy from greedy'   % bat A alternates between sharing and greedy (starting on greedy)
                                if mod(i, 4) == 0
                                    pA(i,k) = 0;
                                else
                                    pA(i,k) = 1;
                                end
                                
                            case 'Tit-for-tat'   % bat A uses tit-for-tat
                                if batB_recent == 1
                                    pA(i,k) = 1;
                                else
                                    pA(i,k) = 0;
                                end
                                
                            otherwise
                                fprintf('\nInvalid strategy\n\n' );
                                return
                        end
                        
                        switch sBNew   % bat B dictator strategy
                            
                            case 'Sharing'   % bat B is always sharing
                                pB(i,k) = 0;
                                
                            case 'Greedy'   % bat B is always greedy
                                pB(i,k) = 1;
                                
                            case 'Random'   % bat B has random strategy
                                pB(i,k) = rand;
                                
                            case 'Alternating strategy from sharing'   % bat B alternates between sharing and greedy (starting on sharing)
                                if mod(i-1, 4) == 0
                                    pB(i,k) = 0;
                                else
                                    pB(i,k) = 1;
                                end
                                
                            case 'Alternating strategy from greedy'   % bat B alternates between sharing and greedy (starting on greedy)
                                if mod(i-1, 4) == 0
                                    pB(i,k) = 1;
                                else
                                    pB(i,k) = 0;
                                end
                                
                            case 'Tit-for-tat'   % bat B uses tit-for-tat
                                if batA_recent == 1
                                    pB(i,k) = 1;
                                else
                                    pB(i,k) = 0;
                                end
                                
                            otherwise
                                fprintf('\nInvalid strategy\n\n' );
                                return
                        end
                        
                        if mod(i, 2) == 0
                            
                            if strat(i,k) < pA(i,k)
                                batA(i,k) = 1;
                                batB(i,k) = 0;
                                batA_recent = 1;
                                batB_recent = 0;
                            else
                                batA(i,k) = 0.5 + 1*bonus;
                                batB(i,k) = 0.5 + 1*bonus;
                                batA_recent = 0.5 + 1*bonus;
                                batB_recent = 0.5 + 1*bonus;
                            end
                            
                        else
                            if strat(i,k) < pB(i,k)
                                batA(i,k) = 0;
                                batB(i,k) = 1;
                                batA_recent = 0;
                                batB_recent = 1;
                            else
                                batA(i,k) = 0.5 + 1*bonus;
                                batB(i,k) = 0.5 + 1*bonus;
                                batA_recent = 0.5 + 1*bonus;
                                batB_recent = 0.5 + 1*bonus;
                            end
                        end
                        
                    case 'Random dictator'   % randomised dictator each round  -  doesn't work with alternating cases or tit-for-tat yet
                        
                        switch sANew   % bat A dictator strategy
                            
                            case 'Sharing'   % bat A is always sharing
                                pA(i,k) = 0;
                                
                            case 'Greedy'   % bat A is always greedy
                                pA(i,k) = 1;
                                
                            case 'Random'   % bat A has random strategy
                                pA(i,k) = rand;
                                
                            otherwise
                                fprintf('\nInvalid strategy\n\n' );
                                return
                        end
                        
                        switch sBNew   % bat B dictator strategy
                            
                            case 'Sharing'   % bat B is always sharing
                                pB(i,k) = 0;
                                
                            case 'Greedy'   % bat B is always greedy
                                pB(i,k) = 1;
                                
                            case 'Random'   % bat B has random strategy
                                pB(i,k) = rand;
                                
                            otherwise
                                fprintf('\nInvalid strategy\n\n' );
                                return
                        end
                        
                        if dictstrat(i,k) <  rand(i,k)
                            
                            if strat(i,k) < pA(i,k)
                                batA(i,k) = 1;
                                batB(i,k) = 0;
                                batA_recent = 1;
                                batB_recent = 0;
                            else
                                batA(i,k) = 0.5 + 1*bonus;
                                batB(i,k) = 0.5 + 1*bonus;
                                batA_recent = 0.5 + 1*bonus;
                                batB_recent = 0.5 + 1*bonus;
                            end
                            
                        else
                            if strat(i,k) < pB(i,k)
                                batA(i,k) = 0;
                                batB(i,k) = 1;
                                batA_recent = 0;
                                batB_recent = 1;
                            else
                                batA(i,k) = 0.5 + 1*bonus;
                                batB(i,k) = 0.5 + 1*bonus;
                                batA_recent = 0.5 + 1*bonus;
                                batB_recent = 0.5 + 1*bonus;
                            end
                        end
                        
                    otherwise
                        fprintf('\nInvalid strategy\n\n' );
                        return
                end
                
            end
            
            for j = 1:n
                batA_weighted(j,k) = batA(j,k) * delta^(j-1);
                batB_weighted(j,k) = batB(j,k) * delta^(j-1);
                maxfood(j,k) = (0.5 + 1*bonus) * delta^(j-1);
            end
            
            maxfood_each = sum(maxfood);
            maxfood_total = 2*sum(maxfood);
            
            batA_total = sum(batA_weighted);
            batB_total = sum(batB_weighted);
            
            bats_total = batA_total + batB_total;
            
            batA_success = batA_total/maximumfoodeach;
            batB_success = batB_total/maximumfoodeach;
            bats_success_2 = (batA_success + batB_success)/2;
            
            batA_success2 = batA_total/maximus;
            batB_success2 = batB_total/maximus;
            
            bats_success(k) = batA_total/maxfood_total + batB_total/maxfood_total;
            
            resultA(i_A, i_B) = batA_success;
            resultB(i_A, i_B) = batB_success;
            resultAVERAGE(i_A, i_B) = bats_success_2;
        end
        
    end
end

maxfood_each;
maximumfoodeach(1,1);
batA_success;
batB_success;
maximus(1,1);
batA_success2;
batB_success2;
% bats_success_2 = (batA_success + batB_success)/2;
% bats_success_avg = sum(bats_success)/g