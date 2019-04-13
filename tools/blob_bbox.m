clear all;
image_dir = '/media/b3-542/Library/moz/night_det/dataset/images/';
blob_dir='/media/b3-542/Library/moz/night_det/result/blob_without_xgt/';
image_list = dir([image_dir '*.jpg']); 
nImg=length(image_list);
file0=fopen('blob_stats.txt','w');
file1=fopen('blob_stats.txt','a');
for k = 1 : nImg
    x_ori=imread([image_dir image_list(k).name]);
    x_blob=imread([blob_dir image_list(k).name]);
    [hight width]=size(x_blob);
    ratio=hight/360;
    [B,num]=bwlabel(x_blob,4);%将Image转化成label矩阵%
    
    stats = regionprops(B, {'Area','BoundingBox', 'ConvexHull', 'MajorAxisLength', ...
        'MinorAxisLength', 'Eccentricity', 'Centroid'});
%     imshow(x_ori);
    num=0;
    for i=1:length(stats)
        if stats(i).Area>20*ratio, num=num+1; end
    end
    tline=regexp(image_list(k).name,'\.','split');
    img_name=tline{1,1};
    fprintf(file1,'%s %d',img_name,num);
    
    x_gt=zeros(hight,width);
    file=fopen('/media/b3-542/Library/moz/night_det/subclass/subclass_pytorch/GT_subclass_new.txt');
    while ~feof(file)                                      % 判断是否为文件末尾
        tline=fgetl(file);                                 % 从文件读行
        tline=textscan(tline,'%s ') ;
        car_num=str2double(tline{1,1}{2,1});
        img_name0=tline{1,1}{1,1};
        if img_name0==img_name
            i=1;
            while i<car_num*5
                class=int32(str2double(tline{1,1}{2+i,1}));
                x_i=(str2double(tline{1,1}{3+i,1}));
                y_i=(str2double(tline{1,1}{4+i,1}));
                w_i=(str2double(tline{1,1}{5+i,1}));
                h_i=(str2double(tline{1,1}{6+i,1}));
                i=i+5;
                if x_i<1,x_i=1;end
                if y_i<1,y_i=1;end
                x_irb=x_i+w_i-1;
                if x_i+w_i-1>width,x_irb=width;end
                y_irb=y_i+h_i-1;
                if y_irb>hight,y_irb=hight;end
                if class==1,
                x_gt(y_i:y_irb,x_i:x_irb)=1;
                elseif class==2,
                x_gt(y_i:y_irb,x_i:x_irb)=2;
                else
                x_gt(y_i:y_irb,x_i:x_irb)=0;
                end
            end
        end
    end
    fclose(file);
    
    for i=1:length(stats)
        if stats(i).Area>20*ratio,
            %         temp2 = box(i).BoundingBox;
            %         rectangle('position', temp2, 'edgecolor', 'r', 'LineWidth', 1);
            %cen_y=round(stats(i).Centroid(1));cen_x=round(stats(i).Centroid(2));
            cen_x=round(stats(i).BoundingBox(1)+stats(i).BoundingBox(3));
            cen_y=round(stats(i).BoundingBox(2)+stats(i).BoundingBox(4));
            if cen_x>width,cen_x=width;end
            if cen_y>hight,cen_y=hight;end
            cen_class=x_gt(cen_y,cen_x);
            fprintf(file1,' %d %d %d %d %d %.2f %.4f %.4f %.4f %.2f %.2f',cen_class,round(stats(i).BoundingBox),...
                stats(i).Area*ratio*ratio,stats(i).MajorAxisLength*ratio,stats(i).MinorAxisLength*ratio,...
                stats(i).Eccentricity,stats(i).Centroid*ratio);
        end
    end
    fprintf(file1,'\n');
%     handle=gca;%gcf
%     saveas(handle,['result/temp/' image_list(k).name '.jpg']);
%     clear handle;
    %pause(0.5);
end
