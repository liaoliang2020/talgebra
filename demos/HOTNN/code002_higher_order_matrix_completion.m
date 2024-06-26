function code002_higher_order_matrix_completion
	clear; close all; clc;

	neighborhood_size = [3, 3];
	row_num = 321;
	col_num = 481;
	fra_num = 3;
	
   

	current_dir = pwd;
	data_dir = sprintf('%s\\%s', current_dir, 'data');
    save_dir = sprintf('%s\\%s', current_dir, 'result');
    
    file_name = sprintf('%s\\%s', data_dir, 'testimg.jpg');
	color_img_ground_truth = double(imread(file_name));
    assert(all(ismember([min(color_img_ground_truth(:)), max(color_img_ground_truth(:))], 0:255)));

    color_img_ground_truth = color_img_ground_truth / max(color_img_ground_truth(:) );
    maxP=max(abs(color_img_ground_truth(:)));


    higher_order_img = load_data(data_dir, 'higher_order_testimg_with_missing_entries');
    assert(isequal(size(higher_order_img), [prod(neighborhood_size)*row_num*col_num,fra_num]));
    higher_order_img=reshape(higher_order_img,[neighborhood_size,row_num,col_num,fra_num]);
    
    higher_order_img = higher_order_img / max(higher_order_img(:) );
		
    M=higher_order_img;
    [n1,n2,n3,n4,n5]=size(M);
    omega = find(M>0); 
    
    M2=permute(M,[1,2,3,5,4]);
    omega2=zeros(n1,n2,n3,n4,n5);
    Iones=ones(n1,n2,n3,n4,n5);
    omega2(omega)=Iones(omega);
    omega2=permute(omega2,[1,2,3,5,4]);
    omega2=find(omega2==1);
    
    
    [complete_higher_order_array, rank_norm_info] = higher_order_array_completion(M2, omega2); 
	assert(isequal(size(complete_higher_order_array), [ neighborhood_size, row_num, fra_num,col_num]) ); 

	complete_higher_order_array = max(complete_higher_order_array, 0);
	complete_higher_order_array = min(complete_higher_order_array, maxP);

	complete_higher_order_array = permute(complete_higher_order_array, [1 2 3 5 4]);
	assert(isequal(size(complete_higher_order_array), [neighborhood_size, row_num, col_num, fra_num]) ); 

	complete_higher_order_array = reshape(complete_higher_order_array, [prod(neighborhood_size), row_num, col_num, fra_num] ); 
	color_img_completed = complete_higher_order_array(5, :, :, :); 
	color_img_completed = reshape(color_img_completed, [row_num, col_num, fra_num]);
    
    M= reshape(M, prod(neighborhood_size), []);
    M = M(5, :);
    M = reshape(M, [row_num, col_num, fra_num]);


    psnr = PSNR(color_img_ground_truth, color_img_completed, 1)
  
    
    disp(rank_norm_info.max_rank);
    disp(rank_norm_info.mean_rank);
    disp(rank_norm_info.trace_rank);
    disp(rank_norm_info.trace_norm_of_tmatrix);
    
    figure(1)
    subplot(1,3,1)
    imshow(color_img_ground_truth)
    subplot(1,3,2)
    imshow(M)
    subplot(1,3,3)
    imshow(color_img_completed)

	
	
end

function [complete_higher_order_array,rank_norm_info] = higher_order_array_completion(higher_order_img, omega_index) 
	assert(ndims(higher_order_img) == 5);
	assert(all(ismember(omega_index, 1: numel(higher_order_img))) );

	mu = 1e-4;
	tol = 1e-8; 
	rho = 1.1;
	max_iter = 500;
	max_mu = 1e10;

	L = zeros(size(higher_order_img));
    L(omega_index) = higher_order_img(omega_index);
	
	S = zeros(size(higher_order_img));
	Y = zeros(size(higher_order_img));

	for iter = 1 : max_iter		
		fprintf('iter = %05d\n', iter);

		L_old = L;
  		S_old = S;
  		

  		%update L
    	tau = 1 / mu;
    	B = higher_order_img - S + (Y / mu);
    
    	[L, max_rank_by_kilmer, mean_rank_by_lucanyi, trace_rank_by_liaoliang, trace_norm_of_tmatrix] = TSVT(B, tau);

    	%update S
    	S = higher_order_img - L + (Y / mu);
    	S(omega_index) = 0;

    	%update Y
    	dY = higher_order_img - L - S;
    	Y = Y + mu * dY;
    	mu = min(rho * mu, max_mu);   

        dL = max(abs(L(:) - L_old(:)));
    	dS = max(abs(S(:) - S_old(:)));
    	chg = max([dL, dS, max(abs(dY(:)))]);

    	if chg < tol
    		break;
        end	
    
	end%for iter = 1 : max_iter	

	complete_higher_order_array = L;
    rank_norm_info.max_rank  = max_rank_by_kilmer; 
	rank_norm_info.mean_rank = mean_rank_by_lucanyi; 
	rank_norm_info.trace_rank = trace_rank_by_liaoliang;
	rank_norm_info.trace_norm_of_tmatrix = trace_norm_of_tmatrix;

