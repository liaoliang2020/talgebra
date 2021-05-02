function code_step002_interpolation
	%clear; close all; clc;

	row_num = 256;
	col_num = 256;
	tsize = [3, 3];
	interped_tsize = [9, 9];
	interped_tsize = [3 3 3 3];

	current_dir = pwd;

	interped_tensorzied_img_fft = load_data(current_dir, 'interped_tensorzied_img_fft');
	assert(isequal(size(interped_tensorzied_img_fft), [interped_tsize, row_num, col_num]));

	interped_tensorzied_img_fft =  reshape(interped_tensorzied_img_fft, [prod(interped_tsize), row_num, col_num]);

	
	original_img = imread('cameraman.tif');
	original_img = double(original_img);


	file_name_full = sprintf('%s\\%s', pwd, 'code_step002_interpolation_median.txt');
	fid = fopen(file_name_full, 'a+');
	

	for given_rank = 1: 200
		% disp(given_rank);


		for i = 1: prod(interped_tsize)
			slice = interped_tensorzied_img_fft(i, :, :);
			slice = reshape(slice, row_num, col_num);

			[U, S, V] = svd(slice, 'econ');

			S_hat = zeros(row_num, 1);
			S_hat(1: given_rank) = 1;
			approximation = U * S * diag(S_hat) * V'; 

			if i == 1
				approximation_container = zeros(numel(approximation),  prod(interped_tsize));
			end

			approximation_container(:, i) = approximation(:);

		end

		approximation_container = permute(approximation_container, [2, 1]);
		approximation_container = reshape(approximation_container, [interped_tsize, row_num, col_num]);

		for i = 1: numel([3 3 3 3])
			approximation_container = ifft(approximation_container, [], i);
		end


		approximation_container = reshape(approximation_container, [3*3 3*3, row_num, col_num]);

		approximation_container = approximation_container(5, 5, :, :);

		
		% approximation_container = reshape(approximation_container, [prod(interped_tsize), row_num, col_num]);
		% approximation_container = median(approximation_container, 1);
		% approximation_container = reshape(approximation_container, row_num, col_num);
			

		PSNR_value = PSNR(approximation_container(:), original_img(:));

		fprintf('rank = %d \t PSNR_value = %f \n', given_rank, PSNR_value);
		%fprintf(fid, 'rank = %d \t PSNR_value = %f \n', given_rank, PSNR_value);
		
	
	end%for given_rank = 1: 200

	fclose(fid);
	


end