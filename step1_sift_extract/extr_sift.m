function extr_sift(img_dir, data_dir)

addpath('sift_function');

gridSpacing = 6;
patchSize = 16;
maxImSize = 300;
nrml_threshold = 1;

[database, lenStat] = CalculateSiftDescriptor(img_dir, data_dir, gridSpacing, patchSize, maxImSize, nrml_threshold);