end


%-----------
function [multiway_array_TSVT, max_rank_by_kilmer, mean_rank_by_lucanyi, trace_rank_by_liaoliang, trace_norm_of_tmatrix] = TSVT(multiway_array, tau)
	neighborhood_size = [3, 3];
	row_num = 321;
	col_num = 481;
	fra_num = 3;	

	assert(ndims(multiway_array) == 5); 
	assert(isequal(size(multiway_array), [ neighborhood_size, row_num, fra_num,col_num] )); 
	assert(tau > 0); 
	
	tsize = [col_num, neighborhood_size];
	multiway_array = permute(multiway_array, [5 1 2 3 4]);
    assert(isequal(size(multiway_array), [col_num, neighborhood_size, row_num, fra_num]) );		
		
	

	multiway_array = fft(multiway_array, [], 1);
	multiway_array = fft(multiway_array, [], 2);
	multiway_array = fft(multiway_array, [], 3);


	tmatrix_row_num = size(multiway_array, numel(tsize) + 1);
	tmatrix_col_num = size(multiway_array, numel(tsize) + 2);

	multiway_array = reshape(multiway_array, prod(tsize), tmatrix_row_num, tmatrix_col_num);

	%------
	max_rank_by_kilmer = 0;
	mean_rank_by_lucanyi = 0;
	trace_rank_by_liaoliang = 0;
	trace_norm_of_tmatrix = 0;
	%------

	multiway_array_TSVT = [];

	for index = 1: prod(tsize)


		this_slice = multiway_array(index, :, :);
		this_slice = reshape(this_slice, tmatrix_row_num, tmatrix_col_num);
		[approximate_matrix, trace_norm] = svt(this_slice, tau);

		trace_norm_of_tmatrix = trace_norm_of_tmatrix + trace_norm;

		matrix_rank_this_slice = rank(approximate_matrix);
		max_rank_by_kilmer = max(max_rank_by_kilmer, matrix_rank_this_slice);
		trace_rank_by_liaoliang = trace_rank_by_liaoliang + matrix_rank_this_slice;

		multiway_array_TSVT = [multiway_array_TSVT, approximate_matrix(:)];

	end%for index = 1: prod(tsize)
	mean_rank_by_lucanyi = trace_rank_by_liaoliang / prod(tsize);

	multiway_array_TSVT = permute(multiway_array_TSVT, [2, 1]);

	multiway_array_TSVT = reshape(multiway_array_TSVT, [tsize, tmatrix_row_num, tmatrix_col_num]);

	multiway_array_TSVT = ifft(multiway_array_TSVT, [], 1);
	multiway_array_TSVT = ifft(multiway_array_TSVT, [], 2);
	multiway_array_TSVT = ifft(multiway_array_TSVT, [], 3);

	if norm(imag(multiway_array_TSVT(:))) < 1e-6
        multiway_array_TSVT = real(multiway_array_TSVT);
    end  

 
	assert(isequal(size(multiway_array_TSVT), [col_num, neighborhood_size, row_num, fra_num]) );				
	multiway_array_TSVT = permute(multiway_array_TSVT, [2 3 4 5 1]);
    assert(isequal(size(multiway_array_TSVT), [neighborhood_size, row_num, fra_num,col_num] )) 

end%function [multiway_array_TSVT, max_rank_by_kilmer, mean_rank_by_lucanyi, trace_rank_by_liaoliang, trace_norm_of_tmatrix] = TSVT(multiway_array, tau, if_permute_index)



%-----------
function [approximate_matrix, trace_norm] = svt(matrix, tau)
	% this function computes the Singular Value Thresholding of a canonical matrix
	assert(ismatrix(matrix) & isscalar(tau));
	assert(tau >= 0);

   
	[U, S, V] = svd(matrix, 'econ');
    
	S = max(0, S - tau);
    trace_norm = trace(S);
	approximate_matrix = U * S * V';
end





