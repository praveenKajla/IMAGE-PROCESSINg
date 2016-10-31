im = imread('foggy1.jpg');
 A = zeros(size(im));
 omega = 0.95;
[rows, column, depth] = size(im);
impad = zeros(rows+2,column+2);
Dark = zeros(rows,column);
I = zeros(rows,column);
A = zeros(size(im));
for l=1:rows
    for m=1:column
        impad(l+1,m+1) = min(im(l,m,:));
    end
end

for i=1:rows
    for j=1:column
        window = zeros(9,1);
        inc =1;
        for x=1:3
            for y=1:3
                window(inc) = impad(i+x-1,j+y-1);
                inc = inc+1;
            end
        end 
        
        Dark(i,j) = min(window);       
    end
end
n_pixels = rows*column;
n_search_pixels = floor(n_pixels * 0.01);
Dark_Vec = reshape(Dark,n_pixels,1);
image_vec = reshape(im,n_pixels,3);
[Dark_Vec, indices] = sort(Dark_Vec, 'descend');
atmosphere = zeros(1,3);
for ind=1:n_search_pixels
    atmosphere = atmosphere + double(image_vec(indices(ind),:)); %using  if Mx=1 then for c=0 to 2 if Ic>Ac then Ac=Ic 
end
atm = atmosphere / n_search_pixels;
atmo = repmat(reshape(atm, [1, 1, 3]), rows, column);%convert 1x3 to rowxcolumnx3

transmission = 1 - omega*(Dark/max(max(Dark)));
xx = repmat(transmission,[1 1 3]);
R = (double(im) - atmo.*(1-xx))./xx;

imwrite(uint8(R),'degoffy.jpg');