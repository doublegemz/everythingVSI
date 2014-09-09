function swapf(srcFiles,position)
%look at bottom of this image
filename = strcat('images/',srcFiles(position).name);
A = imread(filename);
HSV = rgb2hsv(A(200,70,:));
HSVtops = [];
for i = 1:length(srcFiles)
    fn = strcat('images/',srcFiles(i).name);
    B = imread(fn);
    HSVtops = [HSVtops,rgb2hsv(B(20,70,:))];
end
HSV = HSV(:,:,1);
HSVtops = HSVtops(:,:,1);

[dist,index]=min(abs(HSVtops-HSV));

%disp(HSV);
%disp(HSVtops);
%disp(HSVtops(index));
%disp(index);
matchfile = strcat('images/',srcFiles(index).name);
undersrc = position+36;
undersrcfile = strcat('images/',srcFiles(undersrc).name);
tempfile = 'images/tempfile.jpg';
%disp(matchfile);
%disp(undersrcfile);
%disp(tempfile);
if ~strcmp(matchfile,undersrcfile)
    movefile(undersrcfile,tempfile);
    movefile(matchfile,undersrcfile);
    movefile(tempfile,matchfile);
    delete(tempfile);
end




