filefolder = 'C:\Users\praveen\Desktop\imgp\5\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);       
       
for i=[6]
    
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename);
    im = rgb2gray(im);
    im2 = im2bw(im);
    [row column depth] = size(im);
    strel = [ 1 1 1;1 1 1;1 1 1];
    C=padarray(im2,[1 1]);
    C1 = padarray(im,[1 1]);
    new = zeros(size(im));
    
    for i=1:row
        for j=1:column            
           if (sum(sum(strel & C(i:i+2,j:j+2))) == 1)
               new(i,j) = max(max(C1(i:i+2,j:j+2)));
           else
               new(i,j) = im(i,j);
           end
        end
    end
    imshow(uint8(new));
    
end