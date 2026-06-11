function digest = blake2(d, ll, kk, nn, params)
% BLAKE2 compute function, RFC 7693 - 3.3

    arguments
        d                   (:, :)  uint64  % Data matrix, size [params.bb x dd]
        ll, kk, nn          (1, 1)  uint64
        params              (1, 1)  struct
    end

    dd      =   size(d, 2);
    t       =   zeros(2, 1, 'uint64');          % Counter
    h       =   blake2impl.Constants.IV;

    % Parameter block p[0]
    h(1)    =   bitxor(h(1), 0x0000000001010000);
    h(1)    =   bitxor(h(1), bitshift(kk, 8));
    h(1)    =   bitxor(h(1), nn);

    % Process padded key and data blocks
    for blockIndex = 1:(dd - 1)
        t = blake2impl.incrementCounter(t, params.bb);
        h = blake2impl.F(h, d(:, blockIndex), t, false, params);
    end

    % Final block
    t = blake2impl.incrementCounter(t, mod(ll, (dd-1)*params.bb));
    h = blake2impl.F(h, d(:, dd), t, true, params);

    digest = typecast(h(end-(nn/8)+1:end), 'uint8');
end