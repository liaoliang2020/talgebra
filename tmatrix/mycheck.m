function mycheck
	clear; close all; clc;

	tsize = [3, 3];
	tscalar = randn(tsize);


	tic;
	mynorm001 = ifftn(arrayfun(@abs, fftn(tscalar)))
	myangle = ifftn(arrayfun(@angle, fftn(tscalar)))
	toc;


	tic;
	[U, mynorm, ~] = tsvd(tscalar, size(tscalar))
	myangle = -i * ifftn(log(fftn(U)))
	toc;



end