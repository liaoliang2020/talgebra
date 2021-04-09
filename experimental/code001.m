function code001
	clear; close all; clc;
	for given_rank = 1: 200
		code001_sub(given_rank);
	end

end

function code001_sub(given_rank)
	%clear; close all; clc;
	current_dir = pwd;
	neighborhood_table = load_data(current_dir, 'central_neighorhood_layer001_single_index');
	
	img = imread('cameraman.tif');

	assert(isequal(size(img), [256, 256]));

	img = [img(:); uint8(0)];
	img = img(neighborhood_table);
	img = reshape(img, [3, 3, 256, 256]);

	img = double(img); 
	% whos img;

	N = 25;
	W = fourier_matrix(N);
	%W = circshift(W, [0, 1]);
	W = W(:, 1:3);
	%W(:, 3) = conj(W(:, 2));

	inv_W = pinv(W);


	for i = 1: 2
		img = tensormultiplication(W, img, i);
		if norm(imag(img(:))) < 1e-6
			img = real(img);
		end 
	end

	% whos img;
	% pause;

	img = reshape(img, [N * N, 256, 256]);

	approximation = [];
	for slice_index = 1: N * N 
		slice = reshape(img(slice_index, :, :), [256, 256]);
		% whos slice;
		% pause;
		[U, S, V] = svd(slice, 'econ');

		S_hat = zeros(256, 1);
		S_hat(1: given_rank) = 1;

		slice_approximation = U *  S * diag(S_hat) * V';

		approximation = [approximation, slice_approximation(:)];  
	end

	approximation = permute(approximation, [2, 1]);

	approximation = reshape(approximation, [N, N, 256, 256]);



	for i = 1: 2
		approximation = tensormultiplication(inv_W, approximation, i);
		if norm(imag(approximation(:))) < 1e-6
			approximation = real(approximation);
		end 
	end

	%disp(given_rank);
	% whos approximation;
	% norm(imag(approximation(:)))

	% imshow(squeeze(approximation(2, 2, :, :)), []);

	% pause(1);

	PSNR_value = PSNR(double(imread('cameraman.tif')), squeeze(approximation(2, 2, :, :)));

	fprintf('rank = %d \t PSNR_value = %f \n', given_rank, PSNR_value);

end