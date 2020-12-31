function sub_vector = myind2sub(tsize, index)
	assert(isequal(tsize', tsize(:)));	 
	assert(ismember(index, 1: prod(tsize)));
	
	sub_vector = [];
	quotient = index - 1;
	for order_index = 1: numel(tsize)
		[remainder, quotient] = myreminder(quotient, tsize(order_index)	);	
		sub_vector = [sub_vector, remainder];
	end

	sub_vector = sub_vector + 1;

	%-----------------------------------
	function [remainder, quotient] = myreminder(dividend, divisor)
		remainder = rem(dividend, divisor);
		quotient  = fix(dividend / divisor);
	end
	%-----------------------------------
end

%---------------------------------
% The following lines are okay, but not flexible.
% function sub_vector = myind2sub(tsize, index)
% 	assert(isequal(tsize', tsize(:)));	

% 	switch numel(tsize)
% 	  	case 1
% 	  		sub_vector = [index, 1]; 
% 	  	case 2
% 	  		[sub1, sub2] = ind2sub(tsize, index);
% 	  		sub_vector = [sub1, sub2]; 
% 	  	case 3
% 	  		[sub1, sub2, sub3] = ind2sub(tsize, index);
% 	  		sub_vector = [sub1, sub2, sub3];
% 	  	case 4
% 	  		[sub1, sub2, sub3, sub4] = ind2sub(tsize, index);
% 	  		sub_vector = [sub1, sub2, sub3, sub4];
% 	  	case 5
% 	  		[sub1, sub2, sub3, sub4, sub5] = ind2sub(tsize, index);
% 	  		sub_vector = [sub1, sub2, sub3, sub4, sub5];
% 	  	case 6
% 	  		[sub1, sub2, sub3, sub4, sub5, sub6] = ind2sub(tsize, index);
% 	  		sub_vector = [sub1, sub2, sub3, sub4, sub5, sub6];
% 	  	case 7
% 	  		[sub1, sub2, sub3, sub4, sub5, sub6, sub7] = ind2sub(tsize, index);
% 	  		sub_vector = [sub1, sub2, sub3, sub4, sub5, sub6, sub7];
% 	  	case 8
% 	  		[sub1, sub2, sub3, sub4, sub5, sub6, sub7, sub8] = ind2sub(tsize, index);
% 	  		sub_vector = [sub1, sub2, sub3, sub4, sub5, sub6, sub7, sub8];
% 	  	otherwise
% 	  		assert(false)
% 	  end  
% end