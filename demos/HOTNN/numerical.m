clear;clc;

n = 40;
r = 1; 
p = 0.1;
current_dir = pwd;
data_dir = sprintf('%s\\%s', current_dir, 'data');

global neighborhood_size 
global row_num 
global col_num 
global fra_num

row_num =n;
col_num =n;
fra_num =n;
neighborhood_size=[3 3 ];

  X = tprod(randn(row_num,r,fra_num),randn(r,col_num,fra_num)); 
  omega = find(rand(n*n*n,1)<p);
  M = zeros(n,n,n);
  M(omega) = X(omega);
 
  neighborhood = load_data(data_dir, 'row_num00040_col_num00040_central_neighorhood_layer001_single_index'); 
  assert(numel(neighborhood) == prod([neighborhood_size, row_num, col_num])); 
  M = reshape(M, [row_num * col_num , fra_num] );
  M_extended = [];
  
  for i = 1: fra_num 
      image_this_frame = M(:, i);
      image_this_frame = [image_this_frame(:); 0];
      image_this_frame = image_this_frame(neighborhood);
      M_extended = [M_extended, image_this_frame(:)];
  end 
  assert(isequal(size(M_extended), [prod(neighborhood_size) * row_num * col_num , fra_num]  ));
  M_extended=reshape(M_extended,[neighborhood_size,row_num,col_num,fra_num]);
  
  M_TM=M_extended;
  omega2 = find(M_TM);
  [X_complete] = lrtc_hotnn_numerical(M_TM,omega2);
  X_complete = reshape(X_complete, prod(neighborhood_size), []);
  X_complete = X_complete(5, :);
  X_complete = reshape(X_complete, [row_num, col_num, fra_num]);
  
  RSE = norm(X(:)-X_complete(:))/norm(X(:));

  fprintf('relative recovery error: %.4e\n', RSE);
    
     
     



       

  
    
    
