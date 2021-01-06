function myimag = timg_part_tscalar(tscalar)
	% this function compute the imginary part of a tscalar
	% checked
	% This function is optimzied by liaoliang on 11-22-2018
	% this function is optimized by liaoliang on 11-22-2018 for the second time.

	% tic;
	% [mynorm, myangle] = tnorm_angle(tscalar);
	% myimag = tsin(myangle);
	% myimag = tproduct(myimag, mynorm);
	% toc;

	% myimag = (tscalar - tconj(tscalar)) * (-0.5i);

	myimag = ifftn(imag(fftn(tscalar)));

end