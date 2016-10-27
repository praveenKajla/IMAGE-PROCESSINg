filefolder = 'C:\Users\praveen\Desktop\imgp\3\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);

for i=[3]
  
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im2 = imread(fullfilename);
    
    im = im2double(rgb2gray(im2));
    [rows column depth] = size(im);
    Gy = zeros(size(im));
    x = [1,0;0,-1];
    y = [0,1;-1,0];
    for l=1:rows
        for m=1:column
            for n=1:depth
                sx = 0;
                sy = 0;
                for i=1:2
                    for j=1:2
                       if(l+i-1<1 ||  l+i-1>rows)
                           sx = 0;
                           sy = 0;
                           continue
                       end
                       if(m+j-1<1 || m+j-1>column)
                           sx=0;
                           sy=0;
                           continue
                       end
                       
                       sx = sx+im(l+i-1,m+j-1)*x(i,j);
                       sy = sy+im(l+i-1,m+j-1)*y(i,j);
                    end
                end
                Gy(l,m,n) = sqrt(sx.^2 + sy.^2);
               
            end
        end
    end
  
    out1 = sprintf('(%s)-RobertCross.jpg',filename);
    BW = im2bw(Gy.^2, 6*mean(Gy(:).^2)); % thats what the inbuilt func uses
    subplot(1,2,1),imshow(Gy),title('Gradient magnitude [0,1]');
    subplot(1,2,2),imshow(BW),title('Binary');
    
    
end