# NigDet
Nighttime vehicle detection

# Test

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

8, `cd ./mscnn-master/examples/kitti_car/add2pool123_stage2`, run `trian_mscnn.sh` to train a model.
