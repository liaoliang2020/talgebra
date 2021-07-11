function matrix = tscalar2matrix(tscalar)
	tscalar = fftn(tscalar);
	matrix = diag(tscalar(:));
end