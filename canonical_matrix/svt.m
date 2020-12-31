function approximate_matrix = svt(matrix, tau)
	% this function computes the Singular Value Thresholding of a canonical matrix

	assert(ismatrix(matrix) & isscalar(tau));
	assert(tau >= 0);
	[U, S, V] = svd(matrix, 'econ');
	S = S - tau;
	pos = find(S <= 0);
	S(pos) = 0;

	% S = wthresh(S, 's', tau);  

	approximate_matrix = U * S * V';
end