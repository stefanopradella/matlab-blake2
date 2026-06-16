function t = incrementCounter(t, n)
% INCREMENTCOUNTER Increment the byte counter handling carry

    arguments
        t   (2, 1)  {mustBeNumeric}
        n   (1, 1)  {mustBeNumeric}
    end

    t(1) = t(1) + n;

    % Check for overflow and eventually add carry
    if t(1) < n
        t(2) = t(2) + 1;
    end
end