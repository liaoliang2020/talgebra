function nonnegative_tscalar =  tmin(tscalar1, tscalar2)
	% this function returns the min nonnegative t-scalar 
	assert(isequal(size(tscalar1), size(tscalar2)));
	assert(istnonnegative(tscalar1) & istnonnegative(tscalar2));

	tscalar1 = fftn(tscalar1);
	tscalar2 = fftn(tscalar2);


	pos = find(tscalar1 - tscalar2 >= 0);
	pos_remained = setdiff(1: prod(size(tscalar1)), pos);

	nonnegative_tscalar = zeros(numel(pos) + numel(pos_remained), 1);
	nonnegative_tscalar(pos) = tscalar2(pos);
	nonnegative_tscalar(pos_remained) = tscalar1(pos_remained); 

	nonnegative_tscalar = reshape(nonnegative_tscalar, size(tscalar2));
	nonnegative_tscalar = ifftn(nonnegative_tscalar);



	% if all(reshape((fftn(tscalar1) - fftn(tscalar2)) > 0, 1, []))   
	% 	nonnegative_tscalar = tscalar2;
	% 	return;
	% end

	% if all(reshape((fftn(tscalar2) - fftn(tscalar1)) > 0, 1, []))   
	% 	nonnegative_tscalar = tscalar1;
	% 	return;
	% end

	% nonnegative_tscalar = NaN;
	
end