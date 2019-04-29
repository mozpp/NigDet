import cv2
import numpy as np
from matplotlib import pyplot as plt
import os
from PIL import Image
import numpy as np
import pandas as pd

image_dir = '/media/b3-542/Library/moz/night_det/dataset/images_train/';
image_dir2= '/media/b3-542/Library/moz/night_det/result/blob_jan30_xgt/';

img_list = os.listdir(image_dir)
img_list.sort()
print img_list[0:3]

for img_name in img_list:
    #print img_name
    img_name_temp = img_name.split('.')
    # print ('{0}{1}.jpg'.format(image_dir, img_name_temp[0]))
    img = cv2.imread('{0}{1}.jpg'.format(image_dir, img_name_temp[0]))
    
    img2 = cv2.imread('{0}{1}.png'.format(image_dir2, img_name_temp[0]), cv2.COLOR_BGR2GRAY)
    final = np.zeros((img.shape[0],img.shape[1],4),dtype=np.uint8)
    for i in range(3):
        final[:,:,i]=img[:,:,i]
    final[:,:,3]=img2[:,:]
    #final=cv2.flip(final,1)
    #print final.shape
    pritn max(max(final))
    #cv2.imshow('11',img2)
    cv2.waitKey()
    img_name=img_name.split('.')[0];
    save_path = ('/media/b3-542/Library/moz/night_det/result/concat/blob_jan30_xgt_1ov255_train/{0}.png'.format(img_name))
    #cv2.imwrite(save_path,final)
