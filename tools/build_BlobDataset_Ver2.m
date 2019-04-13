
file1=fopen('../tool/val_HK2.txt');
train_list={};
i0=1;
while ~feof(file1)
    tline=fgetl(file1);
    tline=textscan(tline,'%s') ;
    train_list{i0,1}=tline{1,1}{1,1};
    
    i0=i0+1;
end
fclose(file1);

%[idx,~]=find(strcmp(resnet_result , '000001_1.jpg'));
try
    rmdir('result','s');
catch
    ;
end
attr_num=14;
file=fopen('HK_areaBias5.txt');
while ~feof(file)
    tline=fgetl(file);
    tline=textscan(tline,'%s ') ;
    car_num=str2double(tline{1,1}{2,1});
    img_name=tline{1,1}{1,1};
    
    if find(strcmp(train_list,img_name))
        i=1;index=1;
        while i<car_num*attr_num
            class=int32(str2double(tline{1,1}{2+i,1}));
            save_dir=['result/' num2str(class) '/'];
            if (~exist(save_dir)), mkdir(save_dir); end
            str=[save_dir img_name '_' num2str(index) '.txt'];
            %         fd=fopen(str,'w+');
            fd=fopen(str,'a+');
            
            
            for i1=1:(attr_num-5),
                write0=str2double(tline{1,1}{6+i1+i,1});
                fprintf(fd,'%f\n',write0);
            end
            fclose(fd);
            
            i=i+attr_num;
            %if class==3,
            
            %end
            
            index=index+1;
        end
    end
    
end