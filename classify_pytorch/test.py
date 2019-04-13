import argparse
import os
import shutil
import time

import torch
import torch.nn as nn
import torch.nn.parallel
import torch.backends.cudnn as cudnn
import torch.distributed as dist
import torch.optim
import torch.utils.data
import torch.utils.data.distributed
import torchvision.transforms as transforms
import torchvision.datasets as datasets
import torchvision.models as models
import resnet as model2
from PIL import Image
from torchvision.transforms import Compose, CenterCrop, ToTensor, Scale
from torch.autograd import Variable
import resnet_my
from os import listdir
import re
from skimage import io
import math
import numpy

checkpoint=torch.load("blob_crop_model_best.pth.tar")
print checkpoint['epoch']
model=resnet_my.__dict__['resnet50']()
model = torch.nn.DataParallel(model).cuda()
model.load_state_dict(checkpoint['state_dict'])
model.eval()
cudnn.benchmark=True
normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406],
                                     std=[0.229, 0.224, 0.225])

file0=open('blob_crop_result.txt','w')
file0=open('blob_crop_result.txt','a')
input_path='/media/b3-542/LIBRARY/moz/dataset/blob_stats_crop/val/'
total_num=0;
thre=[0.5];tp=numpy.zeros(len(thre))

for target in os.listdir(input_path):
    d = os.path.join(input_path, target)
    if not os.path.isdir(d):
        continue

    for filename in os.listdir(d):
        path = '{0}/{1}/{2}'.format(input_path,target, filename)
        img = Image.open(path).convert('RGB')
        transform = transforms.Compose([
            transforms.Scale(224),
            transforms.CenterCrop(224),
            transforms.ToTensor(),
            normalize
        ])
        img = transform(img)
        # print img
        # img=Variable(img)
        # img=Compose([Scale(224),CenterCrop(224)])(img)
        # input = Variable(ToTensor()(img)).view(1, -1, img.size[1], img.size[0])  # pull to batch_size=1
        input = Variable(img).view(1, -1, 224, 224)
        output = model(input)
        # print output.data
        predicted = output.data
        exp_score0 = math.exp(predicted[0, 0]);
        exp_score1 = math.exp(predicted[0, 1]);
        prob = exp_score1 / (exp_score0 + exp_score1);
        file0.write('{0} {1}\n'.format(filename, prob))
        for i in range(len(thre)):
            if target == str(int(prob > thre[i])):
                tp[i] = tp[i] + 1
        total_num = total_num + 1
print tp
print total_num
for i in range(len(thre)):
    print ' accuracy: ', (float(tp[i]) / total_num)