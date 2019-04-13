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
#import torch.utils.data.distributed
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