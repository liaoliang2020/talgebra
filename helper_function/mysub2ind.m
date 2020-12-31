function index = mysub2ind(tsize, subvector)
	assert(isequal(tsize', tsize(:)));	
	assert(isequal(subvector', subvector(:)));	

	w = [];
	for i = 1: (numel(tsize) - 1)
		w = [w, prod(tsize(1: i)  )]; 
	end
	w = [1, w];

	index = dot(w, subvector - 1) + 1;

	assert(ismember(index, 1: prod(tsize)));
	

end