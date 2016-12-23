function chromaDiff = colorSimilarityEstimation(Cb,Cr)

[row,column] = size(Cb);
chromaDiff = zeros(row,column);
for i = 1:row
    for j=1:column
        chromaDiff(i,j) = abs(double(Cb(i,j)) - double(Cr(i,j)));
    end
end
end
