function vector = tscalar2vector(tscalar)
	tscalar = fftn(tscalar);
	vector = tscalar(:);
end

