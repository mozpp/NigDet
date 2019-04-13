# NigDet
Nighttime vehicle detection施工中

# Test

# Train your own dataset
1, blob1.m 获取候选灯光.

2, blob_bbox.m: generate a txt file 'blob_stats.txt', to store feature and label for each blob_candi.

3, crop_blob.m: crop each blob_candi according to 'blob_stats.txt', and store.

4, `cd ./classify_pytorch` to train a classifier to classify blob.  
###4.1 main.py to train.  
###4.2 test.py to test and store result 'blob_crop_result.txt'.
