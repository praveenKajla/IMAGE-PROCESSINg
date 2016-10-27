filefolder = 'C:\Users\praveen\Desktop\imgp\5\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);

        
    

    
    for i=[5]
  
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename); 
    [row column depth] = size(im);
    a = strel('disk',10);
    strel = a.Neighborhood;
    new = zeros(size(im));
    for i=1:row
        for j=1:column
            if((i-9)<=0 || (i+9)>row || (j-9)<=0 || (j+9 )>column)
                new(i,j) = 0;
            else
                window = (zeros(19,19));
                for l=1:19
                    for m=1:19
                        window(l,m) = im(i+l-10,j+m-10);
                    end
                end
               
                if (window(strel==1) == 1)
                    new(i,j) = 1;
                else
                    new(i,j) = 0;
                end
            end
        end
    end
    imshow((new));       
    
end