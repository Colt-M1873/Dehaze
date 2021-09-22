vidIn = VideoReader('C:\Users\yangjianan\Pictures\Haze\vid5.mp4');
vidOut = VideoWriter('newfile2.avi');
vidOut.Quality=100;
open(vidOut)
a=get(vidIn)
b=get(vidOut)

while hasFrame(vidIn)
    vidFrameIn = readFrame(vidIn);
%     imshow(vidFrame)
%     class(vidFrameIn)
    vidFrameMid = im2double(vidFrameIn);
    tic
    vidFrameOut = Haze_Remove(vidFrameMid);

    toc
    t=toc
    vidFrameOut = im2uint8(vidFrameOut);
    
    
    writeVideo(vidOut,vidFrameOut)

    pause(1/vidIn.FrameRate);
end


% for i = 1:25
%     A = rand(300);
% end
close(vidOut)