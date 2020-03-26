function [direction, data] = AI_gen7(nrows, snake, food, data)
% logic: go in the direction of most freedom!

% 1 = up 
% 2 = down 
% 3 = left
% 4 = right

% initialize data: this can be anything the AI wants to store
if ~exist('data','var')
    data=4;
end

% initialize game field
plat = zeros(nrows);
for ii=1:size(snake, 1)
    plat(snake(ii,1), snake(ii,2)) = 1;
end

distrans = bwdistgeodesic(~logical(plat), food(2), food(1));

% determine which direction is better
[up_dist, up_free] = CheckFreedom(plat, distrans, snake, [snake(1,1)-1, snake(1,2)]);
[down_dist, down_free] = CheckFreedom(plat, distrans, snake, [snake(1,1)+1, snake(1,2)]);
[left_dist, left_free] = CheckFreedom(plat, distrans, snake, [snake(1,1), snake(1,2)-1]);
[right_dist, right_free] = CheckFreedom(plat, distrans, snake, [snake(1,1), snake(1,2)+1]);

dist = [up_dist, down_dist, left_dist, right_dist];
mindist = min(dist);
free = [up_free, down_free, left_free, right_free];
free(dist~=mindist) = 0;
direction = find(free==max(free),1);

end

function [dist, free] = CheckFreedom(plat, distrans, snake, next)
nrows = size(plat, 1);
if next(1)==0 || next(1)==(nrows+1) || next(2) ==0||next(2)==(nrows+1)
    dist = Inf;
    free = 0;
elseif plat(next(1), next(2))==1
    dist = Inf;
    free = 0;
else
    dist = distrans(next(1), next(2));
    if distrans(next(1), next(2))>0
        plat(snake(end, 1), snake(end, 2)) = 0;
    end
    trans = bwdistgeodesic(logical(~plat), next(2), next(1));
    free = nnz(~(isnan(trans)|isinf(trans)));
end
end

