filefolder = 'C:\Users\praveen\Desktop\imgp\2\Input Images\';
filename1 = 'imagex.jpg';
filename2 = 'image2.jpg';
fullfilename1 = fullfile(filefolder,filename1);
fullfilename2 = fullfile(filefolder,filename2);

imRef = imread(fullfilename1);
imSrc = imread(fullfilename2);

% finding histogram equalization(matrix) for reference image
[rowsRef columnRef depth] = size(imRef);
if(depth==3)
    im = rgb2gray(imRef); % convert to gray scale if it is color image
end
count = 0;
cumF = 0;
t=1:256;
n=0:255;
f = 1:256;
r = 1:256;
numBins = 255;
numPixels = rowsRef*columnRef;

for z=1:256
    for l=1:rowsRef
        for m=1:columnRef
            if imRef(l,m)== z-1
                count = count+1;
            end
        end
    end
    t(z) = count;
    cumF = cumF+count;
    f(z) = cumF;
    count = 0;
    
end
rvalue = numBins/cumF;
for i=1:256
    r(i) = round(rvalue*f(i));
end

% Here the processing on src image Begins
[rowsSrc columnSrc depthSrc] = size(imSrc);
output = zeros(rowsSrc,columnSrc,depthSrc);
for l=1:rowsSrc
    for m=1:columnSrc
        for d=1:depthSrc
            output(l,m,d) = r(imSrc(l,m,d)+1);
        end      
    end
end

imshow(uint8(output));