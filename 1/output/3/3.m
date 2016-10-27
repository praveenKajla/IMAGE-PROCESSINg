for gamma=[0.50 0.10 2.0 4.0 ] 
    gammaCorrection = inv(gamma)
    images = imread('C:\Users\praveen\Desktop\imgp\1\Input Images\11.png');
    [rows column depth] = size(images);
    if depth==3
        images = rgb2gray(images);
    end
    output = zeros(rows,column);
    for l=1:rows
        for m=1:column
            output(l,m) = uint8(255*((double(images(l,m))/255)^gamma));
           
        end
    end
    out = sprintf('11withgamma-%f.png',gamma)
    imwrite(uint8(output),out)
end                