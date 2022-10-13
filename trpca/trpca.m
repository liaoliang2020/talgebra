function [tmatrix_with_low_rank, sparse_tmatrix] = trpca(tmatrix, lambda, tsize, opts)
	% This function generalize LU's 2020 TAMI paper "Tensor Robust Principal Component Analysis with a New Tensor Nuclear Norm" 
	% when using higher-order t-scalars

	% refrence: C. Lu, J. Feng, Y. Chen, W. Liu, Z. Lin and S. Yan, 
	% "Tensor Robust Principal Component Analysis with a New Tensor Nuclear Norm," 
	% in IEEE Transactions on Pattern Analysis and Machine Intelligence, 
	% vol. 42, no. 4, pp. 925-938, 1 April 2020, doi: 10.1109/TPAMI.2019.2891760.

	assert(nargin == 4);
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);
	
	assert(isequal(class(lambda), 'double')); 
	assert(isscalar(lambda) | isempty(lambda));
	
	%----------------------------------------------------------------
	max_iteration_num = 500;
	mu = 1e-4;
	tol = 1e-5; 
	rho = 1.1;
	max_mu = 1e10;
	DEBUG = true;
		
	if isfield(opts, 'max_iteration_num')	max_iter = opts.max_iteration_num;    	end
	if isfield(opts, 'mu')          		mu = opts.mu;                			end
	if isfield(opts, 'tol')					tol = opts.tol;              			end
	if isfield(opts, 'rho')         		rho = opts.rho;              			end
	if isfield(opts, 'max_mu')      		max_mu = opts.max_mu;        			end
	if isfield(opts, 'DEBUG')       		
		assert(opts.DEBUG == true | opts.DEBUG == false);
		DEBUG = opts.DEBUG;          			
	end
	%----------------------------------------------------------------

	if isempty(lambda)
		lambda = 1 / sqrt(max(row_num, col_num) * prod(tsize) );
	end 

	%-------------------------
	L = zeros(size(tmatrix));
	S = zeros(size(tmatrix));
	Y = zeros(size(tmatrix));

	for iter = 1 : max_iteration_num
		L_old = L;
  		S_old = S;
  		Y_old = Y;

  		%update L
    	tau = 1 / mu;
    	B = tmatrix - S - Y / mu;    	    	
    	L = tsvt(B, tau, tsize);  	
		assert(norm(real(L(:)) - L(:)) < 1e-6); 
		L = real(L); 

		%update S
    	B = tmatrix - L - Y / mu;
    	S = max(0, B - lambda / mu) + min(0, B + lambda / mu);

    	%update Y
    	Y = Y + mu * (L + S - tmatrix);
    	mu = min(rho * mu, max_mu);

    	dL = max(abs(L(:) - L_old(:)));
    	dS = max(abs(S(:) - S_old(:)));
    	dY = max(abs(L(:) + S(:) - tmatrix(:)));
    	
    	if DEBUG
    		fprintf('iteration_index = %05d \t dL = %f \t dS = %f dY = %f \n', iter, dL, dS, dY); 
    	end

    	if max([dL, dS, dY]) < tol
    		break;
    	end

	end%for iter = 1 : max_iteration_num

	tmatrix_with_low_rank = L;
	sparse_tmatrix = tmatrix - tmatrix_with_low_rank;

end