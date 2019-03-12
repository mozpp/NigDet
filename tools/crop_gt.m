image_dir = '/media/b3-542/Library/moz/night_det/dataset/images/';
image_dir1 = '/media/b3-542/Library/moz/night_det/result/blob_tail_light/';
image_list = dir([image_dir '*.jpg']);
% file0=fopen('GT_subclass.txt','w');
% file1=fopen('GT_subclass.txt','a');
file=fopen('/media/b3-542/Library/moz/night_det/dataset/GT5576.txt');
while ~feof(file)
    tline=fgetl(file);
    tline=textscan(tline,'%s ') ;
    car_num=str2double(tline{1,1}{2,1});
    img_name=tline{1,1}{1,1};
    x_ori=imread([image_dir img_name '.jpg']);
    %     test_name='000016';
    %     if img_name==test_name,
    %         x_ori=imread([image_dir test_name '.jpg']);
    %
    [hight width ch]=size(x_ori);
    i=1;index=1;
    while i<car_num*4
        x_i=int32(str2double(tline{1,1}{2+i,1}));
        y_i=int32(str2double(tline{1,1}{3+i,1}));
        w_i=int32(str2double(tline{1,1}{4+i,1}));
        h_i=int32(str2double(tline{1,1}{5+i,1}));
        i=i+4;
        if x_i<1,x_i=1;end
        if y_i<1,y_i=1;end
        x_irb=x_i+w_i-1;
        if x_i+w_i-1>width,x_irb=width;end
        y_irb=y_i+h_i-1;
        if y_irb>hight,y_irb=hight;end
        img_crop=x_ori(y_i:y_irb,x_i:x_irb,:);
        [hight1 width1 ch1]=size(img_crop);
        if hight1>width1,
            pad_size=round((hight1-width1)/2);
            img_crop=padarray(img_crop,[0 pad_size]);
        else
            pad_size=round((width1-hight1)/2);
            img_crop=padarray(img_crop,[pad_size 0]);
        end
        imwrite(img_crop,['../result/gt_crop/' img_name '_' num2str(index) '.jpg']);
        index=index+1;
    end
    
    %     end
end