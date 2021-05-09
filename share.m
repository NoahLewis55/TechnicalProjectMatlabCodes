function [...
    batWfun, ...
    batSfun...
    ] = share(...
    params, ...
    batWfun, ...
    batSfun, ...
    foundF, ...
    totalF, ...
    i_bat, ...
    i_day...
    )

b = params(1);
d = params(2);
r = params(3);
h = params(4);
c = params(5);
maxW = params(6);
minW = params(7);
minSW = params(8);

safeF = minSW - minW;

% if other bat
if i_bat == 1
    otherbat = 2;
elseif i_bat == 2
    otherbat = 1;
else
    otherbat = 0;
end

% if all bats are alive
if (batWfun(:, i_day) >= minW)
    
%     if (batWfun(i_bat, i_day) + (1/b)*foundF(i_bat, i_day-1) >= minSW)
%         
%         
%         if ((batWfun(otherbat, i_day) <= minSW) && ...
%                 (foundF(i_bat, i_day-1) >= safeF) && ...
%                 (batWfun(i_bat, i_day) + foundF(i_bat, i_day-1) - safeF >= minSW))
%             
%             batWfun(otherbat, i_day) =  batWfun(otherbat, i_day) + safeF;
%             batWfun(i_bat, i_day) =  batWfun(i_bat, i_day) + foundF(i_bat, i_day-1) - safeF;
%             
%         else
            
            if batWfun(i_bat, i_day) <= maxW   % if below max weight
                
                batWfun(:, i_day) =  batWfun(:, i_day) + (1/b)*foundF(i_bat, i_day-1);
                
                if batWfun(i_bat, i_day) > maxW   % if above max weight
                    batWfun(i_bat, i_day) = maxW;
                end
                
            else
                batWfun(:, i_day) =  batWfun(:, i_day) + (1/b)*foundF(i_bat, i_day-1);
                
                batWfun(i_bat, i_day) = maxW;
                
            end
            
%         end
%         
%     else
%        
%         batWfun(i_bat, i_day) =  batWfun(i_bat, i_day) + (1/b)*foundF(i_bat, i_day-1) + safeF;
%         batWfun(otherbat, i_day) =  batWfun(otherbat, i_day) + (1/b)*foundF(i_bat, i_day-1) - safeF;
%         
%     end
    
            batSfun(i_bat, i_day) = 2;
            
%            fprintf(i_bat, 'share \n');
    
else
    
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
    
end

end