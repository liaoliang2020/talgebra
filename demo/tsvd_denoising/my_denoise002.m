function my_denoise002
	clear; close all; clc;
	current_dir = pwd;	


	row_num = 256;
	col_num = 256;

	tsize = [3, 3]; 

	current_dir = pwd;
	neighbor_info_dir = current_dir;


	
	noisy_img = load_data(current_dir, 'img_with_noise');
	assert(isequal(size(noisy_img), [row_num, col_num]));

	noisy_img = [noisy_img(:); 0];

	neighborhood_table_file_name = 'inception_neighorhood_layer001_single_index';
	neighorhood_table = load_data(neighbor_info_dir, neighborhood_table_file_name);
	

	assert(isequal(size(neighorhood_table), [1, prod([tsize, row_num, col_num])]) );


	noisy_img_extended =  noisy_img(neighorhood_table); 
	noisy_img_extended = reshape(noisy_img_extended, [tsize, row_num, col_num]);
	
	
	[TU, TS, TV] = tsvd(noisy_img_extended, tsize);
	
	TS = reshape(TS, [prod(tsize), row_num * col_num] );
	max_generalized_singular_value = TS(:, 1);
	max_generalized_singular_value = reshape(max_generalized_singular_value, tsize);

	max_thresholding_value = abs(fftn(max_generalized_singular_value));
	max_thresholding_value = max(max_thresholding_value(:));



	noisy_img(end) = [];
	noisy_img = reshape(noisy_img, row_num, col_num);


	img_noise_free = imread('cameraman.tif');
	img_noise_free = double(img_noise_free);
	img_noise_free = img_noise_free / max(img_noise_free(:));


	for tau = linspace(0, max_thresholding_value, 1000)
		% disp(tau);
		generalized_tau = tau * E_T(tsize);

		approximation = tsvt(noisy_img_extended, generalized_tau, tsize);
		assert(isequal(size(approximation), [tsize, row_num, col_num]));

		approximation = reshape(approximation, [prod(tsize), row_num, col_num]);
		approximation_slice = approximation(1, :, :);
		approximation_slice = reshape(approximation_slice, row_num, col_num);

		PSNR_value = PSNR(approximation_slice(:), img_noise_free(:), 'real');
		
		fprintf('tau  = %f \t PSNR = %f dB\n', tau, PSNR_value);

		imshow([img_noise_free, noisy_img, approximation_slice], []);
		pause(1);
	
	end


end
