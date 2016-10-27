filefolder = 'C:\Users\praveen\Desktop\imgp\8\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);

for i=[3]
  
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im2 = imread(fullfilename);
    
    im = im2double(rgb2gray(im2));
    [rows,column,depth] = size(im);
    G = zeros(size(im));
    x = [1,0;0,-1];
    y = [0,1;-1,0];
    Ix = zeros(size(im));
    Iy = zeros(size(im));
    TF = 0.1;%thresholding factor
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
                Ix(l,m) = sx;
                Iy(l,m) = sy;
                G(l,m,n) = sqrt(sx.^2 + sy.^2);
               
            end
        end
    end
    %thresholding
    Lmax = max(max(G));
    Lmin = min(min(G));
    l = TF*(Lmax-Lmin)+Lmin;
    Lbw = max(G,l.*ones(size(G)));
    [n,m] = size(Lbw);
    L_temp = zeros(size(Lbw));
    for i=2:n-1
        for j=2:m-1
            if Lbw(i,j)> l
                X=[-1,0,+1;-1,0,+1;-1,0,+1];
                Y=[-1,-1,-1;0,0,0;+1,+1,+1];
                neigh = [Lbw(i-1,j-1) Lbw(i-1,j) Lbw(i-1,j+1);Lbw(i,j-1) Lbw(i,j) Lbw(i,j+1);Lbw(i+1,j) Lbw(i+1,j) Lbw(i+1,j+1)];
                thetaX = [Ix(i,j)/G(i,j),-Ix(i,j)/G(i,j)];
                thetaY = [Iy(i,j)/G(i,j),-Iy(i,j)/G(i,j)];
                ZI=interp2(X,Y,neigh,thetaX,thetaY);
                if Lbw(i,j) >= ZI(1) && Lbw(i,j) >= ZI(2)
                    L_temp(i,j)=Lmax;
                else
                    L_temp(i,j)=Lmin;
                end
            else
                L_temp(i,j)=Lmin;
            end
        end
    end
    
  
    imshow(L_temp);
 
        
    
    
end