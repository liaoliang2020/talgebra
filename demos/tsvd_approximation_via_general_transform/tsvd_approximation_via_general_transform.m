function tsvd_approximation_via_general_transform
	clear; close all; clc;

	row_num = 256;
	col_num = 256;
	tsize = [3, 3];
	N = 3;

	img = load_data(pwd, 'compound_img_layer001.mat');
	img = double(img);

	assert(isequal(size(img), [tsize, row_num, col_num]));

	img1 = img;
	img2 = img;
	img3 = img;

	for i = 1: ndims(tsize)
		img1 = fft(img1, [], i);
	end

	img1 = reshape(img1, [prod(tsize), row_num, col_num]);

	img2 = reshape(img2, [prod(tsize), row_num, col_num]);
	img2 = fft(img2, [], 1);

	assert(isequal(size(img1), size(img2)));

	%-------------------------
	A = fourier_matrix(N * N);
	A_inv = inv(A);

	
	img3 = reshape(img3, [prod(tsize), row_num * col_num]);
	
	for index = 1: (row_num * col_num)
		tscalar_vectorized = img3(:, index);	
		
		tscalar_vectorized([1 2 3 6 5 4 7 8 9]) = A * tscalar_vectorized([1 2 3 6 5 4 7 8 9]);
		img3(:, index) = tscalar_vectorized;

	end


	img3 = reshape(img3, [prod(tsize), row_num, col_num]);

	for my_rank = 1: 200
		img1_approx = approximation(img1, my_rank);
		img2_approx = approximation(img2, my_rank);
		img3_approx = approximation(img3, my_rank);

		%-------------------
		img1_approx = reshape(img1_approx, [tsize, row_num, col_num]);
		for i = 1: ndims(tsize)
			img1_approx = ifft(img1_approx, [], i);			
		end
		

		img2_approx = reshape(img2_approx, [prod(tsize), row_num, col_num]);
		img2_approx = ifft(img2_approx, [], 1);
		img2_approx = reshape(img2_approx, [tsize, row_num, col_num]);
		
		img3_approx = reshape(img3_approx, [prod(tsize), row_num * col_num]);
		
		for i = 1: (row_num * col_num)
			tscalar_vectorized = img3_approx(:, i);
			tscalar_vectorized([1 2 3 6 5 4 7 8 9]) = A_inv * tscalar_vectorized([1 2 3 6 5 4 7 8 9]);

			img3_approx(:, i) = tscalar_vectorized;
		end

		img3_approx = reshape(img3_approx, [tsize, row_num, col_num]);

		assert(isequal(size(img1_approx), size(img2_approx)));
		assert(isequal(size(img1_approx), size(img3_approx)));
		
		psnr1 = PSNR(img(:), img1_approx(:));
		psnr2 = PSNR(img(:), img2_approx(:));
		psnr3 = PSNR(img(:), img3_approx(:));
	
		disp([my_rank, psnr1, psnr2, psnr3]);

	end

end

function img_approx = approximation(img, my_rank)
	[slice_num, row_num, col_num] = size(img);

	max_rank = min(row_num, col_num);	
	S_hat = zeros(max_rank, 1);
	S_hat(1: my_rank) = 1;
	S_hat = diag(S_hat);

	img_approx = [];
	for i = 1: slice_num
		myslice = img(i, :, :);
		myslice = reshape(myslice, row_num, col_num);
		[U, S, V] = svd(myslice, 'econ');

		approx = U * S * S_hat * V';  
		img_approx = [img_approx, approx(:)];
	end

	img_approx = reshape(img_approx, [row_num, col_num, slice_num]);
	img_approx = permute(img_approx, [3, 1, 2]);

end