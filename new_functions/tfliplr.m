function result = tfliplr(tmatrix, tsize)
	% This function generates the matlab function fliplr
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num]);
	result = tmatrix(:, :, col_num:-1:1);
	result = reshape(result, [tsize, row_num, col_num]); 


	% for i = 1: numel(tsize)
	% 	tmatrix = fft(tmatrix, [], i);
	% end

	% tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num ]);

	% result = zeros([prod(tsize), row_num, col_num]);
	% for i = 1: prod(tsize)
	% 	slice = reshape(tmatrix(i, :, :), row_num, col_num);
	% 	result(i, :, :) = fliplr(slice);
	% end

	% result = reshape(result, [tsize, row_num, col_num]);
	% for i = 1: numel(tsize)
	% 	result = ifft(result, [], i);
	% end
	% disp('ss');

end