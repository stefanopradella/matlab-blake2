function digest = blake2(d, ll, kk, nn, params)
% BLAKE2 compute function, RFC 7693 - 3.3

    arguments
        d                   (16, :)  {mustBeNumeric}  % Data matrix, size [16 x dd]
        ll                  (1, 1)  double
        kk, nn              (1, 1)  uint8
        params              (1, 1)  struct
    end

    dd      =   size(d, 2);
    t       =   zeros(2, 1, "uint"+num2str(params.w));          % Counter
    h       =   params.IV;

    % Parameter block p[0]
    h(1)    =   bitxor(h(1), cast(0x01010000, 'like', d));
    h(1)    =   bitxor(h(1), bitshift(kk, 8));
    h(1)    =   bitxor(h(1), cast(nn, 'like', h));

    % Process padded key and data blocks
    for blockIndex = 1:(dd - 1)
        t = blake2impl.incrementCounter(t, params.bb);
        h = blake2impl.F(h, d(:, blockIndex), t, false, params);
    end

    % Final block
    t = blake2impl.incrementCounter(t, mod(ll, (dd-1)*params.bb));
    h = blake2impl.F(h, d(:, dd), t, true, params);

    h_bytes = typecast(h, 'uint8');
    digest = h_bytes(end-nn+1:end);
end