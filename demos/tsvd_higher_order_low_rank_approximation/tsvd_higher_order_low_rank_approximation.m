function tsvd_higher_order_low_rank_approximation
	clear; close all; clc;
	row_num = 256;
	col_num = 320;
	fra_num = 3;
	tsize = [1, fra_num]; 

	max_canonical_rank = min(row_num, col_num);

	rbg_img = imread('football.jpg');
	rbg_img = double(rbg_img);

	assert(isequal(size(rbg_img), [row_num, col_num, fra_num]));
	rbg_img_tmatrix = permute(rbg_img, [3, 1, 2]);
	rbg_img_tmatrix = reshape(rbg_img_tmatrix, [tsize, row_num, col_num]) ;	

	[X1, X2, X3] = ndgrid(0: max_canonical_rank, 0: max_canonical_rank, 0: max_canonical_rank);

	generalized_ranks = [X1(:), X2(:), X3(:)];
	% generalized_ranks = flipud(generalized_ranks);

	for i = 1: size(generalized_ranks, 1)
		delta = generalized_ranks(i, :);
		delta = reshape(delta, tsize);
		delta = fftn(delta);

		approximation = tsvd_approximation(rbg_img_tmatrix, delta, tsize);
		
		approximation_rank = trank(approximation, tsize);

		approximation = reshape(approximation, [fra_num, row_num, col_num]);
		
		approximation = permute(approximation, [2, 3, 1]);
		

		title_notation1 = sprintf('Generalized rank is [%f, %f, %f]', approximation_rank(1), approximation_rank(2), approximation_rank(3));
		title_notation2 = sprintf('PSNR is %f', PSNR(approximation(:), rbg_img(:), 'real') );
		title_notation = sprintf('%s,  %s', title_notation1, title_notation2);

		imshow(uint8(approximation)); 
		title(title_notation); 
		pause(0.1);
		
	end




	
end