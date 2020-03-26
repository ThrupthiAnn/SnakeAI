function graph = RandomHamilton(nrows, niter)
if mod(nrows, 2)==1
    error('Hamilton wont work with odd nrows');
end

if ~exist('niter', 'var')
    niter = 100;
end

graph = Hamilton(nrows);

for ii =1:niter
    graph = BackBite(graph);
end

while ~IsCycle(graph)
    graph = BackBite(graph);
end

end

function check = IsCycle(graph)
n = max(graph(:));
[x1,y1] = find(graph==0);
[x2, y2] = find(graph==n);
check = false;
if x1==x2
    if y1==y2+1 || y1==y2-1
        check = true;
    end    
elseif y1==y2
    if x1==x2+1 || x1==x2-1
        check = true;
    end
end

end