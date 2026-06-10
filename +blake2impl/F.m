function h = F(h, m, t, f, params)
% Compression function F, RFC 7693 - 3.2

    arguments
        h       (8, 1)  uint64
        m       (16, 1) uint64
        t       (2, 1)  uint64
        f       (1, 1)  logical
        params  (1, 1)  struct
    end

    v           =   zeros(16, 1, 'uint64');
    v(1:8)      =   h;
    v(9:16)     =   blake2impl.Constants.IV;

    v(13)       =   bitxor(v(13), t(1));
    v(14)       =   bitxor(v(14), t(2));

    % If last block, invert bits
    if f
        v(15) = bitxor(v(15), intmax('uint64'));
    end

    sigma = blake2impl.Constants.Sigma;
    r     = params.r;
    R     = params.R;

    for i = 1:r
        v = blake2impl.G(v, 1, 5, 9,  13, m(sigma(i, 1)), m(sigma(i, 2)), R);
        v = blake2impl.G(v, 2, 6, 10, 14, m(sigma(i, 3)), m(sigma(i, 4)), R);
        v = blake2impl.G(v, 3, 7, 11, 15, m(sigma(i, 5)), m(sigma(i, 6)), R);
        v = blake2impl.G(v, 4, 8, 12, 16, m(sigma(i, 7)), m(sigma(i, 8)), R);

        v = blake2impl.G(v, 1, 6, 11, 16, m(sigma(i, 9)), m(sigma(i, 10)), R);
        v = blake2impl.G(v, 2, 7, 12, 13, m(sigma(i, 11)),m(sigma(i, 12)), R);
        v = blake2impl.G(v, 3, 8, 9,  14, m(sigma(i, 13)),m(sigma(i, 14)), R);
        v = blake2impl.G(v, 4, 5, 10, 15, m(sigma(i, 15)),m(sigma(i, 16)), R);
    end

    h(1:8) = bitxor(h(1:8), bitxor(v(1:8), v(9:16)));
end