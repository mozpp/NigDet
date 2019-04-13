file0=fopen('result.txt');
resnet_result={};
i0=1;
while ~feof(file0)
    tline=fgetl(file0);
    tline=textscan(tline,'%s ') ;
    resnet_result{i0,1}=tline{1,1}{1,1};
    resnet_result{i0,2}=tline{1,1}{2,1};
    i0=i0+1;
end
fclose(file0);

file1=fopen('../train1.txt');
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
file=fopen('blob_statsVer1.txt');
while ~feof(file)
    tline=fgetl(file);
    tline=textscan(tline,'%s ') ;
    car_num=str2double(tline{1,1}{2,1});
    img_name=tline{1,1}{1,1};
    
    if find(strcmp(train_list,img_name))
        i=1;index=1;
        while i<car_num*11
            class=int32(str2double(tline{1,1}{2+i,1}));
            [idx,~]=find(strcmp(resnet_result , [img_name '_' num2str(index) '.jpg']));
            resnet_class=str2num(resnet_result{idx,2});
            save_dir=['result/' num2str(class) '/'];
            if (~exist(save_dir)), mkdir(save_dir); end
            str=[save_dir img_name '_' num2str(index) '.txt'];
            %         fd=fopen(str,'w+');
            fd=fopen(str,'a+');
            
            fprintf(fd,'%d\n',resnet_class);
            for i1=1:6,
                write0=str2double(tline{1,1}{6+i1+i,1});
                fprintf(fd,'%f\n',write0);
            end
            fclose(fd);
            
            i=i+11;
            %if class==3,
            
            %end
            
            index=index+1;
        end
    end
    
end