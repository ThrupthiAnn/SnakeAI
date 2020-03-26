function graph = BackBite(graph)

nrows = size(graph,1);

% step 1: find zero
[x,y] = find(graph==0);

% step 2: choose a direction n
choices = [];
if x>1
    if graph(x-1, y)~=1
        choices(end+1) = graph(x-1, y);
    end
end
if x<nrows
    if graph(x+1, y)~=1
        choices(end+1) = graph(x+1, y);
    end
end
if y>1
    if graph(x, y-1)~=1
        choices(end+1) = graph(x, y-1);
    end
end
if y<nrows
    if graph(x, y+1)~=1
        choices(end+1) = graph(x, y+1);
    end
end
ind = randperm(length(choices), 1);
choice = choices(ind);
graph2 = graph;

% step 3: make 0 = n-1, 1= n-2 etc till you reach zero
choice = choice-1;
graph2(x,y) =  choice;
ind = 1;
for ii = choice-1:-1:0
    [x,y] = find(graph==ind);
    graph2(x,y) = ii;
    ind=ind+1;
end
graph=graph2;
end

