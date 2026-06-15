function z = add64(x, y)
% ADD64 add uint64 values with 64-bit wrapping behavior

    arguments
        x   (:, 1)  uint64
        y   (:, 1)  uint64
    end

    mask = uint64(0xFFFFFFFF);

    xLo = bitand(x, mask);
    yLo = bitand(y, mask);

    loSum = xLo + yLo;
    carry = loSum > mask;
    lo = bitand(loSum, mask);

    xHi = bitshift(x, -32);
    yHi = bitshift(y, -32);

    hiSum = xHi + yHi + uint64(carry);
    hi = bitand(hiSum, mask);

    z = bitor(bitshift(hi, 32), lo);
end
