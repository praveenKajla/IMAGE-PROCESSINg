
function [mu,numerator,denominator] = LumaThres(ymin,ymax,histogram)

numerator = 0;
denominator = 0;
for y=ymin:ymax
    numerator = numerator + histogram(y+1)*double(y);%here y+1 used cause histogram x index is from 1-256 but y values are from 0-255 
    denominator = denominator + histogram(y+1);
end
mu = numerator/denominator;
end
