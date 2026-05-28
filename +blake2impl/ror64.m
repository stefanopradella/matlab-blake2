function y = ror64(x, n)
% ROR64 rotate n places to the right with wrap

    arguments
        x   (:, 1)  uint64
        n   (1, 1)  int8
    end

    y = bitor(bitshift(x, -n), bitshift(x, 64 - n));

end