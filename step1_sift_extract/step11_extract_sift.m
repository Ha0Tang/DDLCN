tic
clear all;close all;clc

original_image_dir = './datasets/mnist';
feature_dir = './step1_sift_extract/sift_feature/mnist';
extr_sift(original_image_dir, feature_dir);

toc