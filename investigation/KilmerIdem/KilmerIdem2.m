function KilmerIdem2
	clear; close all; clc;
	tsize = [3, 1];

	liaoliang = [];
	for index = 1: 9999
		index
		tscalar = fftn(randn(tsize));
		liaoliang = [liaoliang, tscalar(:)];
	end

	rank(liaoliang)

	base = orth(liaoliang)
	whos base

	base' * base

	base * randn(3, 1)	


end