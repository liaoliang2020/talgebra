function KilmerIdem
	clear; close all; clc;
	Y = [0, 1];
	[X1, X2, X3, X4, X5, X6, X7, X8, X9] = ndgrid(Y, Y, Y, ...
		               Y, Y, Y,  Y, Y, Y);


	liaoliang = [X1(:), X2(:), X3(:), X4(:), X5(:), X6(:), X7(:), X8(:), X9(:)];
	
	liaoliang = permute(liaoliang, [2, 1]);
	KilmerIdem_num = 0;
	
	kilmer_idem_collection = [];
	
	index = 0;
	for i = 1: size(liaoliang, 2)
		
		liao = liaoliang(:, i);
		liao_fourier = reshape(liao, [3, 3]);
		liao_space   = ifftn(liao_fourier);

		if norm(liao_space(:) - real(liao_space(:) )) < 1e-6
			liao_fourier
			% liao_space

			index = index + 1;

			% kilmer_idem_collection = [kilmer_idem_collection, liao_fourier(:)];
			% KilmerIdem_num = KilmerIdem_num + 1;

			if index == 1
				kilmer_idem_collection = liao_fourier(:);
			end

			if rank(kilmer_idem_collection) ~= rank([kilmer_idem_collection, liao_fourier(:)] )
			 	kilmer_idem_collection = [kilmer_idem_collection, liao_fourier(:)];
			 	KilmerIdem_num = KilmerIdem_num + 1;
			end


		end
	end  

	KilmerIdem_num

	rank(kilmer_idem_collection)


	kilmer_idem_collection = reshape(kilmer_idem_collection, 3, 3, []);

	for i = 1: size(kilmer_idem_collection, 3)
		kilmer_idem_collection(:, :, i)
	end



	

end