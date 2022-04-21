function [SU, SS, SV] = smatrix_svd(smatrix, tsize)
	% this function computes the SVD of a spectranion matrix, which is a 
	% t-matrix with quaternion entities  

	assert(isequal(class(smatrix), 'quaternion') );

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(smatrix) - numel(tsize) == 2 | ndims(smatrix) - numel(tsize) == 1 | ndims(smatrix) - numel(tsize) == 0);

	row_num = size(smatrix, numel(tsize) + 1);
	col_num = size(smatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);


	% Compute the fourier transform over quaternions
	for i = 1: numel(tsize)
		smatrix = qtensormultiplication(quaternionize(fourier_matrix(tsize(i))), smatrix, i);		
	end

	smatrix = reshape(smatrix, [prod(tsize), row_num, col_num]);


	for i = 1: prod(tsize)
		slice_tmatrix = smatrix(i, :, :);
		slice_tmatrix = reshape(slice_tmatrix, row_num, col_num);

		[QU, QS, QV] = qmatrix_svd(slice_tmatrix);

		if i == 1
			SU = quaternionize(zeros([prod(tsize), size(QU) ] )) ;
			SS = quaternionize(zeros([prod(tsize), size(QS) ] ));
			SV = quaternionize(zeros([prod(tsize), size(QV) ] ));
		end%if i == 1

		SU(i, :, :) = QU;
		SS(i, :, :) = QS;
		SV(i, :, :) = QV;

	end

	SU = reshape(SU, [tsize, size(SU, 2), size(SU, 3) ] );
	SS = reshape(SS, [tsize, size(SS, 2), size(SS, 3) ] );
	SV = reshape(SV, [tsize, size(SV, 2), size(SV, 3) ] );

	assert(isequal(class(SU), 'quaternion'));
	assert(isequal(class(SS), 'quaternion'));
	assert(isequal(class(SV), 'quaternion'));
	


	% compute inverse fourier transform over quaternions
	for i = 1: numel(tsize)
		SU = qtensormultiplication(quaternionize(inv(fourier_matrix(tsize(i) ))), SU, i);	
		SS = qtensormultiplication(quaternionize(inv(fourier_matrix(tsize(i) ))), SS, i);	
		SV = qtensormultiplication(quaternionize(inv(fourier_matrix(tsize(i) ))), SV, i);
	end



end