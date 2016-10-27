filefolder = 'C:\Users\praveen\Desktop\imgp\6\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);       
       
for i=[3 ]
    
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = double(imread(fullfilename));  
    [row column depth] = size(im);    
    wM        = zeros(row,row);
    wN        = zeros(column,column);
    Fr = zeros(size(im));
    for u = 0 : (row - 1)
        for x = 0 : (row - 1)
            wM(u+1, x+1) = exp(-2 * pi*1i/ row * x * u);
        end
    end
    
    for v = 0 : (column - 1)
        for y = 0 : (column - 1)
            wN(v+1, y+1) = exp(-2 * pi*1i / column * y * v);
        end
    end

    F = wM * double(im) * wN;
    for i=1:row
        for j=1:column
            Fr(i,j) = sqrt(real(F(i,j))^2 + imag(F(i,j))^2)/10000;
        end
    end
    imshow(Fr);
   
end