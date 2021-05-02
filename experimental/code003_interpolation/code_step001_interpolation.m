function code_step001_interpolation
	%clear; close all; clc;

	row_num = 256;
	col_num = 256;
	tsize = [3, 3];
	interped_tsize = [9, 9];

	current_dir = pwd;
	neighborhood_table = load_data(current_dir, 'central_neighorhood_layer001_single_index');
	img = imread('cameraman.tif');

	assert(isequal(size(img), [row_num, col_num]));

	img_ext = [img(:); uint8(0)];
	tensorzied_img = img_ext(neighborhood_table);
	tensorzied_img = reshape(tensorzied_img, [prod(tsize), row_num * col_num]);
	tensorzied_img = double(tensorzied_img); 
	
	[X, Y] = meshgrid(1: 3);
	[X_new, Y_new] = meshgrid(1:0.25:3);


	for i = 1: (row_num * col_num)
		disp([i, row_num * col_num]);
		V = reshape(tensorzied_img(:, i), tsize);
		V_new = interp2(X, Y, V, X_new, Y_new, 'linear');

		if i == 1
			interped_tensorzied_img = zeros(numel(V_new), row_num * col_num);
		end
		interped_tensorzied_img(:, i) = V_new(:);
	 
	end%for i = 1: (row_num * col_num)

	interped_tensorzied_img = reshape(interped_tensorzied_img, [interped_tsize, row_num, col_num]);

	interped_tensorzied_img = reshape(interped_tensorzied_img, [[3 3 3 3], row_num, col_num]);

	save_data('d:\', 'interped_tensorzied_img', 'interped_tensorzied_img');


	for i = 1: numel([3 3 3 3])
		interped_tensorzied_img = fft(interped_tensorzied_img, [], i);
	end

	save_data(pwd, 'interped_tensorzied_img_fft', 'interped_tensorzied_img');

	
end