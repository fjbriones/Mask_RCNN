#!/bin/bash
source env/bin/activate
python3 samples/coco/coco.py train \
	--dataset=/home/ferdie/Datasets/MSCOCO \
	--model=imagenet \
	--logs=logs17 \
	--gpu=0 \
	--flip_augmentation=0.25 \
	--rotate_augmentation=False \
	--epochs=20 \
	--learning_rate=0.001 \
	--weight_bbox_loss=1.0 \
	--weight_segm_loss=1.0
python3 samples/coco/coco.py evaluate \
	--dataset=/home/ferdie/Datasets/MSCOCO \
	--model=last \
	--logs=logs17 \
	--gpu=0 \
	--flip_augmentation=0.25 \
	--rotate_augmentation=False \
	--epochs=20 \
	--learning_rate=0.001 \
	--weight_bbox_loss=1.0 \
	--weight_segm_loss=1.0