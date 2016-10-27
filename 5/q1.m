filefolder = 'C:\Users\praveen\Desktop\imgp\5\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);

        
    

    
    for i=[5]
  
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename); 
    [row column depth] = size(im);
    strel = zeros(15,15);
    for p=1:15
        for q= 1:15
            if (p==1||q==1||p==15||q==15)
                strel(p,q) = 0;
            else
                strel(p,q) = 1;
            end
        end
    end
    new = zeros(size(im));
    for i=1:row
        for j=1:column
            if((i-7)<=0 || (i+7)>row || (j-7)<=0 || (j+7 )>column)
                new(i,j) = 0;
            else
                window = (zeros(15,15));
                for l=1:15
                    for m=1:15
                        window(l,m) = im(i+l-8,j+m-8);
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