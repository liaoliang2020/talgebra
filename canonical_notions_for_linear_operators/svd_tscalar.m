function [U, S, V] = svd_tscalar(tscalar)
	% This function computes the canonical SVD of a tscalar
	
	tsize = size(tscalar);

	V = zeros([prod(tsize), prod(tsize) ]);
	U = zeros([prod(tsize), prod(tsize) ]);

	S = sort(reshape(abs(fftn(tscalar) ), [], 1), 'descend');
	[matrixU, ~, matrixV] = svd(tscalar2matrix(tscalar));

	coefficient_vector = ones(1, prod(tsize));
	for k = 1: prod(tsize)
		assert(numel(find(abs(matrixV(:, k)) == 1)) == 1 );

		V(:, k) = reshape(ifftn(reshape(abs(matrixV(:, k)), tsize)), [], 1); 

		if norm(matrixV(:, k) - abs(matrixV(:, k))) > 1e-6
			coefficient_vector(k) = -1;
		end	

	end

	V = reshape(V, [tsize, prod(tsize)] );
	matrixU = matrixU * diag(coefficient_vector);

	for k = 1: prod(tsize)		
		U(:, k) = reshape(ifftn(reshape(matrixU(:, k), tsize)), [], 1);
	end

	U = reshape(U, [tsize, prod(tsize)]);


	%-------check
	% U = reshape(U, [prod(tsize), prod(tsize)]);
	% V = reshape(V, [prod(tsize), prod(tsize)]);



	% checkresult = 0;
	% for k = 1: prod(tsize)
	% 	Uk = reshape(U(:, k), tsize);
	% 	Vk = reshape(V(:, k), tsize);

	% 	checkresult = checkresult + S(k) * tproduct(Uk, tconj_tscalar(Vk));
	% end

	% norm(checkresult(:) - tscalar(:))

end