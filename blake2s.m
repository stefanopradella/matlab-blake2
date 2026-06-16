function digest = blake2s(inputData, nn, key)
% blake2s - Compute the nn-bytes hash of inputData using BLAKE2s algorithm
% 
% Syntax: 
%   digest = BLAKE2S(inputData)
%   digest = BLAKE2S(inputData, nn)
%   digest = BLAKE2S(inputData, nn, key)
% 
% Input Arguments
%   inputData - Input array
%       string | char array | uint8
%   nn - Digest length in bytes
%       positive integer scalar between 1 and 32 (default)
%   key - Key array, length must be less than or equal to 32
%       string | char array | uint8
% 
% Reference: 
%   https://datatracker.ietf.org/doc/html/rfc7693.html

    arguments
        inputData   (:, 1)  char
        nn          (1, 1)  uint8 {mustBeBetween(nn, 1, 32)}    = 32  
        key         (:, 1)  char = [] 
    end

    ll      = numel(inputData);
    kk      = numel(key);

    % Input validation
    if ~allbetween(kk, 0, 32)
        error("Key size must be between 0 and 64")
    end
    if ~allbetween(ll, 0, 2^128)
        error("Input size must be between 0 and 2^128")
    end

    params  = blake2impl.Constants.BLAKE2s;

    d = blake2impl.bytesToWordVector(inputData, params.w, 16);
    d = [blake2impl.bytesToWordVector(key, params.w, 16), d];

    digest  = blake2impl.bytesToHex(blake2impl.blake2(d, ll, kk, nn, params));
end