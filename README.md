# NigDet
Nighttime vehicle detection
https://github.com/mozpp/NigDet

# Test
1, download dataset and model. 链接: https://pan.baidu.com/s/17AEdluJq0hOByEHuc6Hnsg 提取码: 6dqp 

2, `./mscnn-master/examples/kitti_car/run_mscnn_detection.m`.

# Train your own dataset
1, tools/blob1.m 获取候选灯光.

2, tools/blob_bbox.m: generate a txt file 'blob_stats.txt', to store feature and label for each blob_candi.

3, tools/crop_blob.m: crop each blob_candi according to 'blob_stats.txt', and store.

4, `cd ./classify_pytorch` to train a classifier to classify blob.  
> 4.1 run main.py to train.  
> 4.2 run test.py to test and store result 'blob_crop_result.txt'.

5, save vehicle highlight mask.  
> 5.1 run `tools/build_BlobDataset.m` or `tools/build_BlobDataset_Ver2.m` to save classify result to txt 'blob_statsVer1.txt'.  
> 5.2 run `tools/settle_jan30.m` or `tools/settle_.m` to store vehicle highlight mask.

6, `tools/concat4ch.py` concat mask to original image.

7, follow `mscnn-master` to compile caffe and generate training label file.

8, `cd ./mscnn-master/examples/kitti_car/mscnn-p123s2-subcls3`, run `trian_mscnn.sh` to train a model.
