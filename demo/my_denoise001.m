function my_denoise001
	% clear; close all; clc;
	row_num = 256;
	col_num = 256;

	tsize = [3, 3]; 

	current_dir = pwd;
	neighbor_info_dir = sprintf('%s\\%s', current_dir, 'central_neighborhood_256x256');


	
	noisy_img = load_data(current_dir, 'img_with_noise');
	assert(isequal(size(noisy_img), [row_num, col_num]));

	noisy_img = [noisy_img(:); 0];


	neighorhood_table = load_data(neighbor_info_dir, 'neighorhood_layer001_single_index');
	% whos neighorhood_table;

	assert(isequal(size(neighorhood_table), [1, prod([tsize, row_num, col_num])]) );


	noisy_img_extended =  noisy_img(neighorhood_table); 
	noisy_img_extended = reshape(noisy_img_extended, [tsize, row_num, col_num]);
	
	
	[TU, TS, TV] = tsvd(noisy_img_extended, tsize);
	
	TS = reshape(TS, [prod(tsize), row_num * col_num] );
	max_generalized_singular_value = TS(:, 1);
	max_generalized_singular_value = reshape(max_generalized_singular_value, tsize);

	liaoliang = abs(fftn(max_generalized_singular_value));
	liaoliang = max(liaoliang(:));



	noisy_img(end) = [];

	for tau = linspace(0, liaoliang, 1000)
		% disp(tau);
		generalized_tau = tau * E_T(tsize);

		approximation = tsvt(noisy_img_extended, generalized_tau, tsize);
		assert(isequal(size(approximation), [tsize, row_num, col_num]));

		approximation = reshape(approximation, [prod(tsize), row_num, col_num]);
		approximation_slice = approximation(0.5 * (prod(tsize) + 1), :, :);
		approximation_slice = reshape(approximation_slice, row_num, col_num);

		PSNR_value = PSNR(approximation_slice(:), noisy_img(:), 'real');
		
		fprintf('tau  = %f \t PSNR = %f dB\n', tau, PSNR_value);

		imshow(approximation_slice, []);
		pause(1);

		
	
	end


end
