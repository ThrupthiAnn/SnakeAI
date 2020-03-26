function [direction, data] = AI_gen1(nrows, snake, food, data)
% logic: go round and round the field

% initialize data
if ~exist('data','var')
    data=4;
end

% direction 1 = up 2 = down 3 = left 4 = right
plat = zeros(nrows);
for ii=1:size(snake, 1)
    plat(snake(ii,1), snake(ii,2)) = 1;
end

if data==4 
    if snake(1,2)>=nrows
        direction = 2;
    else
        direction = 4;
    end
elseif data ==2
    if snake(1,1)>=nrows
        direction = 3;
    else
        direction = 2;
    end
elseif data == 3
    if snake(1,2)<=1
        direction=1;
    else
        direction = 3;
    end
elseif data ==1
    if snake(1,1)<=1
        direction = 4;
    else 
        direction = 1;
    end
end
data = direction;

end