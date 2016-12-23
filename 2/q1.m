
im = imread('image1.jpg');
[rows column depth] = size(im);
if(depth==3)
    im = rgb2gray(im); % convert to gray scale if it is color image
end
count = 0;
cumF = 0;
t=1:256;
n=0:255;
f = 1:256;
r = 1:256;
numBins = 255;
numPixels = rows*column;
output = zeros(rows,column);
for z=1:256
    for l=1:rows
        for m=1:column
            if im(l,m)== z-1
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
r
for l=1:rows
    for m=1:column
        output(l,m) = r(im(l,m)+1);
    end
end

imshow(uint8(output));

