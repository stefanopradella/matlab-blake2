function z = add32(x, y)
% ADD32 add uint32 values with 32-bit wrapping behavior

    arguments
        x   (:, 1)  uint32
        y   (:, 1)  uint32
    end

    mask = uint64(0xFFFFFFFF);

    z = uint32(bitand(uint64(x) + uint64(y), mask));
end
