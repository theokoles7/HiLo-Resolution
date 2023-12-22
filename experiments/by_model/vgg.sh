#!/bin/bash

###############################################################
# RUN JOBS ON ALL DATASETS AND KERNELS USING THE VGG 16 MODEL #
###############################################################
# This will run the experiments with the following default arguments:
#   - Batch size:       64
#   - Epochs:          200
#   - Learning Rate:     0.1
#   - Kernel Size:       3

# For each dataset...
for dataset in cifar10 cifar100 imagenet mnist
do
    # kernel...
    for distribution in cauchy gaussian gumbel laplace poisson
    do
        # and kernel type...
        for kernel_type in $(seq 1 14);
        do
            # Clear the terminal
            clear

            # Run an experiment with the VGG 16 model
            python main.py vgg \
                $dataset \
                --kernel_type $kernel_type \
                $distribution

            # Push logs and output to repository
            git add ./logs/*
            git add ./output/*
            git commit -m "$(date +'%F %T'): vgg | $dataset | $distribution (Type $kernel_type)"
            git push origin main

        done
    done
done