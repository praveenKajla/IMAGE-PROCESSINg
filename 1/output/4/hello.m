filefolder = 'C:\Users\praveen\Desktop\imgp\1\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);
count = 0;
for i=[22 4]
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    images{i-2} = imread(fullfilename);
       
    [rows column depth] = size(images{i-2});
    images{i-2} = rgb2gray(images{i-2});
    
    maximum = max(images{i-2}(:));
    c = 255/log10(1+double(maximum))
    
    output = zeros(rows,column);
    for l=1:rows
        for m=1:column
            output(l,m) = c.*log10(double(images{i-2}(l,m))+1);
           
        end
    end
    out = sprintf('(%s)-out.jpg',filename);
    imwrite(uint8(output),out)
                
end