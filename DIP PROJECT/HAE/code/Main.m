filefolder = 'Dataset\';
imagefiles = dir(fullfile(filefolder,'*.*'));
nfiles = length(imagefiles);


for i=3:14
    tic
    filename = imagefiles(i).name;
    fullfilename = fullfile(filefolder,filename);
    Ic = imread(fullfilename);
    im = rgb2ycbcr(Ic);
    omega=0.95;
    [rows, column, depth] = size(im);
    Y = im(:,:,1);
    Cb = im(:,:,2);
    Cr = im(:,:,3);
    
    Ymin = min(Y(:));
    Ymax = max(Y(:));
    [pixelCounts, grayLevels] = imhist(Y);
    hist = pixelCounts / numel(Y);
    %bright Region Estimation
    [mu,numerator,denominator] = (LumaThres(Ymin,Ymax,hist)); %Luma Thresholding(includes some bright region without fog too)
    [muDash,sigmaDash] = GaussianApprox(uint8(mu),Ymax,hist);%Gaussian Approximation(removes above regions, only fog)
    
    Glow = (muDash-sigmaDash);
    Ghigh = (muDash+sigmaDash);
    
    %end
    %color Similarity Estimation
    ChromaDiff = (colorSimilarityEstimation(Cb,Cr));
    deltaMax = max(ChromaDiff(:));
    Ylength = Ymax-Ymin+1;
    %2D histogran construction for color and luminosity model
    H2d = zeros(Ylength,deltaMax+1);
    
    for x=1:rows
        for y=1:column
            ha = 0;
            hb = 0;
            if Y(x,y)>=Glow && Y(x,y)<= Ghigh
                ha = Y(x,y) - Glow;
                hb = ChromaDiff(x,y);
                H2d(ha+1,hb+1) = H2d(ha+1,hb+1) + 1;
            end
        end
    end
    %2D histogran construction end
    
    %Maximum BIN selection
    H2dMax = max(H2d(:));
    %Maximum BIN SelectionENd
    %Color Similarity Estimation ENd
    
    % Airlight Color Computation
    Accumulator = zeros(1,3);
    
    for x=1:rows
        for y=1:column
            ha = 0;
            hb = 0;
            if Y(x,y)>=Glow && Y(x,y)<= Ghigh
                ha = Y(x,y) - Glow;
                hb = ChromaDiff(x,y);
                if H2d(ha+1,hb+1) == H2dMax
                    for c=1:3
                        Accumulator(c) = Accumulator(c) + double(Ic(rows,column,c));
                    end
                end
            end
        end
    end
    
    Ac = Accumulator/H2dMax;
    
    
    atm = (repmat(reshape(Ac, [1, 1, 3]), rows, column));%convert 1x3 to rowxcolumnx3
    Dark = MDCP(Ic); %calculation of Median DARK CHANNEL PRIOR to use in I = R*alpha + A(1-alpha);
    transmission = 1 - omega*(Dark/max(max(Dark)));
    xx = repmat(transmission,[1 1 3]);
    
    R = (double(Ic) - atm.*(1-xx))./xx;
    out1 = sprintf('Results/%s',filename);
    imwrite(uint8(R),out1);
    toc
end
