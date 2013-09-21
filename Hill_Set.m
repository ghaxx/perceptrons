function [p t] = XOR_Set
    p = [];
    s = 3;
    for i=-s:s
        for j=-s:s
            p = cat(2, p, [i j]');
        end
    end
    p
	tmp = [
        0 0 0 0 0 0 0 
        0 0 0 0 0 0 0
        0 0 0 0 0 0 0
        0 0 0 1 1 0 0
        0 0 0 0 1 0 0
        0 0 0 0 0 0 0
        0 0 0 0 0 0 0
        ];
    t = [];
    for i = 1:size(tmp, 1)
        t = cat(2, t, tmp(i, :));
    end
    t
end