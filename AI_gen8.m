function [direction, data] = AI_gen8(nrows, snake, food, data)
% logic:don't divide the field

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

dists = GetDists(plat, snake, food);
snakex = snake(1,1);
snakey = snake(1,2);

% right
if dists(4)==Inf
    conn(4) = Inf;
else
    pplat = plat;
    pplat(snakex, snakey+1) = 1;
    if ~isequal(food, [snakex, snakey+1])
        pplat(snake(end, 1), snake(end,2))= 0;
    end
    conn(4) = NConnected(pplat);
end

% left
if dists(3) == Inf
    conn(3) = Inf;
else
    pplat = plat;
    pplat(snakex, snakey-1) = 1;
    if ~isequal(food, [snakex, snakey-1])
        pplat(snake(end, 1), snake(end, 2)) = 0;
    end
    conn(3) = NConnected(pplat);
end

% down
if dists(2) == Inf
    conn(2) = Inf;
else
    pplat = plat;
    pplat(snakex+1, snakey) = 1;
    if ~isequal(food, [snakex+1, snakey])
        pplat(snake(end, 1), snake(end, 2)) = 0;
    end
    conn(2) = NConnected(pplat);
end

% up

if dists(1) == Inf
    conn(1) = Inf;
else
    pplat = plat;
    pplat(snakex-1, snakey) = 1;
    if ~isequal(food, snake(1, :))
        pplat(snake(end,1), [snakex-1, snakey]) = 0;
    end
    conn(1) = NConnected(pplat);
end
     
direction = 4; % default direction
if min(conn)<Inf
    inds = find(conn==min(conn));
    dists = dists(inds);
    [~, ind] = find(dists==min(dists),1);
    direction = inds(ind);
else % chase tail
    pplat = plat;
    pplat(snake(end,1), snake(end,2)) = 0;
    disttrans = bwdistgeodesic(~logical(pplat), snake(end, 2), snake(end, 1));
    direction = LongestPath(disttrans, snake);
end

% go clockwise
if direction ==0
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

function direction = LongestPath(disttrans, snake)
snake = snake(1,:);
nrows =  size(disttrans, 1);
longest = -1;
direction = 0;
if snake(1)>1
    if disttrans(snake(1)-1, snake(2))>longest
        longest = disttrans(snake(1)-1, snake(2));
        direction = 1;
    end
end
if snake(1)<nrows
    if disttrans(snake(1)+1, snake(2))>longest
        longest = disttrans(snake(1)+1, snake(2));
        direction = 2;
    end
end
if snake(2)>1
    if disttrans(snake(1), snake(2)-1)>longest
        longest = disttrans(snake(1), snake(2)-1);
        direction = 3;
    end
end
if snake(2)<nrows
    if disttrans(snake(1), snake(2)+1)>longest
        direction = 4;
    end
end
end

function  conn = NConnected(plat)
L = bwlabel(~logical(plat),4);
conn = max(L(:));
end

function dists = GetDists(plat, snake, food)
distrans = bwdistgeodesic(~logical(plat), food(2), food(1));
nrows = size(plat, 1);

snakex = snake(1,1);
snakey = snake(1,2);

if snakey == nrows
    dists(4) = Inf;
else
    if plat(snakex, snakey+1)==1
        dists(4)=Inf;
    else
        dists(4) = distrans(snakex, snakey+1);
    end
end
if snakey == 1
    dists(3) = Inf;
else
    if plat(snakex, snakey-1)==1
        dists(3) = Inf;
    else
        dists(3) = distrans(snakex, snakey-1);
    end
end
if snakex == nrows
    dists(2) = Inf;
else
    if plat(snakex+1, snakey)==1
        dists(2)=Inf;
    else
        dists(2)  = distrans(snakex+1, snakey);
    end
end
if snakex == 1
    dists(1) = Inf;
else
    if plat(snakex-1, snakey)==1
        dists(1)=Inf;
    else
        dists(1) = distrans(snakex-1, snakey);
    end
end
end
