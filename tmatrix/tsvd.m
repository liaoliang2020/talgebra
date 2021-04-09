function [TU, TS, TV] = tsvd(tmatrix, tsize, transform, itransform)
	% checked
	% checked

	if nargin == 2
		transform = @fft;
		itransform = @ifft;
	end

	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);



	for i = 1: numel(tsize)
		tmatrix = transform(tmatrix, [], i);		
	end

	
	transformed_size = size(tmatrix);
	transformed_tsize = transformed_size(1: numel(tsize) )

	tmatrix = reshape(tmatrix, prod(transformed_tsize), row_num,  col_num);




	%for i = 1: prod(tsize)
	for i = 1: prod(transformed_tsize)
		
		slice_tmatrix = squeeze(tmatrix(i, :, :));
		slice_tmatrix = reshape(slice_tmatrix, row_num, col_num);


		[U, S, V] = svd(slice_tmatrix, 'econ');		

		if i == 1
			TU = zeros([prod(transformed_tsize), size(U) ] );
			TS = zeros([prod(transformed_tsize), size(S) ] );
			TV = zeros([prod(transformed_tsize), size(V) ] );
		end
		TU(i, :, :) = U;
		TS(i, :, :) = S;
		TV(i, :, :) = V;
	
	end

	TU = reshape(TU, [transformed_tsize, size(TU, 2), size(TU, 3) ] );
	TS = reshape(TS, [transformed_tsize, size(TS, 2), size(TS, 3) ] );
	TV = reshape(TV, [transformed_tsize, size(TV, 2), size(TV, 3) ] );

	for i = 1: numel(transformed_tsize)
		TU = itransform(TU, [], i);
		TS = itransform(TS, [], i);
		TV = itransform(TV, [], i);		
	end

	if norm(imag(TU(:))) < 1e-6
		TU = real(TU);
	end

	if norm(imag(TS(:))) < 1e-6
		TS = real(TS);
	end

	if norm(imag(TV(:))) < 1e-6
		TV = real(TV);
	end


end