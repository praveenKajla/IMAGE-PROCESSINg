filefolder = 'C:\Users\praveen\Desktop\imgp\1\Input Images\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);
count = 0;
for i=[3 14 16 17 18 19 20 21 ]
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename);
    [rows column depth] = size(im);
     if(depth==3)
        im = rgb2gray(im); % convert to gray scale if it is color image
     end
    
G1=bitget(im,1); % get bitplane 1
G2=bitget(im,2); % get bitplane 2
G3=bitget(im,3); % get bitplane 3
G4=bitget(im,4); % get bitplane 4
G5=bitget(im,5); % get bitplane 5
G6=bitget(im,6); % get bitplane 6
G7=bitget(im,7); % get bitplane 7
G8=bitget(im,8); % get bitplane 8

figure(i);
subplot(4,4,[1 8]);imshow(im);title('Original 8 bit image');  %subplot original Image
subplot(4,4,9);imshow(logical(G1));title('Bitplane 1');      %Show Bitplane 1 
subplot(4,4,10);imshow(logical(G2));title('Bitplane 2');     %Show Bitplane 2
subplot(4,4,11);imshow(logical(G3));title('Bitplane 3');     %Show Bitplane 3
subplot(4,4,12);imshow(logical(G4));title('Bitplane 4');     %Show Bitplane 4
subplot(4,4,13);imshow(logical(G5));title('Bitplane 5');     %Show Bitplane 5
subplot(4,4,14);imshow(logical(G6));title('Bitplane 6');     %Show Bitplane 6
subplot(4,4,15);imshow(logical(G7));title('Bitplane 7');     %Show Bitplane 7
subplot(4,4,16);imshow(logical(G8));title('Bitplane 8');     %Show Bitplane 8
end