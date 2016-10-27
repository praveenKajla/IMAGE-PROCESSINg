filefolder = 'C:\Users\praveen\Desktop\imgp\4\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);

        
    

    
    for i=[4]
  
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    lbp = imread(fullfilename); 
    [row column depth] = size(lbp);
    
    im = zeros(size(lbp));
    
    for i=2:row-1
        for j=2:column-1
            b = zeros(8,1);            
            b(1) = lbp(i,j-1)>lbp(i,j);
            b(2) = lbp(i+1,j-1)>lbp(i,j);
            b(3) = lbp(i+1,j)>lbp(i,j);
            b(4) = lbp(i+1,j+1)>lbp(i,j);
            b(5) = lbp(i,j+1)>lbp(i,j);
            b(6) = lbp(i-1,j+1)>lbp(i,j);
            b(7) = lbp(i-1,j)>lbp(i,j);
            b(8) = lbp(i-1,j-1)>lbp(i,j);  
            
            dec = b(1)*2^7 +b(2)*2^6+b(3)*2^5+b(4)*2^4+b(5)*2^3+b(6)*2^2+b(7)*2+b(8);
            im(i,j) = dec;
        end
    end
    subplot(1,2,1),imshow(lbp);
    subplot(1,2,2),imshow(uint8(im))
end