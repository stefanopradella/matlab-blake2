function v = G(v, a, b, c, d, x, y, R, addFcn, rorFcn)
% Mixing function G, RFC 7693 - 3.1

    arguments
        v                   (16, 1) {mustBeInteger}
        a, b, c, d          (1, 1)  uint8
        x, y                (1, 1)  {mustBeInteger}
        R                   (4, 1)  uint8
        addFcn              (1, 1)  function_handle
        rorFcn              (1, 1)  function_handle
    end

    v(a) = addFcn(v(a), v(b));
    v(a) = addFcn(v(a), x);
    v(d) = bitxor(v(d), v(a));
    v(d) = rorFcn(v(d), R(1));

    v(c) = addFcn(v(c), v(d));
    v(b) = bitxor(v(b), v(c));
    v(b) = rorFcn(v(b), R(2));

    v(a) = addFcn(v(a), v(b));
    v(a) = addFcn(v(a), y);
    v(d) = bitxor(v(d), v(a));
    v(d) = rorFcn(v(d), R(3));

    v(c) = addFcn(v(c), v(d));
    v(b) = bitxor(v(b), v(c));
    v(b) = rorFcn(v(b), R(4));
end