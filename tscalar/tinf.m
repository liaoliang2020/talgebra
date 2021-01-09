function infimum_tscalar =  tinf(tscalar1, tscalar2)
	% this function returns the infimum  of the set of two self-conjugate t-scalars 
	assert(isequal(size(tscalar1), size(tscalar2)));
	assert(is_self_conjugate(tscalar1) & is_self_conjugate(tscalar2));

	tscalar1 = real(fftn(tscalar1));
	tscalar2 = real(fftn(tscalar2));


	pos = find(tscalar1 - tscalar2 >= 0);
	pos_remained = setdiff(1: prod(size(tscalar1)), pos);

	infimum_tscalar = zeros(numel(pos) + numel(pos_remained), 1);
	infimum_tscalar(pos) = tscalar2(pos);
	infimum_tscalar(pos_remained) = tscalar1(pos_remained); 

	infimum_tscalar = reshape(infimum_tscalar, size(tscalar2));
	infimum_tscalar = ifftn(infimum_tscalar);



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