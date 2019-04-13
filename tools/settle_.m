file0=fopen('blob_stats_result.txt');
stats_class_result={};
i0=1;
while ~feof(file0)
    tline=fgetl(file0);
    tline=textscan(tline,'%s ') ;
    stats_class_result{i0,1}=tline{1,1}{1,1};
    stats_class_result{i0,2}=tline{1,1}{2,1};
    i0=i0+1;
end
fclose(file0);

file1=fopen('blob_final.txt','w');
file1=fopen('blob_final.txt','a');
file=fopen('blob_statsVer1.txt');
img_dir='/media/b3-542/Library/moz/night_det/result/blob_without_xgt/';
while ~feof(file)
    tline=fgetl(file);
    tline=textscan(tline,'%s ') ;
    car_num=str2double(tline{1,1}{2,1});
    img_name=tline{1,1}{1,1};
    x_blob=imread([img_dir img_name '.jpg']);
    [hight width]=size(x_blob);
    x_blob_final=uint8(zeros(hight,width));
    fprintf(file1,'%s %d',img_name,car_num);
    i=1;index=1;
    while i<car_num*11
        %class=int32(str2double(tline{1,1}{2+i,1}));
        x_i=int32(str2double(tline{1,1}{3+i,1}));
        y_i=int32(str2double(tline{1,1}{4+i,1}));
        w_i=int32(str2double(tline{1,1}{5+i,1}));
        h_i=int32(str2double(tline{1,1}{6+i,1}));
        i=i+11;
        
        [idx,~]=find(strcmp(stats_class_result , [img_name '_' num2str(index) '.txt']));
        class=str2num(stats_class_result{idx,2});
        if x_i<1,x_i=1;end
        if y_i<1,y_i=1;end
        x_irb=x_i+w_i-1;
        if x_i+w_i-1>width,x_irb=width;end
        y_irb=y_i+h_i-1;
        if y_irb>hight,y_irb=hight;end
        if class==1 ||class==2,
        x_blob_final(y_i:y_irb,x_i:x_irb)=1;
        end
        fprintf(file1,' %d %d %d %d %d',class,x_i,y_i,w_i,h_i);
        index=index+1;
    end        
    fprintf(file1,'\n');
    img=(x_blob_final.*x_blob);
    imwrite(img,['/media/b3-542/Library/moz/night_det/result/blob_stats/' img_name '.jpg']);
end