filefolder = 'C:\Users\praveen\Desktop\imgp\4\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);

        
    

    
    for i=[4]
  
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im2 = imread(fullfilename); 
    [row column depth] = size(im2);
    lbp = zeros(size(im2)+2);
    im = zeros(size(im2));
    for i=1:row
        for j=1:column
            lbp(i+1,j+1) = im2(i,j);
        end
    end
    
    for l=1:row
        for m=1:column
            b = zeros(8,1);            
            i=l+1;
            j=m+1;
            b(1) = lbp(i,j-1)>=lbp(i,j);
            b(2) = lbp(i+1,j-1)>=lbp(i,j);
            b(3) = lbp(i+1,j)>=lbp(i,j);
            b(4) = lbp(i+1,j+1)>=lbp(i,j);
            b(5) = lbp(i,j+1)>=lbp(i,j);
            b(6) = lbp(i-1,j+1)>=lbp(i,j);
            b(7) = lbp(i-1,j)>=lbp(i,j);
            b(8) = lbp(i-1,j-1)>=lbp(i,j);  
            
            dec = b(1)*2^7 +b(2)*2^6+b(3)*2^5+b(4)*2^4+b(5)*2^3+b(6)*2^2+b(7)*2+b(8);
            im(i-1,j-1) = dec;
        end
    end
    subplot(1,2,1),imshow(im2);
    subplot(1,2,2),imshow(uint8(im))
end