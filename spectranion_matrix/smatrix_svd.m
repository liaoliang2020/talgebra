function [SU, SS, SV] = smatrix_svd(smatrix, tsize, unit_quaternionic_square_roots)
	% this function computes the SVD of a spectranion matrix, which is a 
	% t-matrix with quaternion entities  
	assert(isequal(class(smatrix), 'quaternion') );

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(smatrix) - numel(tsize) == 2 | ndims(smatrix) - numel(tsize) == 1 | ndims(smatrix) - numel(tsize) == 0);

	
	%-----------------
	if nargin == 2
		unit_quaternionic_square_roots = quaternionize(i);
	end

	assert(isequal(class(unit_quaternionic_square_roots), 'quaternion' ));
	assert(size(unit_quaternionic_square_roots, 1) == 1);

	assert(norm(compact(unit_quaternionic_square_roots .* unit_quaternionic_square_roots ...
		-  quaternionize((-1) * ones(size(unit_quaternionic_square_roots)))), 'fro') < 1e-8); 


	row_num = size(smatrix, numel(tsize) + 1);
	col_num = size(smatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);


	% Compute the fourier transform over quaternions
	for mode_index = 1: numel(tsize)
		smatrix = ffts(smatrix, [], mode_index, unit_quaternionic_square_roots); 
	end

	smatrix = reshape(smatrix, [prod(tsize), row_num, col_num]);


	for slice_index = 1: prod(tsize)
		slice_tmatrix = smatrix(slice_index, :, :);
		slice_tmatrix = reshape(slice_tmatrix, row_num, col_num);

		[QU, QS, QV] = qmatrix_svd(slice_tmatrix);

		if slice_index == 1
			SU = quaternionize(zeros([prod(tsize), size(QU) ] )) ;
			SS = quaternionize(zeros([prod(tsize), size(QS) ] ));
			SV = quaternionize(zeros([prod(tsize), size(QV) ] ));
		end%if slice_index == 1

		SU(slice_index, :, :) = QU;
		SS(slice_index, :, :) = QS;
		SV(slice_index, :, :) = QV;

	end

	SU = reshape(SU, [tsize, size(SU, 2), size(SU, 3) ] );
	SS = reshape(SS, [tsize, size(SS, 2), size(SS, 3) ] );
	SV = reshape(SV, [tsize, size(SV, 2), size(SV, 3) ] );

	assert(isequal(class(SU), 'quaternion'));
	assert(isequal(class(SS), 'quaternion'));
	assert(isequal(class(SV), 'quaternion'));
	


	% compute inverse fourier transform over quaternions
	for mode_index = 1: numel(tsize)
		SU = iffts(SU, [], mode_index, unit_quaternionic_square_roots);	
		SS = iffts(SS, [], mode_index, unit_quaternionic_square_roots);	
		SV = iffts(SV, [], mode_index, unit_quaternionic_square_roots);
	end



end