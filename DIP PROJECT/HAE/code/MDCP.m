function Dark = MDCP(im)

[rows, column, ~] = size(im);
Dark = zeros(rows,column);
I = zeros(rows,column);
Imin = zeros(rows,column);
for l=1:rows
    for m=1:column
        Imin(l,m) = min(im(l,m,:));
    end
end
impad = padarray(Imin, [7 7], Inf);
for i=1:rows
    for j=1:column
        window = impad(i:i+14,j:j+14);       
        Dark(i,j) = min(window(:));       
    end
end

end