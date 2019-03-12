clear all;
img_dir='/media/b3-542/Library/moz/night_det/dataset/images/';
image_list = dir([img_dir '*.jpg']); 
nImg=length(image_list);
usetime=0;
for k = 2807: 2807
x_ori=imread([img_dir image_list(k).name]); 
x_g=rgb2gray(x_ori);
%x_g=im2double(x_g);
xg_ini=sum(sum(x_g));
[hight width ch]=size(x_ori);
hight_thre=uint8(zeros(hight,width));
hight_thre(0.3*hight:0.9*hight,:)=1;
thre1=imresize(hight_thre,[hight,width]);
thre1=thre1/255;
tic;
%x_g=x_g.*thre1;
for k1=1:20
x_g=x_g-mean(mean(x_g));
% if sum(sum(x_g))/xg_ini<0.05,
%     break
% end
end
x_g=im2bw(x_g,0.2);
imwrite(x_g,['/media/b3-542/Library/moz/night_det/result/temp/' '002807.png']);
pertime=toc;
usetime=usetime+pertime;
avgtime=usetime/k;
end
avgtime
% img2=imread([save_path '000001.png']);
% max(max(img2))