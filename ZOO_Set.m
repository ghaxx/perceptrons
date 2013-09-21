function [p t] = ZOO_Set
	fid = fopen('zoo.data');
 	C = textscan(fid, '%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d', 'delimiter', ',');
	size_ans = size(C{18});
	t = zeros(7, size_ans(1));
	for i=1:size_ans(1)
		t(C{18}(i), i) = 1;
	end
	
	p = zeros(16, size_ans(1));
	for i=2:17
		for j=1:size_ans(1)
			p(i, j) = C{i}(j);
		end
	end
	
end