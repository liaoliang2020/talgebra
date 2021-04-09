function TwoDimension_PCA
	clear; close all; clc;

	class_num = 40;
	training_img_num_per_class = 5;


	current_dir  = pwd;
	data_dir = sprintf('%s\\%s', current_dir, 'matlab_orl');
	

	training_set = [];
	for class_index = 1: class_num
		for img_index = 1: training_img_num_per_class
			file_name = sprintf('s%d_%d.mat', class_index, img_index);
			img = load_data(data_dir, file_name);

			training_set = [training_set, img(:)];			
		end
	end

	% whos training_set;

	mean_sample = mean(training_set, 2);
	% mean_sample = reshape(mean_sample, 112, 92);
	% imshow(mean_sample, [])


	img_row_num = 112;
	img_col_num = 92;

	training_set_no_mean = training_set - repmat(mean_sample, 1, size(training_set, 2));

	G = 0;
	for i = 1: size(training_set_no_mean, 2)
		disp(i);
		img = training_set_no_mean(:, i);
		img = reshape(img, img_row_num, img_col_num);

		G = G + img * img';
	end

	[U, S, V] = svd(G);
	whos U
	whos S
	whos V
	









end


% function subprog(index)
% 	fprintf('%05d\n', index);
% end