function [direction, data] = AI_gen2(nrows, snake, food, data)
% logic: choose direction based on the row and column of the food
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

if food(1)<snake(1,1)
    direction = 1;
elseif food(1)>snake(1,1)
    direction = 2;
else
    if food(2)<snake(1,2)
        direction = 3;
    else
        direction = 4;
    end
end