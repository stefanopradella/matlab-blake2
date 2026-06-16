function y = ror32(x, n)
% ROR32 rotate n places to the right with wrap

    arguments
        x   (:, 1)  uint32
        n   (1, 1)  int8
    end

    y = bitor(bitshift(x, -n), bitshift(x, 32 - n));

end