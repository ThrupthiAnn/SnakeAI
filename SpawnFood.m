function food = SpawnFood(nrows, snake)
plat = zeros(nrows);
for ii=1:size(snake,1)
    plat(snake(ii,1), snake(ii,2)) = 1;
end
if nnz(~logical(plat))==0
    fprintf('You won!');
    food = 0;
else
flag = 0;
while(flag==0)
    food(1) = randi(nrows);
    food(2) = randi(nrows);
    if plat(food(1), food(2))==0
        flag=1;
    end
end
end
end