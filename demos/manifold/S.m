function S
	clear; close all; clc;
	
	liaoliang_collection = [];
	for i = 1: 9999
		liaoliang = randn(10, 1);
		liaoliang(8:10) = 0
		liaoliang_collection = [liaoliang_collection, liaoliang];
	end

	space = orth(liaoliang_collection) *  ctranspose(orth(liaoliang_collection))

	projectx = space * randn(10, 1)

	projecty = (eye(size(space)) -  space) * randn(10, 1)



end