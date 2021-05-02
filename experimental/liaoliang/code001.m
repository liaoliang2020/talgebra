function code001
	clear; close all; clc;
	for given_rank = 1:29
		code001_sub(given_rank);
	end

end

function code001_sub(given_rank)
	
	img_row_num = 256;
	img_col_num = 256;
	tsize = [3, 3];

	current_dir = pwd;
	neighborhood_table = load_data(current_dir, 'row_num00256_col_num00256_inception_neighorhood_layer001_single_index');
	
	img = imread('cameraman.tif');

	assert(isequal(size(img), [img_row_num, img_col_num]));

	img = [img(:); uint8(0)];
	img = img(neighborhood_table);
	img = reshape(img, [tsize, img_row_num, img_col_num]);

	img = double(img); 
	

	N = 3;
	W = fourier_matrix(N);
	inv_W = pinv(W);

	fft_tsize = [N, N];


	for i = 1: numel(tsize)
		img = tensormultiplication(W, img, i);
		if norm(imag(img(:))) < 1e-6
			img = real(img);
		end 
	end

	img = reshape(img, [prod(fft_tsize), img_row_num, img_col_num]);

	approximation = [];
	for slice_index = 1: prod(fft_tsize)
		slice = reshape(img(slice_index, :, :), [img_row_num, img_col_num]);
		[U, S, V] = svd(slice, 'econ');

		S_hat = zeros(img_row_num, 1);
		S_hat(1: given_rank) = 1;

		slice_approximation = U *  S * diag(S_hat) * V';

		approximation = [approximation, slice_approximation(:)];  
	end

	approximation = permute(approximation, [2, 1]);
	approximation = reshape(approximation, [fft_tsize, img_row_num, img_col_num]);

	for i = 1: numel(fft_tsize)
		approximation = tensormultiplication(inv_W, approximation, i);
		if norm(imag(approximation(:))) < 1e-6
			approximation = real(approximation);
		end 
	end

	PSNR_value = PSNR(double(imread('cameraman.tif')), squeeze(approximation(1, 1, :, :)));

	file_name_full = sprintf('%s\\%s', pwd, 'code001.txt');
	fid = fopen(file_name_full, 'a+');
	fprintf('code001 \t rank = %d \t PSNR_value = %f \n', given_rank, PSNR_value);
	fprintf(fid, 'code001 \t rank = %d \t PSNR_value = %f \n', given_rank, PSNR_value);
	fclose(fid);

end