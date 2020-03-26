function [handle, frame] = Render(nrows, snake, food, status, handle)
if ~exist('status', 'var')
    status = 1;
end
if status
multiplier = 700/nrows;
if multiplier<3
    multiplier=3;
end
multiplier = floor(multiplier);
border = floor(multiplier/3);
backcolor = [0,0,0];
snakecolor = [0,1,1];
foodcolor = [1,0,0];
headcolor = [1,0.5,0];

% create background
img = zeros(nrows*multiplier, nrows*multiplier, 3, 'double');
img(:,:,1) = backcolor(1);
img(:,:,2) = backcolor(2);
img(:,:,3) = backcolor(3);

% % put a thin grid
% img(1:multiplier:end, :,2)=0.5;
% img(1:multiplier:end, :,2)=0.5;
% img(:,1:multiplier:end,2)=0.5;
% img(:,1:multiplier:end,2)=0.5;


% draw food
ux= (food(1)-1)*multiplier+1;
uy = (food(2)-1)*multiplier+1;
dx = food(1)*multiplier;
dy = food(2)*multiplier;
img(ux:dx, uy:dy,1) = foodcolor(1);
img(ux:dx, uy:dy,2) = foodcolor(2);
img(ux:dx, uy:dy, 3) = foodcolor(3);

% draw snake
m4 = floor(multiplier/4);
ux = (snake(1,1)-1)*multiplier + m4;
uy = (snake(1,2)-1)*multiplier + m4;
dx = snake(1,1)*multiplier - m4 + 1;
dy = snake(1,2)*multiplier -m4 + 1;
img(ux:dx, uy:dy,1) = headcolor(1);
img(ux:dx, uy:dy, 2) = headcolor(2);
img(ux:dx, uy:dy, 3) = headcolor(3);
for ii = 2:size(snake,1)
    ux = (snake(ii,1)-1)*multiplier+border;
    uy = (snake(ii,2)-1)*multiplier+border;
    dx = snake(ii,1)*multiplier-border+1;
    dy = snake(ii,2)*multiplier-border+1;
    pux = ux;
    puy = uy;
    pdx = dx;
    pdy = dy;

    if ii<size(snake,1)
        if snake(ii,1)==snake(ii+1,1)
            if snake(ii,2)<snake(ii+1,2)
                dy = snake(ii,2)*multiplier;
            else
                uy = (snake(ii,2)-1)*multiplier+1;
            end
        else
            if snake(ii,1)<snake(ii+1,1)
                dx = snake(ii,1)*multiplier;
            else
                ux = (snake(ii,1)-1)*multiplier+1;
            end            
        end
    end
    if snake(ii,1)==snake(ii-1,1)
        if snake(ii,2)<snake(ii-1,2)
            pdy = snake(ii,2)*multiplier;
        else
            puy = (snake(ii,2)-1)*multiplier +1;
        end
    else
        if snake(ii,1)<snake(ii-1,1)
            pdx = snake(ii,1)*multiplier;
        else
            pux = (snake(ii,1)-1)*multiplier;
        end
    end    
    img(ux:dx, uy:dy, 1) = snakecolor(1);
    img(ux:dx, uy:dy, 2) = snakecolor(2);
    img(ux:dx, uy:dy, 3) = snakecolor(3);
    img(pux:pdx, puy:pdy,1) = snakecolor(1);
    img(pux:pdx, puy:pdy,2) = snakecolor(2);
    img(pux:pdx, puy:pdy, 3) = snakecolor(3);
end

% draw everything
if ~exist('handle','var')
    handle= figure;
end
imshow(img);
%pause(0.001)
frame = img;
end