function realmatrix = quaternion2realmatrix(quaternion_num)
	assert(isequal(class(quaternion_num), 'quaternion') );
	assert(isequal(size(quaternion_num), [1 1]));

	my_p = compact(quaternion_num);
	
	realmatrix = [my_p(1), -1*my_p(2), -1*my_p(3),  -1*my_p(4); ...
			my_p(2), my_p(1), -1*my_p(4), my_p(3); ...
			my_p(3), my_p(4), my_p(1), -1*my_p(2); ...
			my_p(4), -1*my_p(3), my_p(2), my_p(1)  ];	
	
end

