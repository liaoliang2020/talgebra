function result = E_T(tsize)
	assert(isequal(tsize', tsize(:)));
	result = zeros(tsize);
	result(1) = 1;

end