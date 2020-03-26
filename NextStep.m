function [status, food, snake, score] = NextStep(nrows, food, snake, direction, score)
% status 1=alive, 0 = dead
% direction 1 = up 2 = down 3 = left 4 = right
status = 1;
current = snake(1,:);
next = current;
if direction ==1
    next(1) = current(1)-1;
elseif direction == 2
    next(1) = current(1)+1;
elseif direction ==3
    next(2) = current(2)-1;
elseif direction ==4
    next(2) = current(2)+1;
else
    error('Wrong direction value of %d. Direction should be 1,2,3 or 4', direction);
end

snake = [next;snake];

% check dead
if next(1)<1 || next(1)>nrows || next(2)<1 || next(2)>nrows
    status = 0;
end
for ii=2:length(snake)
    if next(1)==snake(ii,1) && next(2)==snake(ii,2)
        status = 0;
    end
end

% check food
if status == 1
if next(1)==food(1) && next(2)==food(2)
    score = score+1;
    food = SpawnFood(nrows, snake);
else
    snake = snake(1:end-1,:);
end
end
end



