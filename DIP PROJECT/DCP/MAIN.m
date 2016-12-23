filefolder = 'Dataset\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);


for i=3:14
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    im = imread(fullfilename);
    omega = 0.95;
    [rows, column, depth] = size(im);
    Dark = MDCP(im);
    %atmosphere
    n_pixels = rows*column;
    n_search_pixels = floor(n_pixels * 0.1);
    Dark_Vec = reshape(Dark,n_pixels,1);
    image_vec = reshape(im,n_pixels,3);
    [Dark_Vec, indices] = sort(Dark_Vec, 'descend');
    atmosphere = zeros(1,3);
    for ind=1:n_search_pixels
        atmosphere = atmosphere + double(image_vec(indices(ind),:)); %using  if Mx=1 then for c=0 to 2 if Ic>Ac then Ac=Ic
    end
    atm = atmosphere / n_search_pixels;
    atmo = repmat(reshape(atm, [1, 1, 3]), rows, column);%convert 1x3 to rowxcolumnx3
    %end
    
    %transmission
    transmission = 1 - omega*(Dark/max(max(Dark)));
    
    xx = repmat(transmission,[1 1 3]);
    R = (double(im) - atmo.*(1-xx))./xx;
     out1 = sprintf('Results/%s',filename);
    imwrite(uint8(R),out1);
end