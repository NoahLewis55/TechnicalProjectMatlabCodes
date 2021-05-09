function [...
    batWfun, ...
    batSfun...
    ] = greedy(...
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

% % if other bat
% if i_bat == 1
%     otherbat = 2;
% elseif i_bat == 2
%     otherbat = 1;
% else
%     otherbat = 0;
% end

if batWfun(i_bat, i_day) >= minW   % if alive
    
%     if ((batW(otherbat, i_round) >= minSW - ff(i_bat, i_round-1)) && (batW(otherbat, i_round) < minSW) && (batW(i_bat, i_round) >= minSW))
%         foodforself = ff(i_bat, i_round-1) - (minSW - batW(otherbat, i_round));
%         batW(otherbat, i_round) = batW(otherbat, i_round) + ff(i_bat, i_round-1) - foodforself;
%     else
%         foodforself = ff(i_bat, i_round-1);
%     end
    
    
    if batWfun(i_bat, i_day) <= maxW   % if below max weight
        
        batWfun(i_bat, i_day) =  batWfun(i_bat, i_day) + foundF(i_bat, i_day-1);
        
        if batWfun(i_bat, i_day) > maxW   % if above max weight
            batWfun(i_bat, i_day) = maxW;
            
        end
        
    else
        batWfun(i_bat, i_day) = maxW;
        
    end
    
    batSfun(i_bat, i_day) = 1;
    
%   fprintf(i_bat, 'greedy \n');

else
    batWfun(i_bat, i_day) = 0;
    
    
end

end