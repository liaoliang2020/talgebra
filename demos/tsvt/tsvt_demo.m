function tsvt_demo
	clear; close all; clc;
	row_num = 256;
	col_num = 256;
	tsize = [3, 3];
	
	compound_cameraman_img = load('compound_img_layer001');
	compound_cameraman_img = struct2cell(compound_cameraman_img);
	compound_cameraman_img = compound_cameraman_img{1};
	isa(compound_cameraman_img, 'double');

	assert(isequal(size(compound_cameraman_img), [tsize, row_num, col_num]) );

	inceptional_spatial_slice = squeeze(compound_cameraman_img(1, 1, :, :));

	% figure; imshow(inceptional_spatial_slice, []); 
	% title('original inception spatial slice');

	[~, TS, ~] = tsvd(compound_cameraman_img, tsize);

	inception_lambda = TS(:, :, 1, 1); 
	

	each_max = reshape(abs(fftn(inception_lambda)), 1, []);

	quan_level = 5;
	nd_grid_value = zeros(prod(tsize), quan_level); 
	 
	for i = 1: prod(tsize)
		nd_grid_value(i, :) = linspace(0, each_max(i), quan_level);
		% whos liaoliang
		% pause(1);
	end 

	[X1, X2, X3, X4, X5, X6, X7, X8, X9] = ndgrid(nd_grid_value(1, :), ...
												nd_grid_value(2, :), ...
												nd_grid_value(3, :), ...
												nd_grid_value(4, :), ...
												nd_grid_value(5, :), ...
												nd_grid_value(6, :), ...
												nd_grid_value(7, :), ...
												nd_grid_value(8, :), ...
												nd_grid_value(9, :) ); 

	X = [X1(:), X2(:), X3(:), X4(:), X5(:), X6(:), X7(:), X8(:), X9(:)];
	
	X = permute(X, [2, 1]);
	X = abs(X);
	Y  = [];
	for i = 1: prod(tsize)
		idem_element = idempotent(i, tsize);
		Y = [Y, idem_element(:)];
	end

	for i = 1: size(X, 2)
		parameters = X(:, i);
		tau = Y * parameters;
		tau = reshape(tau, tsize);
		
		approximation = tsvt(compound_cameraman_img, tau, tsize);
		approximation = real(approximation);
		fprintf('tau is representaed by vector: \t');
		disp(reshape(parameters, 1, []));

		approximation_inception_slice = approximation(1, 1, :, :);
		approximation_inception_slice = squeeze(approximation_inception_slice);
		imshow([inceptional_spatial_slice, approximation_inception_slice], []);
		%pause(0.1);

	end
end