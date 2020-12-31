function [TV, TD] = teig(tmatrix, tsize)
	% This function generalizes the canonical MATLAB function eig
	% 20190121


	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = reshape(tmatrix, prod(tsize), row_num, col_num);

	V_size = 0;
	D_size = 0;
	for i = 1: prod(tsize)
		slice = reshape(tmatrix(i, :, :), row_num, col_num);
		[V, D] = eig(slice);

		if i == 1
			V_size = size(V);
			D_size = size(D);			

			TV = zeros([prod(tsize), prod(V_size) ]);
			TD = zeros([prod(tsize), prod(D_size) ]);
		end

		TV(i, :) = V(:);
		TD(i, :) = D(:);
	end

	TV = reshape(TV, [tsize, V_size]);
	TD = reshape(TD, [tsize, D_size]);

	for i = 1: numel(tsize)
		TV = ifft(TV, [], i);
		TD = ifft(TD, [], i);				
	end






end