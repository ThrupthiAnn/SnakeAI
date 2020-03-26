function [direction, data] = AI_gen9(nrows, snake, food, data)
% logic follow a hamiltonian path. This only works if nrows is even.

if mod(nrows, 2)==1
    error('The AI needs nrows to be even')
end

    data = Hamilton(nrows);

% 1 = up 
% 2 = down 
% 3 = left
% 4 = right

% initialize data: this can be anything the AI wants to store
if ~exist('data','var')
    data=4;
end

current = data(snake(1,1), snake(1,2));
next = mod(current+1, nrows*nrows);

direction = 4;
if snake(1,1)>1
    if data(snake(1,1)-1, snake(1,2))==next
        direction = 1;
    end
end
if snake(1,1)<nrows
    if data(snake(1,1)+1, snake(1,2))==next
        direction = 2;
    end
end
if snake(1,2)>1
    if data(snake(1,1), snake(1,2)-1) == next
        direction = 3;
    end
end
if snake(1,2)<1
    if data(snake(1,1), snake(1,2)+1)==next
        direction = 4;
    end
end

end


