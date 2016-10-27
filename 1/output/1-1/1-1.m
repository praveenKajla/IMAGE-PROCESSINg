filefolder = 'C:\Users\praveen\Desktop\imgp\1\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);
count = 0;
for i=3:nfiles
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    images{i-2} = imread(fullfilename);
    [rows column depth] = size(images{i-2});
    if depth==3
        images{i-2} = rgb2gray(images{i-2});
    end
    output = zeros(rows,column);
    for l=1:rows
        for m=1:column
            output(l,m) = uint8(images{i-2}(l,m) +10);
           
        end
    end
    out = sprintf('%d-out.jpg',i-2);
    imwrite(uint8(output),out)
                
end