function plotSet(A)
	hold on
    size_A = size(A);
    y = size_A(2)/3;
    plot(	A(1,1:y),			A(2,1:y),		'dr', 'MarkerSize', 4);
	plot(	A(1,y+1:2*y),		A(2,y+1:2*y),	'dg', 'MarkerSize', 4);
	plot(	A(1,2*y+1:3*y),		A(2,2*y+1:3*y), 'db', 'MarkerSize', 4);
    
    %i = 1;
    %b = (A(i)' * A(i))^-1 * A(i) * y;
    %w1 x + w1 y + b = 0;
    %y = (net.b1 - net.w1(1)*x) / net.w1(2);
        
    %fplot(@(x)(net.w(1, 1) - net.w(1, 2)*x) / net.w(1, 3), [-d d -d d], '-r');
    %fplot(@(x)(net.w(2, 1) - net.w(2, 2)*x) / net.w(2, 3), [-d d -d d], '-g');
    %fplot(@(x)(net.w(3, 1) - net.w(3, 2)*x) / net.w(3, 3), [-d d -d d], '-b');
return