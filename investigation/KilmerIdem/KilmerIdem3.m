function KilmerIdem3
	clear; close all; clc;
	tsize = [3, 3];

	% Q1 = zeros(tsize);  Q1(1, 1) = 1;
	% Q2 = zeros(tsize);  Q2(2, 1) = 1;  Q2(3, 1) = 1;
	% Q3 = zeros(tsize);  Q3(1, 2) = 1;  Q3(1, 3) = 1;
	% Q4 = zeros(tsize);  Q4(2, 2) = 1;  Q4(3, 3) = 1;
	% Q5 = zeros(tsize);  Q5(2, 3) = 1;  Q5(3, 2) = 1;

	% Q1 = ifftn(Q1)
	% Q2 = ifftn(Q2)
	% Q3 = ifftn(Q3)
	% Q4 = ifftn(Q4)
	% Q5 = ifftn(Q5)

	% tscalar = randn(tsize);
	
	% liaoliang = [Q1(:), Q2(:), Q3(:), Q4(:), Q5(:)];
	% round(liaoliang' * liaoliang, 3)

	% base = randn(7, 3)

	% A = 0.3 * orth(randn(7) + i * randn(7) );
	% % round(A' * A, 4) 

	% base2 = A * randn(7, 3)	

	% base3 = [real(base2); imag(base2)] 



	% % orth(base) * ctranspose(orth(base)) - 

	% rank(orth(base2) *  ctranspose(orth(base2)))

	% rank(orth(base3) *  ctranspose(orth(base3)))


	liaoliang = eye(7);
	liaoliang = liaoliang(:, 1: 3)

	
	liao = [reshape(real(liaoliang), [], 1),  reshape(imag(liaoliang), [], 1)];
	liao = permute(liao, [2, 1]);
	liao = reshape(liao, [], 3);

	orth(liaoliang) * ctranspose(orth(liaoliang))
	orth(liao) * ctranspose(orth(liao))

	




end