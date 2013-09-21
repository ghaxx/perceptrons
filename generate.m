function [P T] = generate(num, x, h)
	w = width(h);
	S.S(:, 1:num) = randn(2, num) / x;
    S.S(2, 1:num) = S.S(2, 1 : num) + h;
    
	S.S(:, num+1 : 2*num) = randn(2, num) / x;
    S.S(1, num+1 : 2*num) = S.S(1, num+1 : 2*num) + w;
    S.S(2, num+1 : 2*num) = S.S(2, num+1 : 2*num) - h;
	
    S.S(:, 2*num+1 : 3*num) = randn(2, num)/x;
    S.S(1, 2*num+1 : 3*num) = S.S(1, 2*num+1 : 3*num) - w;
    S.S(2, 2*num+1 : 3*num) = S.S(2, 2*num+1 : 3*num) - h;
	
	T1 = [ones(1, num) zeros(1, num) zeros(1, num)];
	T2 = [zeros(1, num) ones(1, num) zeros(1, num)];
	T3 = [zeros(1, num) zeros(1, num) ones(1, num)];
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	S.T = cat(1, T1, T2, T3);
	P = S.S;
	T = S.T;
return 

function w = width(h)
	w = 2*h / (3^0.5);
return