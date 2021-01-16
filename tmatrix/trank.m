function generalized_rank = trank(tmatrix, tsize)
	% Modified by Liang Liao. 20200116 
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num]);

	generalized_rank = zeros(tsize);
	for i = 1: prod(tsize)
		slice = reshape(tmatrix(i, :, :), row_num, col_num);

		slice(abs(slice) < 1e-8) = 0;

		generalized_rank(i) = rank(slice);
	end

	generalized_rank = ifftn(generalized_rank);

end



	% checked on 20190210
	% created by liaoliang 20190121
	% this function computes the generalized rank of a t-matrix




% the following function uses TSVD to computes the generalized rank of a t-matrix
% this function is equivalent to the above function but the above function is more efficient 
% this function is slow but okay 
% function generalized_rank = trank(tmatrix, tsize)

% 	assert(isequal(tsize', tsize(:)));	  
% 	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

% 	[~, TS, ~] = tsvd(tmatrix, tsize);

% 	TS = tdiag(TS, tsize);

% 	tdimension = size(TS, numel(tsize) + 1);

% 	assert(isequal(size(TS), [tsize, tdimension]));
	
% 	for i = 1: numel(tsize)
% 		TS = fft(TS, [], i);		
% 	end

% 	TS = abs(TS);

% 	pos = find(TS(:) < 1e-6);

% 	TS(:) = 1;
% 	TS(pos) = 0;

% 	for i = 1: numel(tsize)
% 		TS = ifft(TS, [], i);		
% 	end

% 	TS = reshape(TS,  prod(tsize), [] );
% 	assert(isequal(size(TS), [prod(tsize), tdimension]))
	
% 	generalized_rank = 0;
% 	for i = 1: tdimension
% 		generalized_rank = generalized_rank + TS(:, i);
% 	end

% 	generalized_rank = reshape(generalized_rank, tsize);

% end



