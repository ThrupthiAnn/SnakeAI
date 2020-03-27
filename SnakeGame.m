clear;

% user options
nrows = 12; % size of the playing field. It will always be square and even
AI = @AI_gen12; % choose which agent you want
create_video = true; % do you want to record the game?
video_name = 'Snake_game.avi'; % name of the video file for your record
create_gif = false; % do you want to record the game as a gif? This option sometimes causes the snake to comit suicide, I don't know why
gif_name = 'Snake_game.gif';

% these variables are not user options
snake = [1,1];
status = 1;
score = 0;
food = SpawnFood(nrows, snake);
handle = Render(nrows, snake, food);
data=4;
videoexception = false;
if mod(nrows,2)==2
    nrows =nrows+1;
end
if create_video
    writer = VideoWriter(video_name);
    writer.FrameRate = 25;
    open(writer);
end
if create_gif
    gif_start = true;
end

% game loop
try
while status==1
    if ~exist('data', 'var')
        [direction, data] = AI(nrows, snake, food);
    else
        [direction,data]= AI(nrows, snake, food,data);
    end
    [status, food, snake, score] = NextStep(nrows, food, snake, direction, score);
    if size(snake,1)==nrows*nrows
        break;
    end
    [handle, img] = Render(nrows, snake, food,  status, handle);
    if create_video
        %frame = imresize(frame, 0.4, 'Nearest');
        frame = im2frame(img);
        writeVideo(writer, frame);
    end
    if create_gif
        simg = imresize(img, 0.2, 'Nearest');
        simg = im2uint8(simg);
        [imind, cm] = rgb2ind(img, 256);
        if gif_start==true
            imwrite(imind, cm,gif_name, 'gif', 'LoopCount', Inf,'DelayTime',0.001);
            gif_start = false;
        else
            imwrite(imind, cm, gif_name, 'gif', 'WriteMode', 'append', 'DelayTime', 0.001);
        end
    end
    
    title(sprintf('Score = %d', score));
end
catch ME
    if create_video
        close(writer);
    end
    videoexception = true;
end

if videoexception==false
    if create_video
        close(writer);
    end
end
fprintf('Game over! Final score is %d\n',score);
