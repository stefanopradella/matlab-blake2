function z = add64(x, y)
% ADD64 add uint64 values with 64-bit wrapping behavior

    arguments
        x   (:, 1)  uint64
        y   (:, 1)  uint64
    end

    base = 4294967296;
    mask = uint64(base - 1);

    xLo = bitand(x, mask);
    yLo = bitand(y, mask);
    loSum = double(xLo) + double(yLo);
    carry = loSum >= base;
    lo = uint64(loSum - double(carry) * base);

    xHi = bitshift(x, -32);
    yHi = bitshift(y, -32);
    hiSum = double(xHi) + double(yHi) + double(carry);
    hi = uint64(hiSum - floor(hiSum / base) * base);

    z = bitor(bitshift(hi, 32), lo);

end
