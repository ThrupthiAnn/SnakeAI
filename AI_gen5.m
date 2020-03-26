function [direction, data] = AI_gen5(nrows, snake, food, data)
% logic: shortest path to the food or tail. If it doesn't exist, clockwise

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
disttrans = bwdistgeodesic(~logical(plat), food(2), food(1));
direction = BestDirection(disttrans, snake);
if direction==0
    message = 'Following tail ';
    pplat = plat;
    pplat(snake(end,1), snake(end,2)) = 0;
    disttrans = bwdistgeodesic(~logical(pplat), snake(end, 2), snake(end, 1));
    direction = BestDirection(disttrans, snake);
end

% no recovery possible now!
if direction ==0
    message = [message, 'clockwise!'];
    if data==4
        if IsPossible(plat, snake, 4)
            direction = 4;
        elseif IsPossible(plat, snake, 2)
            direction = 2;
        elseif IsPossible(plat, snake, 3)
            direction = 3;
        else
            direction = 1;
        end
    elseif data == 3
        if IsPossible(plat, snake, 3)
            direction = 3;
        elseif IsPossible(plat, snake, 1)
            direction = 1;
        elseif IsPossible(plat, snake, 4)
            direction = 4;
        else
            direction = 2;
        end
    elseif data == 2
        if IsPossible(plat, snake, 2)
            direction = 2;
        elseif IsPossible(plat, snake, 3)
            direction = 3;
        elseif IsPossible(plat, snake, 1)
            direction = 1;
        else
            direction = 4;
        end
    else
        if IsPossible(plat, snake, 1)
            direction = 1;
        elseif IsPossible(plat, snake, 4)
            direction = 4;
        elseif IsPossible(plat, snake, 2)
            direction = 2;
        else
            direction = 3;
        end
    end
       
    data = direction;
end

if exist('message', 'var')
    fprintf('%s\n', message);
end

end

function possible = IsPossible(plat, snake, direction)
nrows = size(plat,1);
possible = 0;
if direction ==1
    if snake(1,1)>1
        if plat(snake(1,1)-1, snake(1,2))==0
            possible = 1;
        end
    end
elseif direction ==2
    if snake(1,1)<nrows
        if plat(snake(1,1)+1, snake(1,2))==0
            possible = 1;
        end
    end
elseif direction ==3
    if snake(1,2)<1
        if plat(snake(1,1), snake(1,2)-1)==0
            possible = 1;
        end
    end
elseif direction == 4
    if snake(1,2)<nrows
        if plat(snake(1,1), snake(1,2)+1)==0
            possible = 1;
        end
    end
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
    