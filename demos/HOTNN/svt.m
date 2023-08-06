function [approximate_matrix,tnn] = svt(matrix, tau)
	% this function computes the Singular Value Thresholding of a canonical matrix

	assert(ismatrix(matrix) & isscalar(tau));
	assert(tau >= 0);
    
	[U, S, V] = svd(matrix, 'econ');
    
	S = max(0, S - tau);
    tnn=trace(S);

	approximate_matrix = U * S * V';
end