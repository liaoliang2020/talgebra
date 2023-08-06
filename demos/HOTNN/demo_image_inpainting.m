    clear; close all; clc;
	
	global neighborhood_size;
	global row_num;
	global col_num;
	global fra_num;

	neighborhood_size = [3 3  ];
	row_num = 321;
	col_num = 481;
	fra_num = 3; 
   
    current_dir = pwd;
	data_dir = sprintf('%s\\%s', current_dir, 'data');
    save_dir = sprintf('%s\\%s', current_dir, 'result');
    
    haixing = double(imread('testimg.jpg'));
    haixing=haixing/255;
    maxP = max(abs(haixing(:)));

    haixing_extended = load_data(data_dir, 'testimg_extended_less');
    assert(isequal(size(haixing_extended), [prod(neighborhood_size) * row_num * col_num, fra_num]  ));
    haixing_extended=reshape(haixing_extended,[neighborhood_size,row_num,col_num,fra_num]);
    haixing_extended=haixing_extended/255;
    
    M=haixing_extended;
    [n1,n2,n3,n4,n5] = size(M);
    omega = find(M);

    M2=permute(M,[1,2,3,5,4]);
    omega2 = zeros(n1,n2,n3,n4,n5);
    Iones = ones(n1,n2,n3,n4,n5);
    omega2(omega) = Iones(omega);
    omega2=permute(omega2,[1,2,3,5,4]);
    omega2 = find(omega2==1);
   
    tic
	[X_complete] = lrtc_hotnn(M2,omega2);
    toc
    X_complete = max(X_complete,0);
    X_complete = min(X_complete,maxP);
    assert(isequal(size(X_complete), [neighborhood_size, row_num, fra_num, col_num]));
    X_complete=permute(X_complete,[1,2,3,5,4]);
    
    X_complete = reshape(X_complete, prod(neighborhood_size), []);
    X_complete = X_complete(5, :);
    X_complete = reshape(X_complete, [row_num, col_num, fra_num]);
  
    M= reshape(M, prod(neighborhood_size), []);
    M = M(5, :);
    M = reshape(M, [row_num, col_num, fra_num]);

    psnr = PSNR(haixing,X_complete, maxP)
   
    
    figure(1)
    subplot(1,3,1)
    imshow(haixing)
    subplot(1,3,2)
    imshow(M)
    subplot(1,3,3)
    imshow( X_complete)