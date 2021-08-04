function [TU, TS, TV] = tsvd(tmatrix, tsize)
	% checked
	% checked

	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);



	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	
	tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num]);

	for i = 1: prod(tsize)
		slice_tmatrix = squeeze(tmatrix(i, :, :));
		slice_tmatrix = reshape(slice_tmatrix, row_num, col_num);


		[U, S, V] = svd(slice_tmatrix, 'econ');		

		if i == 1
			TU = zeros([prod(tsize), size(U) ] );
			TS = zeros([prod(tsize), size(S) ] );
			TV = zeros([prod(tsize), size(V) ] );
		end%if i == 1

		TU(i, :, :) = U;
		TS(i, :, :) = S;
		TV(i, :, :) = V;
	
	end%for i = 1: prod(tsize)

	TU = reshape(TU, [tsize, size(TU, 2), size(TU, 3) ] );
	TS = reshape(TS, [tsize, size(TS, 2), size(TS, 3) ] );
	TV = reshape(TV, [tsize, size(TV, 2), size(TV, 3) ] );

	if norm(imag(TU(:))) < 1e-6
		TU = real(TU);
	end

	if norm(imag(TS(:))) < 1e-6
		TS = real(TS);
	end

	if norm(imag(TV(:))) < 1e-6
		TV = real(TV);
	end
	


	%for i = 1: numel(transformed_tsize)
	for i = 1: numel(tsize)
		TU = ifft(TU, [], i);
		TS = ifft(TS, [], i);
		TV = ifft(TV, [], i);		
	end



end