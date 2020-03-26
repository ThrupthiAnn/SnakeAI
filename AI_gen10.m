function [direction, data] = AI_gen10(nrows, snake, food, data)
% logic follow a hamiltonian path but take shortcuts if food is nearer,
% cell is free and length of snake is less than length of path after
% cutting

if mod(nrows, 2)==1
    error('The AI needs nrows to be even')
end

graph = Hamilton(nrows);

% 1 = up 
% 2 = down 
% 3 = left
% 4 = right

% initialize game field
plat = zeros(nrows);
for ii=1:size(snake, 1)
    plat(snake(ii,1), snake(ii,2)) = 1;
end

snakelength = size(snake, 1);
snakex = snake(1,1);
snakey = snake(1,2);
foodval = graph(food(1), food(2));
current = graph(snake(1,1), snake(1,2));
next = mod(current+1, nrows*nrows);

direction = 4;
% get default direction
if snake(1,1)>1
    if graph(snake(1,1)-1, snake(1,2))==next
        direction = 1;
    end
end
if snake(1,1)<nrows
    if graph(snake(1,1)+1, snake(1,2))==next
        direction = 2;
    end
end
if snake(1,2)>1
    if graph(snake(1,1), snake(1,2)-1) == next
        direction = 3;
    end
end
if snake(1,2)<1
    if graph(snake(1,1), snake(1,2)+1)==next
        direction = 4;
    end
end

% look for shortcuts
directions = zeros(1,4)-Inf;
% check up direction
if snakex>1
    up = graph(snakex-1, snakey);
    if up>current &&foodval>=up % go forward in the hamiltonion path
        %if sum(plat(graph>=current & graph<=up))==0 % no snake in the cut off loop
        if plat(snakex-1, snakey)==0
            directions(1) = up;
        end
    end
end
% check  down direction
if snakex<nrows
    down = graph(snakex+1, snakey);
    if down>current && foodval >=down
        if plat(snakex+1, snakey)==0
            directions(2) = down;
        end
    end
end
% check left direction
if snakey>1
    left = graph(snakex, snakey-1);
    if left>current && foodval>=left
        if plat(snakex, snakey-1)==0
            directions(3) = left;
        end
    end
end
% check right direction
if snakey<nrows
    right = graph(snakex, snakey+1);
    if right>current && foodval>=right
        if plat(snakex, snakey+1)==0
            directions(4) = right;
        end
    end
end
        
if next<max(directions)
    [~, direction] = max(directions);
end

end