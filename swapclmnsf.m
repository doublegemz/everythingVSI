function swapclmnsf(srcFiles)
    colAvgRGBs = [];
    cols = [];
    for i = 1:1:36
        col = [];
        colAvgRGB = [];
        for j = i:36:432
           %make column
           filename = strcat('images/',srcFiles(j).name);
           I = imread(filename);
           I = imcrop(I,[0 0 120 200]);
           col = vertcat(col,I);  
        end
        col = imcrop(col,[0 0 120 2400]);
        cols = [cols,col];
        %find avg rgb value of column
        colAvgRGB = mean(mean(col));
        colAvgRGBs = [colAvgRGBs,colAvgRGB];
        
        %figure,imshow(col);
    end
    %sort columns
    
    for m=1:1:34
        aSum = [];
        currentCol = colAvgRGBs(:,m,:);
        
        a1 = abs(colAvgRGBs(:,:,1)-currentCol(:,:,1));
        a2 = abs(colAvgRGBs(:,:,2)-currentCol(:,:,2));
        a3 = abs(colAvgRGBs(:,:,3)-currentCol(:,:,3));
        aSum = a1+a2+a3;
        subsample = aSum(:,m+1:36);
        %check to see which value in sample is min
        [dist,index]=min( subsample );
        trueindex = index + m;
        
        %switch those columns in colAvgRGBs
        swapWith = m+1;
        colAvgRGBs(:,[trueindex swapWith],:) = colAvgRGBs(:,[swapWith trueindex],:);
        strt = 120*(swapWith-1);
        endcol = strt+120;
        strt2 = 120*(trueindex-1);
        endcol2 = strt2+120;
        disp(strt);
        disp(endcol);
        disp(strt2);
        disp(endcol2);
        cols(:,[strt:endcol strt2:endcol2],:)=cols(:,[strt2:endcol2 strt:endcol],:);
        %disp(size(cols));
    end

    figure
    for k=1:1:36
        RGBv = colAvgRGBs(:,k,:);
        clor = roundn(RGBv/255,-1);
        rectangle('Position',[k*20,0,20,20],'FaceColor',clor);
    end
    
    set(gcf,'Color',[1,1,1]);
    figure,imshow(cols);
    
