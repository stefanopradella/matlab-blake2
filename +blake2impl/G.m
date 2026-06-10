function v = G(v, a, b, c, d, x, y, R)
% Mixing function G, RFC 7693 - 3.1
% BLAKE2b rotation constants are hardcoded

    arguments
        v                   (16, 1) uint64
        a, b, c, d          (1, 1)  uint8
        x, y                (1, 1)  uint64
        R                   (4, 1)  uint8
    end

    v(a) = blake2impl.add64(v(a), v(b));
    v(a) = blake2impl.add64(v(a), x);
    v(d) = bitxor(v(d), v(a));
    v(d) = blake2impl.ror64(v(d), R(1));

    v(c) = blake2impl.add64(v(c), v(d));
    v(b) = bitxor(v(b), v(c));
    v(b) = blake2impl.ror64(v(b), R(2));

    v(a) = blake2impl.add64(v(a), v(b));
    v(a) = blake2impl.add64(v(a), y);
    v(d) = bitxor(v(d), v(a));
    v(d) = blake2impl.ror64(v(d), R(3));

    v(c) = blake2impl.add64(v(c), v(d));
    v(b) = bitxor(v(b), v(c));
    v(b) = blake2impl.ror64(v(b), R(4));
end