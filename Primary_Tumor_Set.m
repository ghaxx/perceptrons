function [p t] = Primary_Tumor_Set
	fid = fopen('primary-tumor.data');
 	C = textscan(fid, '%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d', 'delimiter', ',');
	size_ans = size(C{1});
	t = zeros(22, size_ans(1));
	for i=1:size_ans(1)
		t(C{1}(i), i) = 1;
	end
	
	p = zeros(17, size_ans(1));
	for i=2:18
		for j=1:size_ans(1)
			p(i-1, j) = C{i}(j);
		end
	end
	
end