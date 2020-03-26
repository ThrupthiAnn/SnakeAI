function graph = Hamilton(nrows)
graph = zeros(nrows);
graph(1,1) = 0;
number = 1;
for ii =1:nrows
    if mod(ii,2)==1
        for jj = 2:nrows
            graph(ii, jj) = number;
            number = number+1;
        end
    else
        for jj = nrows:-1:2
            graph(ii,jj) = number;
            number = number+1;
        end
    end
end
for ii = nrows:-1:2
    graph(ii,1) = number;
    number = number+1;
end
end