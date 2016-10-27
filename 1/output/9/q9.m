filefolder = 'C:\Users\praveen\Desktop\imgp\1\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);

for i=[15]
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename);
    [rows column depth] = size(im);
     if(depth==3)
        im = rgb2gray(im); % convert to gray scale if it is color image
     end
     count = 0;
     t=1:256;
     n=0:255;
     for z=1:256
         for l=1:rows
             for m=1:column
                 if im(l,m)== z-1
                    count = count+1;
                 end
             end
         end
         if z>130 & z<200
             z = int8((((200-50)/(200-130))*(z-130))+50)
         end
         t(z) = count;
         count = 0;
            
     end
     disp(t'')
     
     stem(n,t);
     grid on;
     ylabel('no. of pixels with such intensity levels---->');
     xlabel('intensity levels---->'); title('HISTOGRAM OF THE IMAGE')
     
end