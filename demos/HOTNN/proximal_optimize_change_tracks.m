function [X,tnn,trank] = proximal_optimize_change_tracks(Y, tau)
	
	global neighborhood_size;
	global row_num;
	global col_num;
	global fra_num;

	assert(isequal(neighborhood_size, [3 3 ]));
	assert(ndims(Y) == 5);
	assert(isequal(size(Y), [neighborhood_size, row_num, fra_num, col_num]));
    tsize = [col_num, neighborhood_size];
    
    Y = permute(Y, [  5 1 2 3 4   ]);
    assert(isequal(size(Y), [tsize, row_num, fra_num]	));
	
    Y = fft(Y, [], 1);
	Y = fft(Y, [], 2);
	Y = fft(Y, [], 3);
   
    Y = reshape(Y, prod(tsize), row_num, fra_num);
	
    X = [];
	trank=0;
    tnn=0;
	
	for index = 1: prod(tsize)
		slice = Y(index, :, :);
		slice = reshape(slice, row_num, fra_num);
        [approximate_matrix,tnnx] = svt(slice, tau);
		trank=max(trank,rank(approximate_matrix));
        tnn=tnn+tnnx;
		X = [X, approximate_matrix(:) ];
	end

	X = permute(X, [2 1]);
    X = reshape(X, [tsize, row_num, fra_num]);
    
    X = ifft(X, [], 1);
	X = ifft(X, [], 2);
	X = ifft(X, [], 3);
  
    X = permute(X, [2 3 4 5 1]);
    if norm(imag(X(:))) < 1e-6
        X=real(X);
    end  
    assert(isequal(size(X), [neighborhood_size, row_num, fra_num, col_num] ));