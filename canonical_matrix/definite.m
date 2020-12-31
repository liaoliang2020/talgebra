function [postive_def, postive_semi_def, negative_def, negative_semi_def, indef] = definite(matrix)
	% this function determines the definitness of a Hermetian matrix

	
	assert(ishermitian(matrix));
	
	%---------------------
	postive_def = false;
	negative_def = false;	

	postive_semi_def = false;
	negative_semi_def = false;
	indef = false;
	%--------------

	isdetermined = false;
	e = eig(matrix);
	if all(e > 0) 
		postive_def = true; 
		isdetermined = true;
		
	end

	if all(e < 0) 
		negative_def = true; 
		isdetermined = true;
		
	end
	
	
	if all(e >= 0) & any(e == 0) 
		postive_semi_def = true;
		isdetermined = true;
		
	end

	if all(e <= 0) & any(e == 0) 
		negative_semi_def = true;
		isdetermined = true;
		
	end

	if isdetermined ==  false
		indef = true;
	end

end

