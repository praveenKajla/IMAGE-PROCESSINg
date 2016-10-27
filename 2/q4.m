filefolder = 'C:\Users\praveen\Desktop\imgp\2\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);

for i=[5 6]
  
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename);
    [rows column depth] = size(im);
    imM = zeros(rows+2,column+2,depth);
    imM1 = zeros(rows+4,column+4,depth);
    imB3 = zeros(size(im));
    imB5 = zeros(size(im));
   
    for l=1:rows
        for m=1:column
            for n=1:depth
                imM(l+1,m+1,n) = im(l,m,n);
            end
        end
    end
   for l=1:rows
        for m=1:column
            for n=1:depth
                imM1(l+2,m+2,n) = im(l,m,n);
            end
        end
    end
    
   for i=1:rows
        for j=1:column
            for k=1:depth
                window1 = zeros(9,1);
                window2 = zeros(25,1);
                inc =1;
                for x=1:3
                    for y=1:3
                        window1(inc) = imM(i+x-1,j+y-1,k);
                        inc = inc+1;
                    end
                end
                inc =1;
                for x=1:5
                    for y=1:5
                        window2(inc) = imM1(i+x-1,j+y-1,k);
                        inc = inc+1;
                    end
                end
                
            med2 = sort(window2);
            med1=sort(window1);
            imB3(i,j,k) = mean(med1);
            imB5(i,j,k) = mean(med2);
            end            
        end
   end
    out1 = sprintf('(%s)-Meanfilter3.jpg',filename);
    out = sprintf('(%s)-Meanfilter5.jpg',filename);
    imwrite(uint8(imB3),out1);
    imwrite(uint8(imB5),out);
end