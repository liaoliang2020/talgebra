function [trans_matrix, pinv_trans_matrix] = get_transforms(tsize, ftsize)
	
	assert(isequal(tsize', tsize(:)));
	assert(isequal(ftsize', ftsize(:)));

	assert(isequal(size(tsize), size(ftsize) ));
	assert(all(ftsize - tsize >= 0));

	for i = 1: numel(tsize)
		A = fourier_matrix(ftsize(i) );
		%A = fliplr(A);	
		%A = circshift(A, [0, -6]); 
		A = A(:, 1: tsize(i));
		pinvA = pinv(A);

		trans_matrix{i} = A;
		pinv_trans_matrix{i} = pinvA;
	end
	

end