function TPCA
	clear; close all; clc;

	tsize = [3, 3];
	row_num = 7;
	col_num = 5;

	tmatrix = randn([tsize, row_num, col_num]);
	tvector_mean = tmean(tmatrix, 2, tsize);

	
	tmatrix_without_mean = tmatrix - trepmat(tvector_mean, [1, col_num], tsize);


	assert(isequal(size(tmatrix_without_mean), [tsize, row_num, col_num]) );
	
	
	%--------------------------------
	G = tmultiplication(tmatrix_without_mean, tctranspose(tmatrix_without_mean, tsize), tsize);  	

	[TV, ~] = teig(G, tsize);
	TV = tfliplr(TV, tsize);

	[TU, ~, ~]  = tsvd(tmatrix_without_mean, tsize);
	[TU2, ~, ~] = tsvd(G, tsize);

	myrank = 2;
	TV =   TV(:, :, :, 1: myrank);
	TU =   TU(:, :, :, 1: myrank);
	TU2 = TU2(:, :, :, 1: myrank);

	submodule_projection_TV =  tmultiplication(TV, tctranspose(TV, tsize), tsize );		submodule_projection_TV =  round(submodule_projection_TV, 4);
	submodule_projection_TU =  tmultiplication(TU, tctranspose(TU, tsize), tsize );		submodule_projection_TU =  round(submodule_projection_TU, 4);
	submodule_projection_TU2 = tmultiplication(TU2, tctranspose(TU2, tsize), tsize );	submodule_projection_TU2 = round(submodule_projection_TU2, 4); 

	assert(isequal(submodule_projection_TU, submodule_projection_TV) & isequal(submodule_projection_TU, submodule_projection_TU2));

	fprintf('All asserts in this script is passed passed\n');

end
