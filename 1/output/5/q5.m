filefolder = 'C:\Users\praveen\Desktop\imgp\1\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);
count = 0;
for i=17:21
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename);
    gamma = 5;
    [rows column depth] = size(im);
     if(depth==3)
        im = rgb2gray(im); % convert to gray scale if it is color image
    end
    
    output = zeros(rows,column);
    for l=1:rows
        for m=1:column
            output(l,m) = (double(im(l,m))+1)^gamma;
           
        end
    end
    outputE = (output/(max(output(:))))*255;
    out = sprintf('(%s)-out.jpg',filename);
    imwrite(uint8(outputE),out)
                
end