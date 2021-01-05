function my_denoise000
	% clear; close all; clc;

	row_num = 256;
	col_num = 256;

	tsize = [3 3];
	noise_level = 0.3;


	img_noise_free = imread('cameraman.tif');
	img_noise_free = double(img_noise_free);
	assert(isequal(size(img_noise_free), [row_num, col_num]));
	

	img_noise_free = img_noise_free / max(img_noise_free(:));

	img_with_noise = img_noise_free + noise_level * rand(size(img_noise_free));

	
	figure; imshow([img_noise_free, img_with_noise], []);
	

	current_dir = pwd;
	save_dir = current_dir;
	save_data(save_dir, 'img_with_noise', 'img_with_noise');

	sprintf('img_with_noise saved\n');



end