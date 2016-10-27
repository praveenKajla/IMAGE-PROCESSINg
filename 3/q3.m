
prompt = 'Wantto generate images? Yes - 1 ; No-0';
x = input(prompt);
if x == 1
    for y=1:3
        images = zeros(64,64);
        if y==1
            for p=1:64
                for q=1:64
                    if(q<=32)
                        images(p,q) = 1;
                    else
                        images(p,q) = 0;
                    end
                end
                
            end
        end
        if y==2
            i = 0;
            for p=1:64
                for q=1:64
                    if(mod(fix((q+i)/9),2) == 0)
                        images(p,q) = 1;
                    else
                        images(p,q) = 0;
                    end
                    i = fix((q+i)/9);
                end
                
            end
            
        end
        if y==3
            i = 0;
            j=0;
            for p=1:64
                for q=1:64
                    if((mod(fix((q+i)/9),2) == 0 && mod(fix((p+j)/9),2) == 0) || (mod(fix((q+i)/9),2) ==1 && mod(fix((p+j)/9),2) == 1) )
                        images(p,q) = 1;
                    else
                        images(p,q) = 0;
                    end
                    i = fix((q+i)/9);
                    j = fix((p+j)/9);
                end
            end
        end
        
        out = sprintf('input images/imageCreated%d.jpg',y);
        imwrite(images,out);
    end
end


filefolder = 'C:\Users\praveen\Desktop\imgp\3\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);


for i=[5 6 7]
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename);
    [rows column depth] = size(im);
    imM = zeros(rows+2,column+2,depth);    
    imB3 = zeros(size(im));
    
    
    for l=1:rows
        for m=1:column
            for n=1:depth
                imM(l+1,m+1,n) = im(l,m,n);
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
                
                med1=sort(window1);
                imB3(i,j,k) = mean(med1);               
            end
        end
    end
    out1 = sprintf('(%s)-Meanfilter3.jpg',filename);
   
    imwrite(uint8(imB3),out1);
    
end