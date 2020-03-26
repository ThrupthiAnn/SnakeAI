function [direction, data] = AI_gen11(nrows, snake, food, data)
% LOGIC: follow Hamiltonian path. Take short-cut if there is no snake in
% the path you cut off and the distance to food becomes shorter

if mod(nrows, 2)==1
    error('This AI needs nrows to be even')
end

% 1 = up 
% 2 = down 
% 3 = left
% 4 = right

% initialize game field
plat = zeros(nrows);
for ii=1:size(snake, 1)
    plat(snake(ii,1), snake(ii,2)) = 1;
end

graph = Hamilton(nrows);

snakex = snake(1,1);
snakey = snake(1,2);
d1 = graph(snakex, snakey);
foodg = graph(food(1), food(2));

dists = zeros(1,4)+Inf;

if snakex>1
    if IsEmpty(graph, plat, d1, graph(snakex-1, snakey))
         dists(1) = HDistance(nrows, graph(snakex-1, snakey), foodg);
    end
end
if snakex<nrows
    if IsEmpty(graph, plat, d1, graph(snakex+1, snakey))
            dists(2) = HDistance(nrows, graph(snakex+1, snakey), foodg);
    end
end
if snakey>1
    if IsEmpty(graph, plat, d1, graph(snakex, snakey-1))
            dists(3) = HDistance(nrows, graph(snakex, snakey-1), foodg);
    end
end
if snakey<nrows
    if IsEmpty(graph, plat, d1, graph(snakex, snakey+1))
            dists(4) = HDistance(nrows, graph(snakex, snakey+1), foodg);
    end
end

[~, direction] = min(dists);
end

function dist = HDistance(nrows, d1, d2)
% compute  forward distance from d1 to d2
if d2>=d1
    dist = d2-d1;
else
    maxnum = nrows*nrows-1;
    dist = maxnum-d1+d2+1;
end
end

function check = IsEmpty(graph, plat, d1, d2)
if d2>d1
    portion = plat(graph>=d1&graph<=d2);
else
    portion = plat(graph>=d1|graph<=d2);
end
check = sum(portion)==1;
end