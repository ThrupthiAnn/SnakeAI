function [direction, data] = AI_gen4(nrows, snake, food, data)
%logic: shortest path to the food

% 1 = up 
% 2 = down 
% 3 = left
% 4 = right

% initialize data
if ~exist('data','var')
    data=4;
end

% initialize game field
plat = zeros(nrows);
for ii=1:size(snake, 1)
    plat(snake(ii,1), snake(ii,2)) = 1;
end
 
disttran = bwdistgeodesic(~logical(plat), food(2), food(1));

smallest = Inf;
direction = 4;
if snake(1,1)>1
    if disttran(snake(1,1)-1, snake(1,2))<smallest
        smallest = disttran(snake(1,1)-1, snake(1,2));
        direction = 1;
    end
end
if snake(1,1)<nrows
    if disttran(snake(1,1)+1, snake(1,2))<smallest
        smallest = disttran(snake(1,1)+1, snake(1,2));
        direction = 2;
    end
end
if snake(1,2)>1
    if disttran(snake(1,1),snake(1,2)-1)<smallest
        smallest = disttran(snake(1,1), snake(1,2)-1);
        direction = 3;
    end
end
if snake(1,2)<nrows
    if disttran(snake(1,1), snake(1,2)+1)<smallest
        direction = 4;
    end
end
