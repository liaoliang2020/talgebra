function myreslt = tpinv_tscalar(tscalar)
	% checked
	tscalar = fftn(tscalar);
	pos = find(tscalar(:) == 0);
	myreslt = ones(size(tscalar) ) ./ tscalar;
	myreslt(pos) = 0;
	myreslt = ifftn(myreslt);

end

