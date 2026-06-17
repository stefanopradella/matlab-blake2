function z = mul32(x, y)
% MUL32 multiply uint32 values with 32-bit wrapping behavior

    arguments
        x   (:, 1)  uint32
        y   (:, 1)  uint32
    end

    mask = uint64(0xFFFFFFFF);

    z = uint32(bitand(uint64(x) .* uint64(y), mask));
end
