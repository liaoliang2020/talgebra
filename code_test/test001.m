function test001
	clear; close all; clc;

	for i = 1: 999
		disp(i);
		test001_sub;
	end

end

function test001_sub
	tsize = [3, 3];
	x = randn(tsize);
	y = randn(tsize);
	z = randn(tsize);

	alpha1 = randn(1);
	alpha2 = randn(1);

	%---------------------------
	right_distributivity = new_tproduct(x + y, z) - (new_tproduct(x, z) + new_tproduct(y, z)); 
	assert(norm(right_distributivity(:)) < 1e-6 );

	%---------------------------
	left_distributivity = new_tproduct(z, x + y) - (new_tproduct(z, x) + new_tproduct(z, y)); 
	assert(norm(left_distributivity(:)) < 1e-6 );

	%---------------------------
	compatibility_with_scalars = new_tproduct(alpha1 * x, alpha2 * y) - (alpha1 * alpha2) * new_tproduct(x, y);
	assert(norm(compatibility_with_scalars(:)) < 1e-6 );	



end