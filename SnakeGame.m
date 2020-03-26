% user options
nrows = 10; % size of the playing field. It will always be square and even
AI = @AI_gen12; % choose which agent you want
create_video = true; % do you want to record the game?
video_name = 'Snake_game.avi'; % name of the video file for your record

% these variables are not user options
snake = [1,1];
status = 1;
score = 0;
food = SpawnFood(nrows, snake);
handle = Render(nrows, snake, food);
data=4;
if mod(nrows,2)==1
    nrows =nrows+1;
end
if create_video
    writer = VideoWriter(video_name);
    writer.FrameRate = 25;
    open(writer);
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
    [handle, frame] = Render(nrows, snake, food,  status, handle);
    if create_video
        frame = im2frame(frame);
        writeVideo(writer, frame);
    end
    
    title(sprintf('Score = %d', score));
end
catch ME
    if create_video
        close(writer);
    end
end

fprintf('Game over! Final score is %d\n',score);