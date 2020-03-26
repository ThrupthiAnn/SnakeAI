function [direction, data] = AI_gen4(nrows, snake, food, data)
% logic: shortest path to the food or tail


% 1 = up 
% 2 = down 
% 3 = left
% 4 = right

% initialize data: this can be anything the AI wants to store
if ~exist('data','var')
    data=4;
end

% initialize game field
plat = zeros(nrows);
for ii=1:size(snake, 1)
    plat(snake(ii,1), snake(ii,2)) = 1;
end
 flag = 0;
disttrans = bwdistgeodesic(~logical(plat), food(2), food(1));
direction = BestDirection(disttrans, snake);
if direction==0
    fprintf('Following tail ');
    flag = 1;
    pplat = plat;
    pplat(snake(end,1), snake(end,2)) = 0;
    disttrans = bwdistgeodesic(~logical(pplat), snake(end, 2), snake(end, 1));
    direction = BestDirection(disttrans, snake);
end

% no recovery possible now!
if direction ==0
    fprintf('No recovery possible!\n');
    direction = 4;
elseif flag==1
    fprintf('\n');
end

end

function direction = BestDirection(disttrans, snake)
snake = snake(1,:);
nrows =  size(disttrans, 1);
shortest = Inf;
direction = 0;
if snake(1)>1
    if disttrans(snake(1)-1, snake(2))<shortest
        shortest = disttrans(snake(1)-1, snake(2));
        direction = 1;
    end
end
if snake(1)<nrows
    if disttrans(snake(1)+1, snake(2))<shortest
        shortest = disttrans(snake(1)+1, snake(2));
        direction = 2;
    end
end
if snake(2)>1
    if disttrans(snake(1), snake(2)-1)<shortest
        shortest = disttrans(snake(1), snake(2)-1);
        direction = 3;
    end
end
if snake(2)<nrows
    if disttrans(snake(1), snake(2)+1)<shortest
        direction = 4;
    end
end
end
    