filefolder = 'C:\Users\praveen\Desktop\imgp\1\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);
count = 0;
for i=9
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename);
    [rows column depth] = size(im);
     if(depth==3)
        im = rgb2gray(im); % convert to gray scale if it is color image
     end
    rmin=25;
    rmax= 200;
    output = zeros(rows,column);
    for l=1:rows
        for m=1:column
            if (rmin < im(l,m)&& im(l,m) < rmax)
                output(l,m) = im(l,m);
            else
                % otherwise store the same value of the pixel in the result image
                output(l,m) = 0;
            end
        end
    end
   
    out = sprintf('(%s)-out.jpg',filename);
    imwrite(uint8(output),out)
                
end