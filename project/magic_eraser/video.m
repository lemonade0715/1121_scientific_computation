% video.m
obj = VideoReader("walk.mp4");
numFrames = obj.NumFrames;
%
init_directory();
for i=1:numFrames
    frame = read(obj,i);
    show_read_frame_progress(i,numFrames,10);
    imwrite(frame,strcat("./photos/shark_",num2str(i),'.png'),'png');
end
%}

[x,y,z] = size(imread("./photos/shark_1.png"));
X = zeros(x,y,z,"uint8");
frame_sep = 6;
%time = zeros(2,z);
for channel=1:z
    %tic;
    A = zeros(x*y, ceil(numFrames/frame_sep));
    frame_count = 1;
    for i=1:frame_sep:numFrames
        img = imread(sprintf("./photos/shark_%d.png",i));
        fprintf("Reshaping frame %d of channel %d...\n", i, channel);
        A(:,frame_count) = reshape(img(:,:,channel),[],1);
        frame_count = frame_count + 1;
    end
    fprintf("Complete!\n\n");
    %time(1,channel) = toc;
    %tic;
    fprintf("Starting singular value decomposition of channel %d...\n", channel);
    [U,S,V] = svd(A,'econ');
    fprintf("Reshaping channel %d of the image...\n", channel);
    disp("Singular Values:");
    disp(diag(S));
    X(:,:,channel) = uint8(reshape(U(:,1) .* S(1,1) .* V(1,1), x, y));
    fprintf("Complete!\n\n");
    %time(2,channel) = toc;
end
disp("Complete!");
%disp(time);
imshow(X);

function init_directory(~)
    disp("Initializing directory './photos/'...");
    delete ./photos/*.png;
    fprintf("Complete!\n\n");
end

function show_read_frame_progress(curr,total,sep)
    if (mod(curr,sep) == 1)
        if (curr+sep-1 < total)
            fprintf("Writing frame %d-%d", curr, curr+sep-1);
            fprintf(" to './photos/'...\n");
        else
            fprintf("Writing frame %d-%d", curr, total);
            fprintf(" to './photos/'...\n");
            fprintf("Complete!\n\n");
        end        
    end
end