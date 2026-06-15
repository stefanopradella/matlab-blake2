function hex = bytesToHex(bytes)

    arguments
        bytes   (:, 1)  uint8
    end
    hex = reshape(dec2hex(bytes, 2)', 1, []);
end