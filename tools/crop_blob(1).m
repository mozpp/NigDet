%image_dir = '/media/b3-542/Library/moz/night_det/dataset/images/';
image_dir = '/media/b3-542/Library/moz/night_det/dataset/Hong-Kong-nighttime-vehicle-dataset0/val2/';
%image_dir1 = '/media/b3-542/Library/moz/night_det/result/blob_tail_light/';
image_list = dir([image_dir '*.jpg']);
attr_num=6;
file=fopen('../blob_stats/HK_areaBias5.txt');
pad1=48;
mkdir('../result/blob_stats_crop/temp/0/');
mkdir('../result/blob_stats_crop/temp/1/');
mkdir('../result/blob_stats_crop/temp/2/');
while ~feof(file)
    tline=fgetl(file);
    tline=textscan(tline,'%s ') ;
    car_num=str2double(tline{1,1}{2,1});
    img_name=tline{1,1}{1,1};
    try
    x_ori=imread([image_dir img_name '.jpg']);
    %     test_name='000016';
    %     if img_name==test_name,
    %         x_ori=imread([image_dir test_name '.jpg']);
    %
    [hight width ch]=size(x_ori);
    i=1;index=1;
    while i<car_num*attr_num
        
        class=int32(str2double(tline{1,1}{2+i,1}));
        x_i=int32(str2double(tline{1,1}{3+i,1}));
        y_i=int32(str2double(tline{1,1}{4+i,1}));
        w_i=int32(str2double(tline{1,1}{5+i,1}));
        h_i=int32(str2double(tline{1,1}{6+i,1}));
        area=int32(str2double(tline{1,1}{7+i,1}));
        i=i+attr_num;
        
%         if double(y_i)/hight<0.5 && area<10,
%             pad1=36;
%         end
        max_wh=max(w_i,h_i);
        max_wh=max_wh+pad1;
        y_min=round(y_i+h_i/2-max_wh/2);
        y_max=round(y_i+h_i/2+max_wh/2);
        x_min=round(x_i+w_i/2-max_wh/2);
        x_max=round(x_i+w_i/2+max_wh/2);
        if y_min<1,y_min=1;end
        if x_min<1,x_min=1;end
        %x_irb=x_i+w_i-1+pad1*2;
        if x_max>width,x_max=width;end
        %y_irb=y_i+h_i-1+pad1;
        if y_max>hight,y_max=hight;end
        img_crop=x_ori(y_min:y_max,x_min:x_max,:);
%         [hight1 width1 ch1]=size(img_crop);
%         if hight1>width1,
%             pad_size=round((hight1-width1)/2);
%             img_crop=padarray(img_crop,[0 pad_size]);
%         elseif hight1<width1,
%             pad_size=round((width1-hight1)/2);
%             img_crop=padarray(img_crop,[pad_size 0]);
%         end
        %img_crop=imresize(img_crop,224);
        if class==1,
            imwrite(img_crop,['../result/blob_stats_crop/temp/1/' img_name '_' num2str(index) '.png']);    
        elseif class==0,
            imwrite(img_crop,['../result/blob_stats_crop/temp/0/' img_name '_' num2str(index) '.png']);    
        else
            imwrite(img_crop,['../result/blob_stats_crop/temp/2/' img_name '_' num2str(index) '.png']);    
        end
        index=index+1;
    end
    catch
        ;
    end
    
    %     end
end