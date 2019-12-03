#!/bin/bash
GPU_ID=1
FLIP_AUGMENTATION_VAL=0.75
ROTATE_AUGMENTATION_VALS=( 0.25 0.75 )
EPOCHS=( 10 20)
BBOX_LOSS_WEIGHTS=( 1.0 2.0)
SEGM_LOSS_WEIGHTS=( 1.0 2.0)
i=0
for rotate_augmentation in "${ROTATE_AUGMENTATION_VALS[@]}" 
do
	for epoch in "${EPOCHS[@]}"
	do
		for bbox_weight in "${BBOX_LOSS_WEIGHTS[@]}"
		do
			for segm_weight in "${SEGM_LOSS_WEIGHTS[@]}"
			do
				((i+=1))
				echo "i: $i"
				echo "FLIP AUGMENTATION PROBABILITY: $FLIP_AUGMENTATION_VAL"
				echo "ROTATE AUGMENTATION PROBABILITY: $rotate_augmentation"
				echo "EPOCHS: $epoch"
				echo "SEGMENTATION LOSS WEIGHT: $segm_weight"
				echo "BOUNDING BOX LOSS WEIGHT: $bbox_weight"
				echo "Training the model"

				python3 samples/coco/coco.py train /
					--dataset=/home/ferdie/Datasets/MSCOCO /
					--model=coco /
					--logs=logs${i} /
					--gpu=$GPU_ID /
					--flip_augmentation=$FLIP_AUGMENTATION_VAL /
					--rotate_augmentation=$rotate_augmentation /
					--epochs=$epoch /
					--weight_bbox_loss=$bbox_weight /
					--weight_segm_loss=$segm_weight > logs/log${i}_train.txt

				echo "Evaluating the model"

				python3 samples/coco/coco.py evaluate /
					--dataset=/home/ferdie/Datasets/MSCOCO /
					--model=last /
					--logs=logs${i} /
					--gpu=$GPU_ID /
					--flip_augmentation=$FLIP_AUGMENTATION_VAL /
					--rotate_augmentation=$rotate_augmentation /
					--epochs=$epoch /
					--weight_bbox_loss=$bbox_weight /
					--weight_segm_loss=$segm_weight > logs/log${i}.txt

			done
		done
	done
done